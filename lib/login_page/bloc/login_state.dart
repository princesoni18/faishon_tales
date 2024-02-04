part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginActionState extends LoginState{}

final  class LogInProccessState extends LoginState{}

final class LoginSuccessState extends LoginActionState{}
final class LoginErrorState extends LoginActionState{

  final String content;

  LoginErrorState({required this.content});

}
