// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'delete_bloc.dart';

sealed class DeleteEvent extends Equatable {
  const DeleteEvent();

  @override
  List<Object> get props => [];
}
class DeleteclickedEvent extends DeleteEvent {
  String slugdata;
  DeleteclickedEvent({
    required this.slugdata,
  });
}