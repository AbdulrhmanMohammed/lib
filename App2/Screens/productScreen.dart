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
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: provider.isLoading
          ? const Center(
        child:
        CircularProgressIndicator(),
      )
          : Column(
        children: [
          Padding(
            padding:
            const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                provider.searchProducts(
                  value,
                );
              },
              decoration:
              InputDecoration(
                hintText:
                "Search Product...",
                prefixIcon: const Icon(
                  Icons.search,
                ),
                border:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius
                      .circular(
                      12),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount:
              provider.products.length,
              itemBuilder:
                  (context, index) {
                final product =
                provider.products[
                index];

                return Card(
                  margin:
                  const EdgeInsets
                      .symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  elevation: 4,
                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius
                        .circular(
                        15),
                  ),
                  child: ListTile(
                    leading:
                    ClipRRect(
                      borderRadius:
                      BorderRadius
                          .circular(
                          8),
                      child:
                      Image.network(
                        product[
                        "imageUrl"] ??
                            "",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (
                            context,
                            error,
                            stackTrace,
                            ) {
                          return const Icon(
                            Icons
                                .shopping_bag,
                            size: 40,
                            color:
                            Colors
                                .blue,
                          );
                        },
                      ),
                    ),
                    title: Text(
                      product[
                      "productName"]
                          .toString(),
                      style:
                      const TextStyle(
                        fontWeight:
                        FontWeight
                            .bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        Text(
                          "${product["unitPrice"]} SAR",
                        ),
                        Text(
                          "Stock: ${product["quantityInStock"]}",
                          style:
                          const TextStyle(
                            color: Colors
                                .green,
                          ),
                        ),
                      ],
                    ),
                    trailing:
                    const Icon(
                      Icons
                          .arrow_forward_ios,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductDetailsScreen(
                                product:
                                product,
                              ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}