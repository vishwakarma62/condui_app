
import 'dart:io';



import 'package:condui_app/repo/allarticlerepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'liked_event.dart';
import 'liked_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  ArticleRepository repo;
  LikeBloc({required this.repo}) : super(LikeInitialState()) {
    on<LikeArticleEvent>(_onLikeArtice);
    on<RemoveLikeArticleEvent>(_onRemoveLikeArticle);
  }
  _onLikeArtice(LikeArticleEvent event, Emitter<LikeState> emit) async {
    try {
      emit(LikeLoadingState());
      dynamic data = await repo.likeArticle(event.slug);
      if (data == true) {
        print("Item added successfully in favourite list");
        emit(LikeSuccessState(msg: "Item added successfully in favourite list"));
      }
    } on SocketException {
      emit(LikeNoInternetState());
    } catch (e) {
      print(e.toString());
      emit(
        LikeErrorState(msg: e.toString()),
      );
    }
  }

  _onRemoveLikeArticle(
      RemoveLikeArticleEvent event, Emitter<LikeState> emit) async {
    try {
      emit(LikeLoadingState());
      dynamic data = await repo.removeLikeArticle(event.slug);
      if (data == true) {
        print("Item removed successfully in favourite list");
        emit(RemoveLikeSuccessState(
            msg: "Item removed successfully in favourite list"));
      }
    } on SocketException {
      emit(LikeNoInternetState());
    } catch (e) {
      print(e.toString());
      emit(
        LikeErrorState(msg: e.toString()),
      );
    }
  }
}