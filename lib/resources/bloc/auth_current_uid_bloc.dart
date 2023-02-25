import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_current_uid_event.dart';
part 'auth_current_uid_state.dart';

class AuthCurrentUidBloc
    extends Bloc<AuthCurrentUidEvent, AuthCurrentUidState> {
  AuthCurrentUidBloc() : super(AuthCurrentUidState(uid: '')) {
    on<AuthCurrentUidUpDate>((event, emit) {
      emit(state.copyWith(event.uid));
      print("Bloc Event     " + event.uid);
    });
  }
}
