import 'package:flutter/material.dart';

import 'data/productService.dart';
import 'data/routesApi.dart';
import 'home.dart';
import 'productDetails.dart';

class Product extends StatefulWidget {
   Product(this.userId,{super.key});

  final  int userId;

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {

  final ProductService productService = ProductService();

  late Future<List<dynamic>> products;

  // Dashboard URL


  @override
  void initState() {
    super.initState();
    products = productService.getProducts();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product page"),
        backgroundColor: Colors.deepPurpleAccent,

      ),
         body: FutureBuilder<List<dynamic>> (
             future: products,
          builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
          child: CircularProgressIndicator(),
          );
          }

          if (snapshot.hasError) {
          return Center(
          child: Text('Error: ${snapshot.error}'),
          );
          }

          final productsList = snapshot.data ?? [];

          if (productsList.isEmpty) {
          return const Center(
          child: Text('No Products Found'),
          );
}
          return GridView.builder(

            padding: const EdgeInsets.all(12),

            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),

            itemCount: productsList.length,

            itemBuilder: (context, index) {

              final product = productsList[index];

              // Image Path From Database
              final String imagePath =
                  product['imageURL']?.toString() ?? '';

              // Complete Image URL
              final String imageUrl = imagePath.isEmpty
                  ? ''
                  : Uri.parse(ConnString.dashboardUrl)
                  .resolve(imagePath)
                  .toString();

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Productdetails(product,widget.userId),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Column(
                    children: [

                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),

                          child: imageUrl.isNotEmpty
                              ? Image.network(
                            imageUrl,
                            width: double.infinity,
                            fit: BoxFit.cover,

                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 60,
                                ),
                              );
                            },
                          )
                              : const Center(
                            child: Icon(
                              Icons.image,
                              size: 60,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        product['name']?.toString() ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 5),

                      Text(
                        '${product['price']} SAR',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),
                    ],
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

      // body: GridView.count(
      //   padding: const EdgeInsets.only(top: 20),
      //   mainAxisSpacing: 10,
      //   crossAxisSpacing: 10,
      //   crossAxisCount: 4,
      //   children: List.generate(16, (index) {
      //     return Card(
      //       elevation: 10,
      //       color: Colors.cyanAccent,
      //       child: Center(child: Column(
      //         children: [
      //           Icon(Icons.apple),
      //           SizedBox(height: 10,),
      //           Text('Item ${index + 1}'),
      //         ],
      //       )),
      //     );
      //   }),
      // ),
//     );
//   }
// }