import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thebasiclook/models/cart_model/cart_model/cart_model.dart';
import 'package:thebasiclook/models/cart_model/cart_model/product.dart';
import 'package:thebasiclook/screens/cartScreen.dart';
import 'package:thebasiclook/services/cart.dart';
import 'package:thebasiclook/services/products.dart';
import 'package:thebasiclook/widgets/customAppBar.dart';
import 'package:thebasiclook/widgets/add_to_cart.dart';
import 'package:thebasiclook/widgets/quantity_selection.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({super.key, required this.id});
  final String id;
  
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String bigSize = '';
  /* String selectedSize='' ; */
  void selectSize(String size) {
    bigSize = size;
  }

  int quantity = 1;
  void selectQuantity(int quan) {
    quantity = quan;
  }

  @override
  Widget build(BuildContext context) {
    final token = GetStorage().read('token');

    return Scaffold(
        appBar: customAppBar(
            title: 'TheBasicLook',
            leadingIcon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        body: FutureBuilder<Product?>(
            future: Products().getOneProduct(id: widget.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              final Product product = snapshot.data!;
              return ListView(
                children: [
                  SingleChildScrollView(
                      child: Column(
                    children: [
                      Image.network(product.image!),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name!,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'EGP ${product.price!}',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Quantity ',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                                QuantitySelection(
                                    onQuantitySelected: selectQuantity)
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizeSelection(
                                  availableSizes: product.size!,
                                  onSizeSelected: selectSize,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            if (bigSize == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('please select a size')));
                            } else {
                              await CartServices().addToCart(
                                  token: token,
                                  id: product.id!,
                                  size: bigSize,
                                  quantity: quantity);
                              print(token);
                           
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return CartScreen(
                                  selectedSize: bigSize,
                                );
                              }));
                            }
                          },
                          child: addToCart(
                              context,
                              Colors.white,
                              Colors.black,
                              MediaQuery.of(context).size.height * 0.05,
                              Colors.black),
                        ),
                      )
                    ],
                  )),
                ],
              );
            }));
  }
}

class SizeSelection extends StatefulWidget {
  final List<dynamic> availableSizes;
  final Function(String) onSizeSelected;

  SizeSelection({required this.availableSizes, required this.onSizeSelected});

  @override
  _SizeSelectionState createState() => _SizeSelectionState();
}

class _SizeSelectionState extends State<SizeSelection> {
  String selectedSize = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Size',
          style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.6)),
        ),
        SizedBox(
          width: 30,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.availableSizes.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSize = widget.availableSizes[index];
                          widget.onSizeSelected(selectedSize);
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: selectedSize == widget.availableSizes[index]
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            widget.availableSizes[index],
                            style: TextStyle(
                              color:
                                  selectedSize == widget.availableSizes[index]
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
