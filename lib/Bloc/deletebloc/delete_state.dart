// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'delete_bloc.dart';

sealed class DeleteState extends Equatable {
  const DeleteState();

  @override
  List<Object> get props => [];
}

final class DeleteLoadingState extends DeleteState {}

class DeletedState extends DeleteState {
  String mssg;
  DeletedState({
    required this.mssg,
  });
}

class DeleteErrorState extends DeleteState {
  String error;
  DeleteErrorState({
    required this.error,
  });
}

class DeleteNoInternetState extends DeleteState {
  String net;
  DeleteNoInternetState({
    required this.net,
  });
}