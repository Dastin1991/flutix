part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class SignInBloc extends UserEvent {
  final String email;
  final String password;

  const SignInBloc({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignOut extends UserEvent {}

class CheckSignInStatus extends UserEvent {}
