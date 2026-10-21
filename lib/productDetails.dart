import 'package:flutter/material.dart';

import 'data/cartService.dart';
import 'data/routesApi.dart';

class Productdetails extends StatelessWidget {

  final dynamic product;
  final  int userId;
  const Productdetails(this.product,this.userId ,{super.key});

  // Dashboard URL


  @override
  Widget build(BuildContext context) {


    // Image Path
    final String imagePath =
        product['imageURL']?.toString() ?? '';

    // Complete Image URL
    final String imageUrl = imagePath.isEmpty
        ? ''
        : Uri.parse(ConnString.dashboardUrl)
        .resolve(imagePath)
        .toString();

    return Scaffold(

      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.deepPurpleAccent,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // Product Image
            SizedBox(
              width: double.infinity,
              height: 300,

              child: imageUrl.isNotEmpty
                  ? Image.network(
                imageUrl,
                fit: BoxFit.contain,

                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_not_supported,
                    size: 100,
                  );
                },
              )
                  : const Icon(
                Icons.image,
                size: 100,
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  // Product Name
                  Text(
                    product['name']?.toString() ?? '',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Product Price
                  Text(
                    '${product['price']} SAR',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Divider(),

                  const SizedBox(height: 15),

                  // Product Category
                  Text(
                    'Category name: ${product['categoryName'] ?? 'N/A'}',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        await Cartservice().AddtoCart(
                          userId,
                          product['id'],
                        );

                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Product Added to Cart'),
                          ),
                        );
                      } catch (e) {
                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    },
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('Add to Cart'),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}