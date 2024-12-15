import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hajat_mobile_app/modules/Product/user_product_screen.dart';
import 'modules/HomeScreen/home_screen.dart';
import 'modules/Cart/ui/cart_screen.dart';
import 'modules/Product/product_screen.dart';
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
          create: (context) => ProductCubit(), 
        ),
      ],
      child: MaterialApp(
        title: 'Hajat Mobile App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        initialRoute: '/',

        routes: {
          '/': (context) => HomeScreen(),
          '/cart': (context) => CartScreen(),
          '/products': (context) => AdminProductScreen(), // Admin product screen
          '/all-products': (context) => UserProductScreen(), // User product screen
        },
        // Fallback for undefined routes
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(title: Text('404 - Not Found')),
              body: Center(child: Text('Page not found')),
            ),
          );
        },
      ),
    );
  }
}
