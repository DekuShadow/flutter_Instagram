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
      return MessageScreen(
        uid: state.uid,
      );
    },
  ),
  BlocBuilder<AuthCurrentUidBloc, AuthCurrentUidState>(
    builder: (context, state) {
      return ProFileScreen(
        uid: state.uid,
      );
    },
  ),
];

class GlobalVariables {
  GlobalVariables._();

  static const String addLocation = "/addLocation";

  static const List<String> listMenu = [
    'Homepage',
    'Search',
    'Explore',
    'Reels',
    'message',
    'Notificatons',
    'New Post',
    'Profile'
  ];
  static List<String> IconsMenu = [
    'assets/icons/home.png',
    'assets/icons/search-outline.png',
    'assets/icons/compass.png',
    'assets/icons/video-outline.png',
    'assets/icons/send.png',
    'assets/icons/like-outline.png',
    'assets/icons/add.png',
    'assets/icons/user.png',
  ];
  static List<String> AdditionnalMenu = [
    'Setting',
    'History',
    'Bookmark',
    'Mode switch',
    'Report a problem',
    'Account switch',
    'Log out'
  ];
  static List<dynamic> AdditionnalMenuIcons = [
    Image.asset(
      'assets/icons/gear.png',
      color: Colors.white,
      scale: 17,
    ),
    Image.asset(
      'assets/icons/history.png',
      color: Colors.white,
      scale: 17,
    ),
    Image.asset(
      'assets/icons/bookmark.png',
      color: Colors.white,
      scale: 17,
    ),
    Image.asset(
      'assets/icons/eye.png',
      color: Colors.white,
      scale: 17,
    ),
    null,
    null,
    null
  ];

  static Future<Object?> singOut(String settings, context) async {
    switch (settings) {
      case 'Log out':
        return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) {
            return const LoginScreen();
          }),
        );

      default:
        return '';
    }
  }
}
