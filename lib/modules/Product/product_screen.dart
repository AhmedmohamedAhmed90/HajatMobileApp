import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product_model.dart';
import 'cubit/product_cubit.dart';

class ProductScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  int? selectedCategoryId; // For category selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductUpdated) {
                  return ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(product.imageUrl),
                        ),
                        title: Text(product.name),
                        subtitle: Text(
                            'Price: \$${product.price} | Quantity: ${product.quantity} | Category ID: ${product.categoryId}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                nameController.text = product.name;
                                priceController.text = product.price.toString();
                                quantityController.text = product.quantity.toString();
                                selectedCategoryId = product.categoryId; // Initialize

                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text('Edit Product'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: nameController,
                                          decoration:
                                              InputDecoration(labelText: 'Name'),
                                        ),
                                        TextField(
                                          controller: priceController,
                                          decoration:
                                              InputDecoration(labelText: 'Price'),
                                          keyboardType: TextInputType.number,
                                        ),
                                        TextField(
                                          controller: quantityController,
                                          decoration:
                                              InputDecoration(labelText: 'Quantity'),
                                          keyboardType: TextInputType.number,
                                        ),
                                        DropdownButtonFormField<int>(
                                          value: selectedCategoryId,
                                          decoration: InputDecoration(
                                              labelText: 'Category ID'),
                                          items: [1, 2, 3, 4] // Example category IDs
                                              .map((id) => DropdownMenuItem(
                                                    value: id,
                                                    child: Text('Category $id'),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            selectedCategoryId = value;
                                          },
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          final updatedProduct = Product(
                                            id: product.id,
                                            name: nameController.text,
                                            price: double.parse(
                                                priceController.text),
                                            imageUrl: product.imageUrl,
                                            quantity: int.parse(
                                                quantityController.text),
                                            categoryId: selectedCategoryId!,
                                          );

                                          context
                                              .read<ProductCubit>()
                                              .editProduct(
                                                  product.id, updatedProduct);
                                          Navigator.pop(context);
                                        },
                                        child: Text('Save'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                context
                                    .read<ProductCubit>()
                                    .deleteProduct(product.id);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Center(child: Text('No Products Available'));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                nameController.clear();
                priceController.clear();
                quantityController.clear();
                selectedCategoryId = null;

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Add Product'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(labelText: 'Name'),
                        ),
                        TextField(
                          controller: priceController,
                          decoration: InputDecoration(labelText: 'Price'),
                          keyboardType: TextInputType.number,
                        ),
                        TextField(
                          controller: quantityController,
                          decoration: InputDecoration(labelText: 'Quantity'),
                          keyboardType: TextInputType.number,
                        ),
                        DropdownButtonFormField<int>(
                          decoration: InputDecoration(labelText: 'Category ID'),
                          items: [1, 2, 3, 4] // Example category IDs
                              .map((id) => DropdownMenuItem(
                                    value: id,
                                    child: Text('Category $id'),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            selectedCategoryId = value;
                          },
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          final newProduct = Product(
                            id: DateTime.now().millisecondsSinceEpoch, // Unique ID
                            name: nameController.text,
                            price: double.parse(priceController.text),
                            imageUrl: 'https://via.placeholder.com/150', // Placeholder image
                            quantity:
                                int.parse(quantityController.text),
                            categoryId: selectedCategoryId!,
                          );

                          context
                              .read<ProductCubit>()
                              .addProduct(newProduct);
                          Navigator.pop(context);
                        },
                        child: Text('Add'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Add Product'),
            ),
          ),
        ],
      ),
    );
  }
}
