import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/CategoryProvider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() =>
      _CategoryScreenState();
}

class _CategoryScreenState
    extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<CategoryProvider>()
          .loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider =
    context.watch<CategoryProvider>();

    return Scaffold(
      backgroundColor:
      const Color(0xffF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Categories",
          style: TextStyle(
            fontWeight:
            FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor:
        Colors.indigo,
        foregroundColor:
        Colors.white,
      ),
      body: provider.isLoading
          ? const Center(
        child:
        CircularProgressIndicator(),
      )
          : provider.categories.isEmpty
          ? const Center(
        child: Text(
          "No Categories Found",
        ),
      )
          : ListView.builder(
        padding:
        const EdgeInsets.all(
            16),
        itemCount: provider
            .categories.length,
        itemBuilder:
            (context, index) {
          final category =
          provider
              .categories[
          index];

          return Container(
            margin:
            const EdgeInsets
                .only(
              bottom: 15,
            ),
            decoration:
            BoxDecoration(
              gradient:
              const LinearGradient(
                colors: [
                  Color(
                      0xff4F46E5),
                  Color(
                      0xff6366F1),
                ],
              ),
              borderRadius:
              BorderRadius
                  .circular(
                  20),
              boxShadow: [
                BoxShadow(
                  color: Colors
                      .indigo
                      .withOpacity(
                      .2),
                  blurRadius:
                  12,
                  offset:
                  const Offset(
                      0,
                      5),
                ),
              ],
            ),
            child: ListTile(
              contentPadding:
              const EdgeInsets
                  .all(16),
              leading:
              Container(
                width: 55,
                height: 55,
                decoration:
                BoxDecoration(
                  color: Colors
                      .white,
                  borderRadius:
                  BorderRadius.circular(
                      15),
                ),
                child:
                const Icon(
                  Icons.category,
                  color: Colors
                      .indigo,
                  size: 28,
                ),
              ),
              title: Text(
                category,
                style:
                const TextStyle(
                  color: Colors
                      .white,
                  fontSize: 18,
                  fontWeight:
                  FontWeight
                      .bold,
                ),
              ),
              subtitle:
              const Text(
                "Product Category",
                style:
                TextStyle(
                  color: Colors
                      .white70,
                ),
              ),
              trailing:
              const Icon(
                Icons
                    .arrow_forward_ios,
                color: Colors
                    .white,
              ),
            ),
          );
        },
      ),
    );
  }
}