// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

 class SignUpLoading extends SignUpState {
  @override
  List<Object> get props => [];
}

 class SignUpLoaded extends SignUpState {
  String masg;
  SignUpLoaded({required this.masg});
  @override
  List<Object> get props => [masg];
}

 class SignUpErrorState extends SignUpState {
  final String error;

  SignUpErrorState({required this.error});
    @override
  List<Object> get props => [error];
}
class SignUponNoInternet extends SignUpState {
String net;
  SignUponNoInternet({
    required this.net,
  });
     @override
  List<Object> get props => [net];

}