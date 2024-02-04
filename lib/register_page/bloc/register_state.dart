part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterActionState extends RegisterState{}

final class ShowInfo extends RegisterActionState{

  final String content;

  ShowInfo({required this.content});

}

final class RegisterSuccessState extends RegisterActionState{}
final class RegisterInitial extends RegisterState {}

final class SelectedImageState extends RegisterState{

  final Uint8List file;

  SelectedImageState({required this.file});
}


