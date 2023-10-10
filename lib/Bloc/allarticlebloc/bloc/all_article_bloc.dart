// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/conduitmodel.dart';
import '../../../repo/allarticlerepo.dart';





part 'all_article_event.dart';
part 'all_article_state.dart';

class AllArticleBloc extends Bloc<AllArticleEvent, AllArticleState> {
  ArticleRepository articleRepository;
  AllArticleBloc(
    this.articleRepository,
  ) : super(AllArticleLoadingState()) {
    on<AllArticleInitialEvent>(allArticleInitialEvent);
  }

  FutureOr<void> allArticleInitialEvent(
      AllArticleInitialEvent event, Emitter<AllArticleState> emit) async {
    emit(AllArticleLoadingState());
    try {
      final articledata = await articleRepository.allarticlefetchdata();
      //final intdata = await articleRepository.datafetchData();
      emit(AllArticleSuccessState(
        allarticlemodel: articledata,
      ));
    } on SocketException {
      emit(AllArticleNoInternetState(mssg: "please connect your internet"));
    } catch (e) {
      print(e);
      emit(AllArticleErrorState(error: e.toString()));
    }
  }
}
