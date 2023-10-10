// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_article_bloc.dart';

sealed class MyArticleEvent extends Equatable {
  const MyArticleEvent();

  @override
  List<Object> get props => [];
}
class MyArticleclickedEvent extends MyArticleEvent {


} 
