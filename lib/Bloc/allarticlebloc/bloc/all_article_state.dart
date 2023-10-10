// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'all_article_bloc.dart';

sealed class AllArticleState extends Equatable {
  const AllArticleState();

  @override
  List<Object> get props => [];
}

class AllArticleLoadingState extends AllArticleState {}

class AllArticleNoInternetState extends AllArticleState {
  final String mssg;
  AllArticleNoInternetState({
    required this.mssg,
  });
  @override
  List<Object> get props => [mssg];
}

class AllArticleErrorState extends AllArticleState {
  final String error;
  AllArticleErrorState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

class AllArticleSuccessState extends AllArticleState {
  List<AllArticlesModel> allarticlemodel;

  AllArticleSuccessState({
    required this.allarticlemodel,
  });
  @override
  List<Object> get props => [allarticlemodel];
}
