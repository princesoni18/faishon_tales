part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

final class SelectImageEvent extends RegisterEvent{

  
}

final class CreateUser extends RegisterEvent{

  final String name;
  final String email;
  final String password;
  final Uint8List file;

  CreateUser({required this.name, required this.email, required this.password, required this.file});
}