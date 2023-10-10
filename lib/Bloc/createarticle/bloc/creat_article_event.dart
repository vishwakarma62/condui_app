// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'creat_article_bloc.dart';

sealed class CreatArticleEvent extends Equatable {
  const CreatArticleEvent();

  @override
  List<Object> get props => [];
}
class CreatArticleInitialEvent extends CreatArticleEvent {
  AllArticlesModel allArticlesModel;
  CreatArticleInitialEvent({
    required this.allArticlesModel,
  });
}
