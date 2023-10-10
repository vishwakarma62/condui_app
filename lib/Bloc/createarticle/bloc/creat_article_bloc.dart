// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/conduitmodel.dart';
import '../../../repo/allarticlerepo.dart';

part 'creat_article_event.dart';
part 'creat_article_state.dart';

class CreatArticleBloc extends Bloc<CreatArticleEvent, CreatArticleState> {
  ArticleRepository repo;
  CreatArticleBloc(
    this.repo,
  ) : super(CreatArticleInitialState()) {
    on<CreatArticleInitialEvent>(creatArticleInitialEvent);
  }

  FutureOr<void> creatArticleInitialEvent(
      CreatArticleInitialEvent event, Emitter<CreatArticleState> emit) async {
    emit(CreatArticleInitialState());
    try {
      dynamic data = await repo.createArticle(event.allArticlesModel);
      if (data == true) {
        print("Article created");
        emit(CreatArticleSuccessState(mssg: "creat successfull"));
      }
    } on SocketException {
      print("connect your net");
      emit(CreatArticleNoInternetState(netmssg: "connect your net"));
    } catch (e) {
      print(e.toString());
      emit(
        CreatArticleErrorState(error: e.toString()),
      );
    }
  }
}
