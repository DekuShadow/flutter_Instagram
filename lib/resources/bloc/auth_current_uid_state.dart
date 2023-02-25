part of 'auth_current_uid_bloc.dart';

class AuthCurrentUidState extends Equatable {
  const AuthCurrentUidState({required this.uid});
  final String uid;

  AuthCurrentUidState copyWith(String? uid) {
    return AuthCurrentUidState(uid: uid!);
  }

  @override
  List<Object> get props => [uid];
}

// class AuthCurrentUidInitial extends AuthCurrentUidState {
  // AuthCurrentUidInitial(super.String);
// }
