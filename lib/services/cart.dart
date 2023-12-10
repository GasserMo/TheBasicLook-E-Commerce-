import 'dart:convert';

import 'package:thebasiclook/constants.dart';
import 'package:http/http.dart' as http;
import 'package:thebasiclook/models/cart_model/cart_model/cart.dart';
import 'package:thebasiclook/models/cart_model/cart_model/cart_model.dart';

class CartServices {
  Future<List<Cart>> getCart({required String token}) async {
    final url = Uri.parse(baseUrl + 'cart/');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    List<Cart> cartList = [];
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      List<dynamic> cart = responseData['cart'];
      for (final cartProduct in cart) {
        cartList.add(Cart.fromJson(cartProduct));
      }
    } else {
      print(response.body);
      print(response.statusCode);
    }
    print('success');
    print('cart is here');
    return cartList;
  }

  Future<int?> getCartPrice({required String token}) async {
    final url = Uri.parse(baseUrl + 'cart/');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final int? totalPrice = responseData['totalPrice'];
      return totalPrice;
    } else {
      print(response.body);
      print(response.statusCode);
    }
  }

  Future<http.Response> addToCart(
      {required String token,
      required String id,
      required String size,
      required int quantity}) async {
    final url = Uri.parse(baseUrl + 'cart/$id');

    final response = await http.post(url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"size": size, "quantity": quantity}));
   
    return response;
  }

  Future<void> updateCartQuantity(
      {required String token,
      required String id,
      required String size,
      required int quantity}) async {
    final url = Uri.parse(baseUrl + 'cart/$id');

    final response = await http.put(url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"size": size, "quantity": quantity}));
    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print('product is added to cart');
      print(responseData);
    } else {
      print(response.body);
      print(response.statusCode);
    }
  }

  Future<void> deleteCart({
    required String token,
    required String id,
    required String size,
  }) async {
    final url = Uri.parse(baseUrl + 'cart/$id');

    final response = await http.delete(url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "size": size,
        }));
    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print('product is deleted from cart');
      print(responseData);
    } else {
      print(response.body);
      print(response.statusCode);
    }
  }
}
