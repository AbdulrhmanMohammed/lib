import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() =>
      _ProductScreenState();
}

class _ProductScreenState
    extends State<ProductScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<ProductProvider>(
        context,
        listen: false,
      ).getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider =
    Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),

      body: provider.isLoading
          ? const Center(
        child:
        CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount:
        provider.products.length,

        itemBuilder: (context, index) {

          final product =
          provider.products[index];

          return Card(
            child: ListTile(

              title: Text(
                product["productName"]
                    .toString(),
              ),

              subtitle: Text(
                "\$${product["unitPrice"]}",
              ),
            ),
          );
        },
      ),
    );
  }
}