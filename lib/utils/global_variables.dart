import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/screens/screens.dart';

const webScreenSize = 600.0;

List<Widget> homeScreenItem = [
  const FeedScreen(
    key: PageStorageKey('FeedScreen'),
  ),
  const SearchScreen(),
  const AddPostScreen(),
  const Text("notif"),
  ProFileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
