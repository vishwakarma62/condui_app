// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:condui_app/model/conduitmodel.dart';
import 'package:condui_app/repo/allarticlerepo.dart';
import 'package:equatable/equatable.dart';



part 'my_article_event.dart';
part 'my_article_state.dart';

class MyArticleBloc extends Bloc<MyArticleEvent, MyArticleState> {
  ArticleRepository articleRepository;
  MyArticleBloc(
    this.articleRepository,
  ) : super(MyArticleLoadingState()) {
    on<MyArticleclickedEvent>(myArticleclickedEvent);
  }

  FutureOr<void> myArticleclickedEvent(
      MyArticleclickedEvent event, Emitter<MyArticleState> emit) async {
    emit(MyArticleLoadingState());
    try {
      final articledata = await articleRepository.myarticle();
      //final intdata = await articleRepository.datafetchData();

      emit(MyArticleSuccessState(
        allarticle: articledata,
      ));
    } on SocketException {
      emit(MyArticleNoInternetState(mssg: "please connect your internet"));
    } catch (e) {
      print(e);
      emit(MyArticleErrorState(error: e.toString()));
    }
  }
}
