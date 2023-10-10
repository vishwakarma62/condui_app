// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'article_by_slug_bloc.dart';

sealed class ArticleBySlugEvent extends Equatable {
  const ArticleBySlugEvent();

  @override
  List<Object> get props => [];
}
class ArticleBySlugClickedEvent extends ArticleBySlugEvent {
  String slugdata;
  ArticleBySlugClickedEvent({
    required this.slugdata,
  });
}
