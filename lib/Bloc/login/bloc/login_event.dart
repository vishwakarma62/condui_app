// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginsubmitEvent extends LoginEvent {
  AuthModel requestModel;
  LoginsubmitEvent({
    required this.requestModel,
  });
  @override
  List<Object> get props => [requestModel];
}

class InitUserEvent extends LoginEvent {
  final String mssg;
  InitUserEvent({
    required this.mssg,
  });
}

class ErrorEvent extends LoginEvent {}
