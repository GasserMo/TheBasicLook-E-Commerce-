import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thebasiclook/models/cart_model/cart_model/cart.dart';
import 'package:thebasiclook/models/cart_model/cart_model/cart_model.dart';
import 'package:thebasiclook/models/cart_model/cart_model/product.dart';
import 'package:thebasiclook/services/cart.dart';
import 'package:thebasiclook/services/orders.dart';
import 'package:thebasiclook/widgets/cart_card.dart';
import 'package:thebasiclook/widgets/customAppBar.dart';
import 'package:thebasiclook/widgets/drawer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.selectedSize});
  final String selectedSize;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final token = GetStorage().read('token');
  final sessionId = GetStorage().read('sessionId');
  int cartPrice = 0;
  int quantity = 1;
  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  void _loadCart() async {
    await CartServices().getCart(token: token);
    final price = await CartServices().getCartPrice(token: token);
    setState(() {
      cartPrice = price ?? 0;
    });
  }

  void _deleteCartItem(String productId, String size) async {
    await CartServices().deleteCart(token: token, id: productId, size: size);
    _loadCart();
  }

  @override
  Widget build(BuildContext context) {
    final token = GetStorage().read('token');
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: customAppBar(title: 'Cart', leadingIcon: Icon(Icons.menu)),
        body: FutureBuilder<List<Cart>>(
          future: CartServices().getCart(token: token),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'YOUR CART IS EMPTY!',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Start shopping to fill it up',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      print(token);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.black,
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        'GO SHOPPING',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            }
            final carts = snapshot.data;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: carts!.length,
                    itemBuilder: (context, index) {
                      final cart = carts[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CartProductCard(
                                cart: cart,
                                size: widget.selectedSize,
                                onDelete: () {
                                  _deleteCartItem(
                                      cart.product!.id!, widget.selectedSize);
                                },
                              )
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration:
                          BoxDecoration(color: Colors.black.withAlpha(50)),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.black),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Value',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            FutureBuilder(
                              future: CartServices().getCartPrice(token: token),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (!snapshot.hasData) {
                                  return Text(
                                      'Total Price: N/A'); // Handle no data
                                }
                                return Text(
                                  'EGP $cartPrice',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
           
                GestureDetector(
                  onTap: () async {
                    PaymentManager.makePayment(cartPrice, 'EGP');
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.black),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Checkout',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }
}
