// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:http/http.dart' as http;

import '../../../model/authmodel.dart';
import '../../../repo/loginrepo.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  AuthRepo signUpRepository;
  SignUpBloc({
    required this.signUpRepository,
  }) : super(SignUpInitial()) {
    on<SignUPSubmitEvent>(signUPSubmitEvent);
  }

  FutureOr<void> signUPSubmitEvent(
      SignUPSubmitEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    try {
      http.Response data = await signUpRepository.signup(event.signup);
      //print(data.statusCode);
      if (data.statusCode == 200 || data.statusCode == 201) {
        print("signupseccess");
        emit(SignUpLoaded(masg: "SignUp Successfull"));
      } else {
        String mssg = '';
        dynamic errordata = jsonDecode(data.body);
        //print(errordata);
        if (errordata['errors'] != null) {
          dynamic errors = errordata['errors'];
          dynamic errorfirstvalue = errors.keys.first;
          dynamic errorbody = errors[errorfirstvalue][0];

          //print(mssg);
          dynamic usernamevalue = errors.keys.last;
          dynamic usernamebody = errors[usernamevalue][0];

          mssg = "$errorfirstvalue $errorbody, $usernamevalue $usernamebody";
          // String firstvalue = errors.keys.first;
          // print(firstvalue);
          // String lastvalue = errors[firstvalue][0];
          // mssg = "$firstvalue is $lastvalue";
        }
        emit(SignUpErrorState(error: mssg));
      }
    } on SocketException {
      emit(SignUponNoInternet(net: "Please check your Internet Connection"));
    } catch (e) {
      emit(SignUpErrorState(error: e.toString()));
    }
  }
}
