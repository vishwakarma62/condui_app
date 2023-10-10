// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:condui_app/repo/allarticlerepo.dart';
import 'package:equatable/equatable.dart';


part 'delete_event.dart';
part 'delete_state.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  ArticleRepository repo;
  DeleteBloc(
    this.repo,
  ) : super(DeleteLoadingState()) {
    on<DeleteclickedEvent>(deleteclickedEvent);
  }

  FutureOr<void> deleteclickedEvent(
      DeleteclickedEvent event, Emitter<DeleteState> emit) async {
    emit(DeleteLoadingState());
    try {
      dynamic data = await repo.deleteArticle(event.slugdata);
      if (data == true) {
        print("delete successfull");
        emit(DeletedState(mssg: "delete successfull"));
      }
    } on SocketException {
      print("connect your net");
      emit(DeleteNoInternetState(net: "connect your net"));
    } catch (e) {
      print(e.toString());
      emit(
        DeleteErrorState(error: e.toString()),
      );
    }
  }
}
