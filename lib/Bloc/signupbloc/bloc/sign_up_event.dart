// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUPSubmitEvent extends SignUpEvent {
  AuthModel signup;
  SignUPSubmitEvent({
    required this.signup,
  });
  @override
  List<Object> get props => [signup];
}

class SignUPuserinitEvent extends SignUpEvent {
  final String mssg;
  SignUPuserinitEvent({
    required this.mssg,
  });
  @override
  List<Object> get props => [mssg];
}
