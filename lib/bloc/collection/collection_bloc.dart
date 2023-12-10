import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thebasiclook/models/cart_model/cart_model/product.dart';
import 'package:thebasiclook/services/cart.dart';
import 'package:thebasiclook/services/collections.dart';
import 'package:thebasiclook/services/products.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  CollectionBloc() : super(CollectionInitial()) {
    on<CollectionInitialEvent>(collectionInitialEvent);
    on<CollectionCartButtonClickedEvent>(collectionCartButtonClickedEvent);
  }

  FutureOr<void> collectionInitialEvent(
      CollectionInitialEvent event, Emitter<CollectionState> emit) async {
    emit(CollectionLoadingState());
    try {
      List<Product> products =
          await Collections().getCollection(keyWord: event.keyword);
      print('Number of products received: ${products.length}');
      emit(CollectionLoadedSuccessState(products: products));
    } catch (e) {
      emit(CollectionErrorState(errMessage: e.toString()));
    }
  }

  FutureOr<void> collectionCartButtonClickedEvent(
      CollectionCartButtonClickedEvent event,
      Emitter<CollectionState> emit) async {
    final String token = GetStorage().read('token');
    try {
      await CartServices().addToCart(
          token: token,
          id: '${event.clickedProduct.id}',
          size: 'S',
          quantity: 1);
      emit(CollectionCartedLoadingState());
      await Future.delayed(Duration(seconds: 3));
      emit(CollectionItemCartedActionState());
    } catch (e) {
      emit(CollectionErrorState(errMessage: e.toString()));
    }
  }
}
