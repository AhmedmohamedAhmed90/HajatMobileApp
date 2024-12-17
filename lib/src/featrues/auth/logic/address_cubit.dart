import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hajat_mobile_app/src/featrues/auth/logic/auth_cubit.dart';
import 'package:hajat_mobile_app/src/services/api/api_service.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';



part 'address_state.dart';
part 'address_cubit.freezed.dart';

class AddressCubit extends Cubit<AddressState> {
  final api = getIt<ApiService>();
  final authCubit = getIt<AuthCubit>();

  AddressCubit() : super(const AddressState.initial());

  void setAddress(double lat, double lang, String street) async {
    emit(const AddressState.loading());
    try {
      // Call the API to set the address
      await api.setAddress(lat, lang, street);

      // Update the user's address in the auth cubit
      final user = authCubit.state.maybeWhen(
        authenticated: (session) => session.user,
        orElse: () => null,
      );
      if (user != null) {
        final updatedUser = user.copyWith(
          latitude: lat,
          longitude: lang,
          street: street,
        );
        authCubit.updateUser(updatedUser);
      }

      emit(const AddressState.loaded());
    } catch (e) {
      emit(AddressState.error(e.toString()));
    }
  }
}
