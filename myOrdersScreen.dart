import 'package:flutter/material.dart';
import 'data/OrderService.dart';

class MyOrdersScreen extends StatefulWidget {
  final int userId;

  const MyOrdersScreen(this.userId, {super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  final OrderService orderService = OrderService();

  late Future<List<dynamic>> orders;

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  void loadOrders() {
    orders = orderService.getMyOrders(widget.userId);
  }

  Future<void> refreshOrders() async {
    setState(() {
      loadOrders();
    });

    await orders;
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.indigo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        title: const Text(
          'My Orders',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: orders,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          }

          final items = snapshot.data ?? [];

          if (items.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'No Orders Found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: refreshOrders,
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final order = items[index];
                final products =
                    order['items'] as List? ?? [];

                return Container(
                  margin: const EdgeInsets.only(
                    bottom: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color:
                        Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding:
                              const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.indigo
                                    .withOpacity(.1),
                                borderRadius:
                                BorderRadius.circular(
                                    12),
                              ),
                              child: const Icon(
                                Icons.shopping_bag,
                                color: Colors.indigo,
                              ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Text(
                                'Order #${order['id']}',
                                style:
                                const TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ),

                            Container(
                              padding:
                              const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: getStatusColor(
                                    order['status'])
                                    .withOpacity(.15),
                                borderRadius:
                                BorderRadius.circular(
                                    30),
                              ),
                              child: Text(
                                order['status']
                                    .toString(),
                                style: TextStyle(
                                  fontWeight:
                                  FontWeight.bold,
                                  color: getStatusColor(
                                      order['status']),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 18,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                order['createdAt']
                                    .toString(),
                                style:
                                const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            const Icon(
                              Icons.payments,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${order['totalAmount']} SAR',
                              style:
                              const TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        const Divider(),

                        const Text(
                          'Products',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        ...products.map((product) {
                          return Container(
                            margin:
                            const EdgeInsets.only(
                                bottom: 10),
                            padding:
                            const EdgeInsets.all(12),
                            decoration:
                            BoxDecoration(
                              color:
                              Colors.grey.shade100,
                              borderRadius:
                              BorderRadius.circular(
                                  12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration:
                                  BoxDecoration(
                                    color: Colors
                                        .indigo
                                        .withOpacity(
                                        .1),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        10),
                                  ),
                                  child: const Icon(
                                    Icons.inventory_2,
                                    color:
                                    Colors.indigo,
                                  ),
                                ),

                                const SizedBox(
                                    width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        product[
                                        'productName']
                                            ?.toString() ??
                                            '',
                                        style:
                                        const TextStyle(
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(
                                          height: 4),
                                      Text(
                                        'Quantity: ${product['quantity']}',
                                      ),
                                    ],
                                  ),
                                ),

                                Text(
                                  '${product['unitPrice']} SAR',
                                  style:
                                  const TextStyle(
                                    color:
                                    Colors.green,
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
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