part of 'favourite_bloc.dart';

sealed class FavouriteEvent extends Equatable {
  const FavouriteEvent();

  @override
  List<Object> get props => [];
}
class LoadingStartEvent extends FavouriteEvent{} 