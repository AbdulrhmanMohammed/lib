import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/CartProvider.dart';
import '../providers/UserProvider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final dynamic product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final bool outOfStock =
        (product["quantityInStock"] ?? 0) <= 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product["productName"].toString(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius:
                BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.shopping_bag,
                size: 100,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              product["productName"].toString(),
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              "Price: ${product["unitPrice"]} SAR",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Stock: ${product["quantityInStock"]}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: outOfStock
                    ? Colors.red
                    : Colors.green,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              product["description"]
                  ?.toString() ??
                  "No Description",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: outOfStock
                    ? null
                    : () async {
                  try {
                    final userId = context
                        .read<UserProvider>()
                        .Id;

                    await context
                        .read<CartProvider>()
                        .addToCart(
                      userId,
                      product["productID"],
                    );

                    ScaffoldMessenger.of(
                        context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Added To Cart Successfully",
                        ),
                        backgroundColor:
                        Colors.green,
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(
                        context)
                        .showSnackBar(
                      SnackBar(
                        content:
                        Text("Error: $e"),
                        backgroundColor:
                        Colors.red,
                      ),
                    );
                  }
                },
                style:
                ElevatedButton.styleFrom(
                  backgroundColor:
                  outOfStock
                      ? Colors.grey
                      : Colors.indigo,
                  foregroundColor:
                  Colors.white,
                ),
                child: Text(
                  outOfStock
                      ? "Out Of Stock"
                      : "Add To Cart",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}