part of 'auth_current_uid_bloc.dart';

abstract class AuthCurrentUidEvent extends Equatable {
  const AuthCurrentUidEvent();

  @override
  List<Object> get props => [];
}

class AuthCurrentUidUpDate extends AuthCurrentUidEvent {
  final String uid;

  AuthCurrentUidUpDate({required this.uid});
}
