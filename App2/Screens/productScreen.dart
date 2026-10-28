import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import 'productDetailsScreen.dart';

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

        itemBuilder:
            (context, index) {

          final product =
          provider.products[index];

          return Card(
            margin:
            const EdgeInsets.all(10),

            elevation: 5,

            child: ListTile(

              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product["imageUrl"] ?? "",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,

                  errorBuilder: (
                      context,
                      error,
                      stackTrace,
                      ) {
                    return const Icon(
                      Icons.shopping_bag,
                      size: 40,
                      color: Colors.blue,
                    );
                  },

                  loadingBuilder: (
                      context,
                      child,
                      loadingProgress,
                      ) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return const SizedBox(
                      width: 60,
                      height: 60,
                      child: Center(
                        child:
                        CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  },
                ),
              ),
              title: Text(
                product["productName"]
                    .toString(),
              ),

              subtitle: Text(
                "\$${product["unitPrice"]}",
              ),

              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ProductDetailsScreen(
                          product: product,
                        ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}