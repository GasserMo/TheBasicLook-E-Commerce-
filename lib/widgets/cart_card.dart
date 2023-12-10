import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thebasiclook/models/cart_model/cart_model/cart.dart';
import 'package:thebasiclook/services/cart.dart';
import 'package:thebasiclook/widgets/quantity_selection.dart';

class CartProductCard extends StatefulWidget {
  const CartProductCard({
    super.key,
    required this.cart,
    required this.size,
    required this.onDelete,
  });
  final Cart cart;
  final String size;
  final Function() onDelete;

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  int quantity = 1;
  void selectQuantity(int quan) {
    quantity = quan;
  }

  @override
  void initState() {
    super.initState();
    quantity = widget.cart.quantity ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    final token = GetStorage().read('token');
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Image.network(
              widget.cart.product!.image!,
              width: 150,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, right: 30, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'THE BASIC LOOK',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.onDelete();
                        print("size"+widget.size);
                      },
                      child: Icon(Icons.delete),
                    ),
                  ],
                ),
                Text(
                  widget.cart.product!.name!,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '${widget.cart.size}',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Row(
                  children: [
                    Text(
                      'Quantity ',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantity--;
                                  CartServices().updateCartQuantity(
                                      token: token,
                                      id: widget.cart.product!.id!,
                                      size: widget.cart.size!,
                                      quantity: quantity);
                                }
                              });
                            },
                            icon: Icon(
                              Icons.remove,
                            )),
                        Text(
                          '${quantity}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.black),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++;
                                CartServices().updateCartQuantity(
                                    token: token,
                                    id: widget.cart.product!.id!,
                                    size: widget.cart.size!,
                                    quantity: quantity);
                              });
                            },
                            icon: Icon(
                              Icons.add,
                            )),
                      ],
                    )
                  ],
                ),
                Text(
                  'EGP ${widget.cart.product!.price! * quantity}',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
