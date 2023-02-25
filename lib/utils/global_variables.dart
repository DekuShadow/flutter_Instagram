import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram/screens/screens.dart';

import '../resources/bloc/auth_current_uid_bloc.dart';

const webScreenSize = 600.0;

List<Widget> homeMobileScreenItem = [
  const FeedScreen(
    key: PageStorageKey('FeedScreen'),
  ),
  const SearchScreen(),
  const AddPostScreen(),
  const ReelsScreen(),
  BlocBuilder<AuthCurrentUidBloc, AuthCurrentUidState>(
    builder: (context, state) {
      print("Glorbal UID     " + state.uid);
      return ProFileScreen(
        uid: state.uid,
      );
    },
  ),
];
List<Widget> homeWebScreenItem = [
  const FeedScreen(
    key: PageStorageKey('FeedScreen'),
  ),
  const SearchScreen(),
  const AddPostScreen(),
  const ReelsScreen(),
  BlocBuilder<AuthCurrentUidBloc, AuthCurrentUidState>(
    builder: (context, state) {
      return ProFileScreen(
        uid: state.uid,
      );
    },
  ),
];
