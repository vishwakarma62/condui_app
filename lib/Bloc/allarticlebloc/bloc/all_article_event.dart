part of 'all_article_bloc.dart';

sealed class AllArticleEvent extends Equatable {
  const AllArticleEvent();

  @override
  List<Object> get props => [];
}
class AllArticleInitialEvent extends AllArticleEvent{}
