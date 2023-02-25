part of 'user_provider_bloc.dart';

abstract class UserProviderEvent extends Equatable {
  const UserProviderEvent();

  @override
  List<Object> get props => [];
}

class UserEventRefreshUser extends UserProviderEvent {}
