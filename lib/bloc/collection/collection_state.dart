part of 'collection_bloc.dart';

sealed class CollectionState extends Equatable {
  const CollectionState();

  @override
  List<Object> get props => [];
}

abstract class CollectionActionState extends CollectionState {}

final class CollectionInitial extends CollectionState {}

class CollectionLoadingState extends CollectionState {}

class CollectionLoadedSuccessState extends CollectionState {
  final List<Product> products;

  CollectionLoadedSuccessState({required this.products});
}

class CollectionErrorState extends CollectionState {
  final String errMessage;

  CollectionErrorState({required this.errMessage});
}

class CollectionCartedLoadingState extends CollectionActionState {}

class CollectionItemCartedActionState extends CollectionActionState {}
