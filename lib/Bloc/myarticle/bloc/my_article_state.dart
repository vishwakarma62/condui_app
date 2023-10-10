// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_article_bloc.dart';

sealed class MyArticleState extends Equatable {
  const MyArticleState();

  @override
  List<Object> get props => [];
}

class MyArticleLoadingState extends MyArticleState {}

class MyArticleSuccessState extends MyArticleState {
  List<AllArticlesModel> allarticle;
  MyArticleSuccessState({
    required this.allarticle,
  });
  @override
  List<Object> get props => [allarticle];
}

class MyArticleErrorState extends MyArticleState {
  final String error;
  MyArticleErrorState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

class MyArticleNoInternetState extends MyArticleState {
  final String mssg;
  MyArticleNoInternetState({
    required this.mssg,
  });
  @override
  List<Object> get props => [mssg];
}
