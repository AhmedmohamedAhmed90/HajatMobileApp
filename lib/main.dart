import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hajat_mobile_app/modules/HomeScreen/home_screen.dart';
import 'modules/Cart/cubit/cart_cubit.dart';
import 'modules/Product/cubit/product_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartCubit()..loadCart(), // Cart functionality
        ),
        BlocProvider(
          create: (context) => ProductCubit(), // Product functionality
        ),
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
