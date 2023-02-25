import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../resources/auth_methods.dart';

part 'user_provider_event.dart';
part 'user_provider_state.dart';

class UserProviderBloc extends Bloc<UserProviderEvent, UserProviderState> {
  UserProviderBloc() : super(UserProviderState([])) {
    on<UserEventRefreshUser>(
      (event, emit) async {
        final AuthMethods _authMethods = AuthMethods();
        var user = await _authMethods.getUserDetails();
        // print(user.email);
        List<User> user2 = [user];
        print("ssssssssssssssssssssssssssssssss");
        print(user2[0].email);
        emit(
          UserProviderState(user2),
        );
      },
    );
  }
}
