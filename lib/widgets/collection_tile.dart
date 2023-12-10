import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thebasiclook/bloc/collection/collection_bloc.dart';
import 'package:thebasiclook/models/cart_model/cart_model/product.dart';
import 'package:thebasiclook/screens/productsDetails.dart';
import 'package:thebasiclook/widgets/add_to_cart.dart';

class CollectionTile extends StatelessWidget {
  const CollectionTile({
    super.key,
    required this.product,
    required this.selectedProduct,
    required this.collectionBloc,
  });

  final List<Product> product;
  final Product? selectedProduct;
  final CollectionBloc collectionBloc;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: product.length,
      itemBuilder: (context, index) {
        bool isSelected = selectedProduct == product[index];

        return BlocBuilder<CollectionBloc, CollectionState>(
          bloc: collectionBloc,
          builder: (context, state) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ProductDetails(
                          id: product[index].id as String,
                        );
                      }));
                    },
                    child: Image.network(
                      product[index].image!,
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                  ),
                  Text(
                    product[index].name!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  Text(
                    'EGP ${product[index].price}',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  GestureDetector(
                      onTap: () async {
                        isSelected = true;
                        collectionBloc.add(CollectionCartButtonClickedEvent(
                            clickedProduct: product[index]));
                      },
                      child: state is CollectionCartedLoadingState && isSelected
                          ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )
                          : addToCart(
                              context,
                              Colors.black,
                              Colors.white,
                              MediaQuery.of(context).size.height * 0.04,
                              Colors.black))
                ],
              ),
            );
          },
        );
      },
    );
  }
}
