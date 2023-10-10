import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../../../model/authmodel.dart';
import '../../../repo/loginrepo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepo repo;
  LoginBloc({required this.repo}) : super(LoginLoadingState()) {
    on<LoginsubmitEvent>(loginsubmitEvent);
  }
  loginsubmitEvent(LoginsubmitEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      http.Response data = await repo.login(event.requestModel);
      if (data.statusCode == 200) {
        dynamic jsonData = data.body;
        // print(jsonData);
        print("login success");
        emit(LoginLoadedState(msg: "Login Successfull"));
      } else {
        String mssg='';
        dynamic errordata = jsonDecode(data.body);
        if (errordata['errors'] != null) {
          dynamic errors = errordata['errors'];
          String firstvalue = errors.keys.first;
          print(firstvalue);
          String lastvalue = errors[firstvalue][0];
           mssg = "$firstvalue is $lastvalue";
        }

        emit(LoginErrorState(error: mssg));
      }
    } on SocketException {
      emit(LoginNoInternetState(net: "Please check your Internet Connection"));
    } catch (e) {
      print(e);
      emit(LoginErrorState(error: e.toString()));
    }
  }
}
