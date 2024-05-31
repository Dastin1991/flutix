part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserSignedOut extends UserState {}

class UserSignedIn extends UserState {
  final UserProfile userProfile;

  const UserSignedIn(this.userProfile);

  @override
  List<Object> get props => [userProfile];
}
