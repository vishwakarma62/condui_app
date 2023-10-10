// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:condui_app/model/conduitmodel.dart';
import 'package:condui_app/repo/allarticlerepo.dart';
import 'package:equatable/equatable.dart';


part 'article_by_slug_event.dart';
part 'article_by_slug_state.dart';

class ArticleBySlugBloc extends Bloc<ArticleBySlugEvent, ArticleBySlugState> {
  ArticleRepository repo;
  ArticleBySlugBloc(
    this.repo,
  ) : super(ArticleBySlugLoadingState()) {
    on<ArticleBySlugClickedEvent>(articleBySlugClickedEvent);
  }

  FutureOr<void> articleBySlugClickedEvent(
      ArticleBySlugClickedEvent event, Emitter<ArticleBySlugState> emit) async {
    emit(ArticleBySlugLoadingState());
    try {
      final articles = await repo.createArticlebyslug(event.slugdata);
      
      //final intdata = await articleRepository.datafetchData();
      print("article by slug success");
      emit(ArticleBySlugSuccessState(
        mssg: "success",
        articledata: articles,
      ));
    } on SocketException {
      emit(ArticleBySlugNoInternetState(mssg: "please connect your internet"));
    } catch (e) {
      print(e);
      emit(ArticleBySlugErrorState(error: e.toString()));
    }
  }
}
