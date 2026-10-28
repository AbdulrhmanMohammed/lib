import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/OrderProvider.dart';

class MyOrdersScreen extends StatefulWidget {
  final int userId;

  const MyOrdersScreen(
      this.userId, {
        super.key,
      });

  @override
  State<MyOrdersScreen> createState() =>
      _MyOrdersScreenState();
}

class _MyOrdersScreenState
    extends State<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<OrderProvider>()
          .loadOrders(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider =
    context.watch<OrderProvider>();

    return Scaffold(
      backgroundColor:
      const Color(0xffF5F7FA),
      appBar: AppBar(
        title: const Text(
          'My Orders',
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
          : provider.orders.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment
              .center,
          children: [
            Icon(
              Icons
                  .shopping_bag_outlined,
              size: 80,
              color:
              Colors.grey,
            ),
            SizedBox(
                height: 10),
            Text(
              'No Orders Found',
              style:
              TextStyle(
                fontSize: 18,
                color:
                Colors.grey,
              ),
            ),
          ],
        ),
      )
          : RefreshIndicator(
        onRefresh: () =>
            provider
                .refreshOrders(
              widget.userId,
            ),
        child:
        ListView.builder(
          padding:
          const EdgeInsets
              .all(12),
          itemCount: provider
              .orders.length,
          itemBuilder:
              (context,
              index) {
            final order =
            provider.orders[
            index];

            final products =
                order['items']
                as List? ??
                    [];

            return Container(
              margin:
              const EdgeInsets
                  .only(
                bottom: 15,
              ),
              decoration:
              BoxDecoration(
                color: Colors
                    .white,
                borderRadius:
                BorderRadius
                    .circular(
                    20),
                boxShadow: [
                  BoxShadow(
                    color: Colors
                        .black
                        .withOpacity(
                        .08),
                    blurRadius:
                    10,
                    offset:
                    const Offset(
                        0,
                        4),
                  ),
                ],
              ),
              child: Padding(
                padding:
                const EdgeInsets
                    .all(
                    16),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding:
                          const EdgeInsets
                              .all(
                              12),
                          decoration:
                          BoxDecoration(
                            color: Colors
                                .indigo
                                .withOpacity(
                                .1),
                            borderRadius:
                            BorderRadius.circular(
                                12),
                          ),
                          child:
                          const Icon(
                            Icons
                                .shopping_bag,
                            color: Colors
                                .indigo,
                          ),
                        ),
                        const SizedBox(
                            width:
                            10),
                        Expanded(
                          child:
                          Text(
                            'Order #${order['id']}',
                            style:
                            const TextStyle(
                              fontSize:
                              20,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal:
                            12,
                            vertical:
                            6,
                          ),
                          decoration:
                          BoxDecoration(
                            color: provider
                                .getStatusColor(
                                order['status'])
                                .withOpacity(
                                .15),
                            borderRadius:
                            BorderRadius.circular(
                                30),
                          ),
                          child:
                          Text(
                            order[
                            'status']
                                .toString(),
                            style:
                            TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              color: provider
                                  .getStatusColor(
                                  order['status']),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                        height:
                        15),
                    Text(
                      order[
                      'createdAt']
                          .toString(),
                    ),
                    const SizedBox(
                        height:
                        10),
                    Text(
                      '${order['totalAmount']} SAR',
                      style:
                      const TextStyle(
                        fontSize:
                        18,
                        color: Colors
                            .green,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    const Text(
                      'Products',
                      style:
                      TextStyle(
                        fontSize:
                        17,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                        height:
                        10),
                    ...products
                        .map(
                          (product) =>
                          Container(
                            margin:
                            const EdgeInsets.only(
                              bottom:
                              10,
                            ),
                            padding:
                            const EdgeInsets.all(
                                12),
                            decoration:
                            BoxDecoration(
                              color: Colors
                                  .grey
                                  .shade100,
                              borderRadius:
                              BorderRadius.circular(
                                  12),
                            ),
                            child:
                            Row(
                              children: [
                                const Icon(
                                  Icons
                                      .inventory_2,
                                  color: Colors
                                      .indigo,
                                ),
                                const SizedBox(
                                    width:
                                    12),
                                Expanded(
                                  child:
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product['productName']
                                            ?.toString() ??
                                            '',
                                        style:
                                        const TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                      ),
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
                                    color: Colors
                                        .green,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    )
                        .toList(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}