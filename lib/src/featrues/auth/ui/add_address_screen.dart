import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hajat_mobile_app/src/featrues/auth/logic/address_cubit.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
import 'package:hajat_mobile_app/src/services/logging/log.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';

@RoutePage()
class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  Position? _currentPosition;
  double lat = 0.0;
  double lang = 0.0;
  AddressCubit addressCubit = AddressCubit();
  late TextEditingController streetController;

  static const CameraPosition _kGooglePlex = CameraPosition(
   target: LatLng(30.0444, 31.2357), // Cairo, Egypt coordinates
  zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    streetController = TextEditingController();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
    streetController.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Location'),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onCameraMove: (position) {
              setState(() {
                lat = position.target.latitude;
                lang = position.target.longitude;
              });
              getIt<Log>().trace('lat: $lat, lang: $lang');
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),
          const Positioned(
            top: 10,
            right: 10,
            bottom: 10,
            left: 10,
            child: Icon(
              Icons.add,
              color: Colors.red,
            ),
          ),
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Consts.borderRadiusM),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 10,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              width: double.infinity,
              padding: Consts.paddingM,
              margin: Consts.paddingM,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Consts.gapM,
                    Text(
                      'Add Address',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Consts.gapL,
                    TextFormField(
                      controller: streetController,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        hintText: 'Add Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Consts.borderRadiusM),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Address is required';
                        }
                        return null;
                      },
                    ),
                    Consts.gapL,
                    SizedBox(
                      width: double.infinity,
                      child: BlocConsumer<AddressCubit, AddressState>(
                        bloc: addressCubit,
                        listener: (context, state) {
                          state.maybeMap(
                            loaded: (_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Address saved successfully'),
                                ),
                              );
                              context.router.maybePop();
                            },
                            error: (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.message),
                                ),
                              );
                            },
                            orElse: () {},
                          );
                        },
                        builder: (context, state) {
                          return state.maybeMap(
                            loading: (_) {
                              return const FilledButton(
                                onPressed: null,
                                child: CircularProgressIndicator(),
                              );
                            }, 
                            orElse: () {
                              return FilledButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (lat == 0 || lang == 0) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Please select a location on the map'),
                                        ),
                                      );
                                      return;
                                    }
                                    getIt<Log>().trace('lat: $lat, lang: $lang');
                                    addressCubit.setAddress(
                                      lat,
                                      lang,
                                      streetController.text,
                                    );
                                  }
                                },
                                child: const Text('Save'),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Consts.gapL,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentLocation() async {
    bool isLocationPermissionGranted = await _handleLocationPermission();
    if (!isLocationPermissionGranted) {
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      lat = _currentPosition!.latitude;
      lang = _currentPosition!.longitude;
    });
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 14.4746)));
  }
}