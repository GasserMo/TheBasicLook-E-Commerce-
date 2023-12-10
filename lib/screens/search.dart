import 'dart:math';

import 'package:flutter/material.dart';
import 'package:thebasiclook/models/cart_model/cart_model/product.dart';
import 'package:thebasiclook/services/products.dart';

class Search extends SearchDelegate {
  final product = Products().getAllProducts();
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.black),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black, // Set your desired cursor color here
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusColor: Colors.white,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.transparent), // Set your desired focus color here
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for the search bar (e.g., clear query).
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon (e.g., back button).
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: Products()
          .getAllProducts(), // You should call the async function to get the products
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Center(
              child: Text(
            'Oops... No Item Found',
            style: TextStyle(color: Colors.black),
          ));
        }
        final products = snapshot.data;
        final filteredProducts = products!.where((product) {
          return product.name!.toLowerCase().contains(query.toLowerCase());
        }).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Suggestions',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          filteredProducts[index].image!,
                          width: 100,
                          height: 100,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              filteredProducts[index].name!,
                            ),
                            Text(
                              'EGP ${filteredProducts[index].price!}',
                            ),
                            Text(
                              filteredProducts[index].gender!,
                            ),
                            Text(
                              filteredProducts[index].collectionSeason!,
                            )
                          ],
                        )
                      ],
                    )),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: Products()
          .getAllProducts(), // You should call the async function to get the products
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Center(
              child: Text(
            'Oops... No Item Found',
            style: TextStyle(color: Colors.black),
          ));
        }
        final products = snapshot.data;
        final filteredProducts = products!.where((product) {
          return product.name!.toLowerCase().contains(query.toLowerCase());
        }).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Suggestions',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          filteredProducts[index].image!,
                          width: 100,
                          height: 100,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              filteredProducts[index].name!,
                            ),
                            Text(
                              'EGP ${filteredProducts[index].price!}',
                            ),
                            Text(
                              filteredProducts[index].gender!,
                            ),
                            Text(
                              filteredProducts[index].collectionSeason!,
                            )
                          ],
                        )
                      ],
                    )),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
