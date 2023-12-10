import 'dart:convert';

import 'package:thebasiclook/constants.dart';
import 'package:http/http.dart' as http;
import 'package:thebasiclook/models/cart_model/cart_model/product.dart';

class Collections {
  Future<List<Product>> getCollection({required String keyWord}) async {
    final url = Uri.parse(baseUrl + 'products/collections/$keyWord');

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
      print(response.body);
      print(response.statusCode);
    }
    return productList;
  }
}
