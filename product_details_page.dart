
import 'package:flutter/material.dart';
import 'data/CartService.dart';

class ProductDetailsPage extends StatelessWidget {
  final dynamic product;
  final int userId;


  const ProductDetailsPage(
      this.product,
      this.userId, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    if (product is! Map) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Product Details'),
          backgroundColor: Colors.blueAccent,
        ),
        body: const Center(
          child: Text(
            'Invalid product data',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    final Map<String, dynamic> productData =
    Map<String, dynamic>.from(product);

    final String productName =
        productData['productName']?.toString() ??
            'Unknown Product';

    final String imageUrl =
        productData['imageUrl']?.toString() ?? '';

    final String unitPrice =
        productData['unitPrice']?.toString() ?? 'N/A';

    final String quantityInStock =
        productData['quantityInStock']?.toString() ?? 'N/A';

    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Center(
              child: imageUrl.isNotEmpty
                  ? Image.network(
                imageUrl,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (
                    context,
                    error,
                    stackTrace,
                    ) {
                  return const Icon(
                    Icons.image_not_supported,
                    size: 80,
                  );
                },
              )
                  : const Icon(
                Icons.image_not_supported,
                size: 80,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              productName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Price: $unitPrice',
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 10),

            Text(
              'Quantity in stock: $quantityInStock',
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () async {
                final messenger =
                ScaffoldMessenger.of(context);

                final productId = int.tryParse(
                  productData['productID']?.toString() ?? '',
                );

                if (productId == null) {
                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Error: Invalid product ID',
                      ),
                    ),
                  );
                  return;
                }

                try {
                  debugPrint('Adding product to cart...');
                  debugPrint('User ID: $userId');
                  debugPrint('Product ID: $productId');

                  await CartService().addToCart(
                    userId,
                    product['productID'],
                  );

                  if (!context.mounted) return;

                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Product Added to Cart',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e, stackTrace) {
                  debugPrint('Add to Cart Error: $e');
                  debugPrint('$stackTrace');

                  if (!context.mounted) return;

                  messenger.showSnackBar(
                    SnackBar(
                      content: Text(
                        'Failed to add product: $e',
                      ),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 5),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
