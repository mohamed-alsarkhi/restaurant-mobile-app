import 'package:flutter/material.dart';

import 'data/OrderService.dart';
import 'data/cartService.dart';
import 'data/routesApi.dart';

class Cart extends StatefulWidget {
  const Cart(this.userId,{super.key});

  final int userId;
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final Cartservice cartservice = Cartservice();
  final OrderService orderService =OrderService();

  bool isOrdering = false;


  Future<void> makeOrder() async {
    if (isOrdering) return;

    setState(() {
      isOrdering = true;
    });

    try {
      final orderId = await orderService.makeOrder(widget.userId);

      if (!mounted) return;

      setState(() {
        loadCart();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order #$orderId created successfully'),
          backgroundColor: Colors.green,
        ),
      );

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );

    } finally {
      if (mounted) {
        setState(() {
          isOrdering = false;
        });
      }
    }
  }

  late Future<List<dynamic>> cartitems;
  @override
  void initState() {
    super.initState();
    loadCart();
  }
  void loadCart() {
    cartitems = cartservice.getCart(widget.userId);
  }

  Future<void> deleteProduct(int productId) async {
    try {
      await cartservice.removeFromCart(
        widget.userId,
        productId,
      );

      if (!mounted) return;

      setState(() {
        cartitems = cartservice.getCart(widget.userId);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product removed from cart'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("My Cart"),
      ),

      body: FutureBuilder<List<dynamic>>(
        future: cartitems,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final items = snapshot.data ?? [];

          if (items.isEmpty) {
            return const Center(
              child: Text('Your Cart is Empty'),
            );
          }

          double total = 0;

          for (var item in items) {
            total +=
                (item['price'] as num).toDouble() *
                    (item['quantity'] as num).toInt();
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];

                    final String imagePath =
                        item['imageUrl']?.toString() ?? '';

                    final String imageUrl = imagePath.isEmpty
                        ? ''
                        : Uri.parse(ConnString.dashboardUrl)
                        .resolve(imagePath)
                        .toString();

                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: SizedBox(
                          width: 65,
                          height: 65,
                          child: imageUrl.isNotEmpty
                              ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.image);
                            },
                          )
                              : const Icon(Icons.image),
                        ),

                        title: Text(
                          item['menuItemName']?.toString() ?? '',
                        ),

                        subtitle: Text(
                          '${item['price']} SAR\n'
                              'Quantity: ${item['quantity']}',
                        ),

                        isThreeLine: true,

                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            deleteProduct(item['menuItemId']);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Text(
                  'Total: ${total.toStringAsFixed(2)} SAR',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isOrdering ? null : makeOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      foregroundColor: Colors.white,
                    ),
                    child: isOrdering
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text(
                      'Make Order',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),


            ],
          );
        },
      ),
    );
  }
}