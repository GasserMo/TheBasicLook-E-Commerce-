import 'package:equatable/equatable.dart';

import 'product.dart';

class Cart extends Equatable {
  final Product? product;
  final int? quantity;
  final String? size;
  final String? id;

  const Cart({this.product, this.quantity, this.size, this.id});

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        product: json['product'] == null
            ? null
            : Product.fromJson(json['product'] as Map<String, dynamic>),
        quantity: json['quantity'] as int?,
        size: json['size'] as String?,
        id: json['_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'product': product?.toJson(),
        'quantity': quantity,
        'size': size,
        '_id': id,
      };

  @override
  List<Object?> get props => [product, quantity, size, id];
}
