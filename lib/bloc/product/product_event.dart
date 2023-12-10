part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class ProductInitialEvent extends ProductEvent {}


  

class ProductCartButtonClickedEvent extends ProductEvent {
    final Product clickedProduct;

 ProductCartButtonClickedEvent(
    {required this.clickedProduct});
}