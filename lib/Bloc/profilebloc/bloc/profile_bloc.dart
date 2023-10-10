import 'dart:io';


import 'package:condui_app/Bloc/profilebloc/bloc/profile_event.dart';
import 'package:condui_app/Bloc/profilebloc/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repo/allarticlerepo.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ArticleRepository repo;
  ProfileBloc({required this.repo}) : super(ProfileInitialState()) {
    on<FetchProfileEvent>(_onFetchProfileEvent);
    //on<UpdateProfileEvent>(_onUpdateProfileEvent);
    // on<ChangePasswordEvent>(_onChangePasswordEvent);
  }

  _onFetchProfileEvent(
      FetchProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoadingState());
      dynamic aData = await repo.getProfileData();
     // print(aData);

      if (aData != null) {
        //   emit(NoProfileState());
        // } else {
        emit(ProfileLoadedState(profileList: aData));
      }
    } on SocketException {
      emit(ProfileNoInternetState());
    } catch (e) {
      print(e);
      emit(ProfileLoadedErrorState(msg: e.toString()));
    }
  }

  // _onUpdateProfileEvent(
  //     UpdateProfileEvent event, Emitter<ProfileState> emit) async {
  //   emit(UpdateProfileLoadingState());
  //   try {
  //     emit(ProfileLoadingState());
  //     dynamic data = await repo.updateProfile(event.profileModel);
  //     if (data != true) {
  //       emit(UpdateProfileSuccessState());
  //     } else {
  //       emit(NoProfileState());
  //     }
  //   } on SocketException {
  //     emit(ProfileNoInternetState());
  //   } catch (e) {
  //     print(e);
  //     emit(UpdateProfileErrorState(msg: e.toString()));
  //   }
}

  // _onChangePasswordEvent(
  //     ChangePasswordEvent event, Emitter<ProfileState> emit) async {
  //   emit(ChangePasswordLoadingState());
  //   try {
  //     dynamic data = await repo.changePassword(event.profileModel);
  //     if (data == true) {
  //       emit(ChangePasswordSuccessState());
  //     } else {
  //       emit(ChangePasswordErrorState(
  //           message: "Something want wrong, please try again later"));
  //     }
  //   } on SocketException {
  //     emit(ProfileNoInternetState());
  //   } catch (e) {
  //     print(e);
  //     emit(ChangePasswordErrorState(message: e.toString()));
  //   }
  
