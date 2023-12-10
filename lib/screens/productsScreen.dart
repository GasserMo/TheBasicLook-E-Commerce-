import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thebasiclook/bloc/product/product_bloc.dart';
import 'package:thebasiclook/models/cart_model/cart_model/product.dart';
import 'package:thebasiclook/screens/cartScreen.dart';
import 'package:thebasiclook/screens/productsDetails.dart';
import 'package:thebasiclook/screens/search.dart';
import 'package:thebasiclook/services/cart.dart';
import 'package:thebasiclook/services/products.dart';
import 'package:thebasiclook/widgets/customAppBar.dart';
import 'package:thebasiclook/widgets/add_to_cart.dart';
import 'package:thebasiclook/widgets/drawer.dart';
import 'package:thebasiclook/widgets/product_tile_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductBloc productBloc = ProductBloc();
  @override
  void initState() {
    productBloc.add(ProductInitialEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final token = GetStorage().read('token');
    return Scaffold(
      appBar: customAppBar(
        title: 'Product Screen',
      ),
      drawer: CustomDrawer(), //
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              showSearch(context: context, delegate: Search());
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.symmetric(
                      horizontal:
                          BorderSide(color: Colors.grey.withOpacity(0.5)))),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          BlocConsumer<ProductBloc, ProductState>(
            bloc: productBloc,
            buildWhen: (previous, current) => current is! ProductActionState,
            listenWhen: (previous, current) => current is ProductActionState,
            listener: (context, state) {
              if (state is ProductItemCartedActionState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Added To Cart')));
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return CartScreen(selectedSize: 'S');
                    }));
              }

              // TODO: implement listener
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case ProductLoadingState:
                  return Center(child: CircularProgressIndicator());
                case ProductLoadedSuccessState:
                  final successState = state as ProductLoadedSuccessState;
                  return FutureBuilder(
                      future: Products().getAllProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                              child: Text(
                            'No Products Available.',
                            style: TextStyle(color: Colors.black),
                          ));
                        }
                        return Expanded(
                            child: ProductTileWidget(
                          token: token,
                          products: successState.products,
                          productBloc: productBloc,
                        ));
                      });
                case ProductErrorState:
                  return Scaffold(
                      body: Center(
                    child: Text(
                      '${state}',
                    ),
                  ));
                default:
                  return Text(
                    '${state}',
                    style: TextStyle(color: Colors.black),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}

