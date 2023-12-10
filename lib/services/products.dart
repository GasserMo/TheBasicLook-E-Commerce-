import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:thebasiclook/constants.dart';
import 'package:thebasiclook/models/cart_model/cart_model/product.dart';
import 'package:http/http.dart' as http;

class Products {
  Future<List<Product>> getAllProducts() async {
    final url = Uri.parse(baseUrl + 'products/');

    final response = await http.get(
      url,
    );
    List<Product> productList = [];
    if (response.statusCode == 200) {
      List<dynamic> products = jsonDecode(response.body)['products'];
      for (final product in products) {
        productList.add(Product.fromJson(product));
      }
      print('prodcts' + products.toString());
    } else {
      print(response.statusCode);
      print(response.body);
    }
    print(productList.length);
    return productList;
  }

  Future<Product?> getOneProduct({required String id}) async {
    final url = Uri.parse(baseUrl + 'products/$id');

    final response = await http.get(
      url,
    );
    Product? product;
    if (response.statusCode == 200) {
      product = Product.fromJson(jsonDecode(response.body)['product']);
      print('prodcts' + product.toString());
    } else {
      print(response.statusCode);
      print(response.body);
    }
    return product;
  }
}
