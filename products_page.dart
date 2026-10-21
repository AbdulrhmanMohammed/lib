
import 'package:flutter/material.dart';
import 'data/product_service.dart';
import 'product_details_page.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage(this.userId, {super.key});

  final int userId;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ProductService productService = ProductService();

  List<dynamic> products = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      final data = await productService.getProducts();

      if (!mounted) return;

      setState(() {
        products = data;
        isLoading = false;
        errorMessage = null;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load products';
      });

      debugPrint('Error loading products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.blueAccent,
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : errorMessage != null
          ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(errorMessage!),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                  errorMessage = null;
                });
                loadProducts();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      )
          : products.isEmpty
          ? const Center(
        child: Text('No products available'),
      )
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];

          if (item is! Map) {
            return const ListTile(
              title: Text('Invalid product data'),
            );
          }

          final product =
          Map<String, dynamic>.from(item);

          final String productName =
              product['productName']?.toString() ??
                  'Unknown Product';

          final String imageUrl =
              product['imageUrl']?.toString() ?? '';

          final String unitPrice =
              product['unitPrice']?.toString() ?? 'N/A';

          return ListTile(
            leading: imageUrl.isNotEmpty
                ? Image.network(
              imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) {
                return const Icon(
                  Icons.image_not_supported,
                  size: 40,
                );
              },
            )
                : const Icon(
              Icons.image_not_supported,
              size: 40,
            ),
            title: Text(productName),
            subtitle: Text('Price: $unitPrice'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailsPage(
                        product,
                        widget.userId,
                      ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
