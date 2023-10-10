// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_bloc.dart';

sealed class EditState extends Equatable {
  const EditState();

  @override
  List<Object> get props => [];
}

final class EditLoadingState extends EditState {}

class EditSuccessState extends EditState {
  AllArticlesModel editedartical;
  String mssg;
  EditSuccessState({
    required this.editedartical,
    required this.mssg,
  });
}

class EditErrorState extends EditState {
  String error;
  EditErrorState({
    required this.error,
  });
}

class EditNoInternetState extends EditState {
  String net;
  EditNoInternetState({
    required this.net,
  });
}
