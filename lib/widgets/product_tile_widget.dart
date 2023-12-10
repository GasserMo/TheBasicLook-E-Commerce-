
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thebasiclook/models/cart_model/cart_model/product.dart';
import 'package:thebasiclook/screens/productsDetails.dart';
import 'package:thebasiclook/widgets/add_to_cart.dart';

import 'package:thebasiclook/bloc/product/product_bloc.dart';

class ProductTileWidget extends StatefulWidget {
  const ProductTileWidget({
    super.key,
    required this.token,
    required this.products,
    required this.productBloc,
  });

  final String token;
  final List<Product> products;
  final ProductBloc productBloc;

  @override
  State<ProductTileWidget> createState() => _ProductTileWidgetState();
}

class _ProductTileWidgetState extends State<ProductTileWidget> {
  @override
  Widget build(BuildContext context) {
    Product? selectedProduct;

    return GridView.builder(
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        mainAxisExtent: 350,
      ),
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        final List<Product> product = widget.products;
         bool isSelected = selectedProduct == product[index];
        return BlocBuilder<ProductBloc, ProductState>(
          bloc: widget.productBloc,
          builder: (context, state) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return ProductDetails(
                              id: product[index].id as String,
                            );
                          },
                        ));
                      },
                      child: Image.network(
                        product[index].image!,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product[index].name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                  Text(
                    'EGP ${product[index].price}',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                      
                      isSelected=true;
                        widget.productBloc.add(ProductCartButtonClickedEvent(
                          clickedProduct: product[index],
                        ));
                                                 

                      },
                      child:
                           state is ProductCartedLoadingState &&  isSelected
                              ? CircularProgressIndicator()
                              : addToCart(
                                  context,
                                  Colors.black,
                                  Colors.white,
                                  MediaQuery.of(context).size.height * 0.04,
                                  Colors.black,
                                )
                         
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}