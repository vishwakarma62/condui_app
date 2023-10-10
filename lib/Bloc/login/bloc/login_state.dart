// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}



 class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

final class LoginNoInternetState extends LoginState {
  String net;
  LoginNoInternetState({
    required this.net,
  });
  @override
  List<Object> get props => [net];
}

final class LoginLoadedState extends LoginState {
  String msg;
  LoginLoadedState({required this.msg});
  @override
  List<Object> get props => [msg];
}

class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}
