import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/conncetion.dart';
import '../providers/CartProvider.dart';
import '../providers/OrderProvider.dart';


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
        title: const Text('My Cart !'),
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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item['price']} SAR',
                        ),

                        const SizedBox(height: 8),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                await cartProvider.decreaseQuantity(
                                  widget.userId,
                                  item['productId'],
                                );
                              },
                              icon: const Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                            ),

                            Text(
                              '${item['quantity']}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            IconButton(
                              onPressed: () async {
                                await cartProvider.increaseQuantity(
                                  widget.userId,
                                  item['productId'],
                                );
                              },
                              icon: const Icon(
                                Icons.add_circle,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    isThreeLine: true,
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    final orderProvider =
                    context.read<OrderProvider>();

                    await orderProvider.makeOrder(
                      widget.userId,
                    );

                    await cartProvider.loadCart(
                      widget.userId,
                    );

                    if (context.mounted) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Order Created Successfully',
                          ),
                          backgroundColor:
                          Colors.green,
                        ),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          content: Text(
                            e.toString(),
                          ),
                          backgroundColor:
                          Colors.red,
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Make Order',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}