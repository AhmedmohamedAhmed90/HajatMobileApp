import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hajat_mobile_app/src/featrues/brands/models/brand.dart';
import 'package:hajat_mobile_app/src/featrues/products/ui/products.dart';

@RoutePage()
class BrandsDetailsScreen extends StatelessWidget {
  const BrandsDetailsScreen({super.key, required this.brand});
  final Brand brand;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(brand.name),
      ),
      body: Products(brandId: brand.id),
    );
  }
}
