import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thebasiclook/bloc/product/product_bloc.dart';
import 'package:thebasiclook/models/cart_model/cart_model/product.dart';
import 'package:thebasiclook/models/data_model.dart';
import 'package:thebasiclook/bloc/collection/collection_bloc.dart';

import 'package:thebasiclook/screens/productsDetails.dart';
import 'package:thebasiclook/services/collections.dart';
import 'package:thebasiclook/widgets/add_to_cart.dart';
import 'package:thebasiclook/widgets/collection_tile.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  final CollectionBloc collectionBloc = CollectionBloc();

  @override
  void initState() {
    collectionBloc.add(CollectionInitialEvent(keyword: widget.title));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Product? selectedProduct;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(widget.title),
      ),
      body: BlocConsumer<CollectionBloc, CollectionState>(
        bloc: collectionBloc,
        buildWhen: (previous, current) => current is! CollectionActionState,
        listenWhen: (previous, current) => current is CollectionState,
        listener: (context, state) {
          if (state is CollectionItemCartedActionState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Added To Cart')));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CollectionLoadingState:
              return Center(child: CircularProgressIndicator());
            case CollectionLoadedSuccessState:
              return FutureBuilder(
                  future: Collections().getCollection(keyWord: widget.title),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (!snapshot.hasData) {
                      return Text(
                        '${snapshot.error}',
                        style: TextStyle(color: Colors.black),
                      );
                    }
                    final product = snapshot.data!;
                    return CollectionTile(
                        product: product,
                        selectedProduct: selectedProduct,
                        collectionBloc: collectionBloc);
                  });
            case CollectionErrorState:
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
    );
  }
}

