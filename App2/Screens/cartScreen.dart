import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/conncetion.dart';
import '../providers/CartProvider.dart';


class CartScreen extends StatefulWidget {
  final int userId;

  const CartScreen(
      this.userId, {
        super.key,
      });

  @override
  State<CartScreen> createState() =>
      _CartScreenState();
}

class _CartScreenState
    extends State<CartScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<CartProvider>()
          .loadCart(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider =
    context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Colors.indigo,
      ),
      body: cartProvider.isLoading
          ? const Center(
        child:
        CircularProgressIndicator(),
      )
          : cartProvider.cartItems.isEmpty
          ? const Center(
        child: Text(
          'Your Cart is Empty',
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider
                  .cartItems.length,
              itemBuilder:
                  (context, index) {
                final item =
                cartProvider
                    .cartItems[
                index];

                final String imagePath =
                    item['imageUrl']
                        ?.toString() ??
                        '';

                final String imageUrl =
                imagePath.isEmpty
                    ? ''
                    : Uri.parse(
                    ConnectionString
                        .cart)
                    .resolve(
                    imagePath)
                    .toString();

                return Card(
                  margin:
                  const EdgeInsets
                      .all(10),
                  child: ListTile(
                    leading:
                    SizedBox(
                      width: 65,
                      height: 65,
                      child: imageUrl
                          .isNotEmpty
                          ? Image.network(
                        imageUrl,
                        fit: BoxFit
                            .cover,
                        errorBuilder:
                            (
                            context,
                            error,
                            stackTrace,
                            ) {
                          return const Icon(
                            Icons
                                .image,
                          );
                        },
                      )
                          : const Icon(
                        Icons
                            .image,
                      ),
                    ),
                    title: Text(
                      item['name']
                          ?.toString() ??
                          '',
                    ),
                    subtitle:
                    Text(
                      '${item['price']} SAR\n'
                          'Quantity: ${item['quantity']}',
                    ),
                    isThreeLine:
                    true,
                    trailing:
                    IconButton(
                      icon:
                      const Icon(
                        Icons.delete,
                        color:
                        Colors.red,
                      ),
                      onPressed:
                          () async {
                        await cartProvider
                            .removeFromCart(
                          widget.userId,
                          item[
                          'productId'],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding:
            const EdgeInsets.all(
                20),
            width:
            double.infinity,
            child: Text(
              'Total: ${cartProvider.getTotal().toStringAsFixed(2)} SAR',
              textAlign:
              TextAlign.center,
              style:
              const TextStyle(
                fontSize: 23,
                fontWeight:
                FontWeight.bold,
                color:
                Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}