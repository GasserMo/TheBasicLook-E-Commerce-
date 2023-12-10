import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:thebasiclook/models/cart_model/cart_model/cart.dart';
import 'package:thebasiclook/models/cart_model/cart_model/product.dart';
import 'package:thebasiclook/services/cart.dart';
import 'package:thebasiclook/services/products.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductInitialEvent>(productInitialEvent);
    on<ProductCartButtonClickedEvent>(productCartButtonClickedEvent);
  }

  FutureOr<void> productInitialEvent(
      ProductInitialEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      List<Product> products = await Products().getAllProducts();
      print('Number of products received: ${products.length}');
      emit(ProductLoadedSuccessState(products: products));
    } catch (e) {
      emit(ProductErrorState(errMessage: e.toString()));
    }
  }

  FutureOr<void> productCartButtonClickedEvent(
      ProductCartButtonClickedEvent event, Emitter<ProductState> emit) async {
    final String token = GetStorage().read('token');
    try {
      final response = await CartServices().addToCart(
          token: token,
          id: '${event.clickedProduct.id}',
          size: 'S',
          quantity: 1);
      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('product is added ');
        print(responseData);
      } else {
        print(response.body);
        print(response.statusCode);
      }
      emit(ProductCartedLoadingState());

      await Future.delayed(Duration(seconds: 3));
      emit(ProductItemCartedActionState());
    } catch (e) {
      emit(ProductErrorState(errMessage: e.toString()));
    }
  }
}
