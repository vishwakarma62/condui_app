// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'article_by_slug_bloc.dart';

sealed class ArticleBySlugState extends Equatable {
  const ArticleBySlugState();
  
  @override
  List<Object> get props => [];
}

final class ArticleBySlugLoadingState extends ArticleBySlugState {}
class ArticleBySlugSuccessState extends ArticleBySlugState {
  AllArticlesModel articledata;
  String mssg;
  ArticleBySlugSuccessState({
    required this.articledata,
    required this.mssg,
  });
}

class ArticleBySlugErrorState extends ArticleBySlugState {
  String error;
  ArticleBySlugErrorState({
    required this.error,
  });
}
class ArticleBySlugNoInternetState extends ArticleBySlugState {
  String mssg;
  ArticleBySlugNoInternetState({
    required this.mssg,
  });
}
