import 'package:equatable/equatable.dart';

import 'cart.dart';

class CartModel extends Equatable {
  final String? message;
  final List<Cart>? cart;
  final int? totalPrice;

  const CartModel({this.message, this.cart, this.totalPrice});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        message: json['message'] as String?,
        cart: (json['cart'] as List<dynamic>?)
            ?.map((e) => Cart.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalPrice: json['totalPrice'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'cart': cart?.map((e) => e.toJson()).toList(),
        'totalPrice': totalPrice,
      };

  @override
  List<Object?> get props => [message, cart, totalPrice];
}
