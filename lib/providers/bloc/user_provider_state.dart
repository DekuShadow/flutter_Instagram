part of 'user_provider_bloc.dart';

@immutable
class UserProviderState extends Equatable {
  List<User> user;
  UserProviderState(this.user);

  @override
  List<Object> get props => [user];
}

// class UserProviderInitial extends UserProviderState {}
