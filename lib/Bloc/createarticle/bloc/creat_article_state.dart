// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'creat_article_bloc.dart';

sealed class CreatArticleState extends Equatable {
  const CreatArticleState();
  
  @override
  List<Object> get props => [];
}

final class CreatArticleInitialState extends CreatArticleState {}
class CreatArticleSuccessState extends CreatArticleState {
  String mssg;
  CreatArticleSuccessState({
    required this.mssg,
  });
}
class CreatArticleErrorState extends CreatArticleState {
  String error;
  CreatArticleErrorState({
    required this.error,
  });
}

class CreatArticleNoInternetState extends CreatArticleState {
  String netmssg;
  CreatArticleNoInternetState({
    required this.netmssg,
  });
}
