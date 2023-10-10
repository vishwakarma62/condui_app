// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_bloc.dart';

sealed class EditEvent extends Equatable {
  const EditEvent();

  @override
  List<Object> get props => [];
}
class EditclickedEvent extends EditEvent {
  AllArticlesModel editdata;
  String slugdata;

  EditclickedEvent({
    required this.editdata,
    required this.slugdata,
  });
    @override
  List<Object> get props => [editdata,slugdata];
}
