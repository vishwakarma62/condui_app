// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favourite_bloc.dart';

sealed class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoadingState extends FavouriteState {}

class FavouriteLoadedState extends FavouriteState {
  List<AllArticlesModel> favouritedata;
  FavouriteLoadedState({
    required this.favouritedata,
  });
}

class FavouriteErrorState extends FavouriteState {
  final String error;
  FavouriteErrorState({
    required this.error,
  });
  
}

class FavouriteNoInternetState extends FavouriteState {
  final String net;
  FavouriteNoInternetState({
    required this.net,
  });
  
}
