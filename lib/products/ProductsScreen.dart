import 'package:flutter/material.dart';
import 'package:flutter_application_api/products/Product.dart';
import 'package:flutter_application_api/products/ProductsService.dart';

class ProductsScreen extends StatefulWidget {
  final ProductsService productsService;

  const ProductsScreen({super.key, required this.productsService});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = widget.productsService.getProducts();
  }

  void _reload() {
    setState(() {
      _productsFuture = widget.productsService.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Productos')),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No se pudieron cargar los productos.'),
                  const SizedBox(height: 12),
                  ElevatedButton(onPressed: _reload, child: const Text('Reintentar')),
                ],
              ),
            );
          }

          final products = snapshot.data ?? [];
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product.title),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              );
            },
          );
        },
      ),
    );
  }
}
