part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

abstract class ProductActionState extends ProductState {}

final class ProductInitial extends ProductState {}
class ProductLoadingState extends ProductState {}

class ProductLoadedSuccessState extends ProductState {
  final List<Product>products;

  ProductLoadedSuccessState({required this.products});
}

class ProductErrorState extends ProductState {
  final String errMessage;

  ProductErrorState({required this.errMessage});
}
class ProductCartedLoadingState extends ProductActionState {}

class ProductItemCartedActionState extends ProductActionState {}

