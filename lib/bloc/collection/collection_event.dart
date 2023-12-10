part of 'collection_bloc.dart';

sealed class CollectionEvent extends Equatable {
  const CollectionEvent();

  @override
  List<Object> get props => [];
}
class CollectionInitialEvent extends CollectionEvent {
   final String keyword; // Add the keyword parameter

  const CollectionInitialEvent({required this.keyword});
}

class CollectionCartButtonClickedEvent extends CollectionEvent {
    final Product clickedProduct;

 CollectionCartButtonClickedEvent(
    {required this.clickedProduct});
}