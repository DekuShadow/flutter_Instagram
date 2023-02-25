import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram/providers/providers.dart';
import 'package:flutter_instagram/utils/colors.dart';
import 'package:flutter_instagram/utils/utills.dart';
import 'package:provider/provider.dart';
import 'package:flutter_instagram/models/user.dart' as model;

import '../resources/bloc/auth_current_uid_bloc.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    BlocProvider.of<AuthCurrentUidBloc>(context).add(
      AuthCurrentUidUpDate(
        uid: FirebaseAuth.instance.currentUser!.uid,
      ),
    );
    print(
      "Mobile Screen" + FirebaseAuth.instance.currentUser!.uid,
    );
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: PageView(
        children: homeMobileScreenItem,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        height: 60,
        currentIndex: _page,
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/home-outline.png',
              color: _page == 0 ? primaryColor : secondaryColor,
              scale: 18,
            ),
            label: null,
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/search-outline.png',
              color: _page == 1 ? primaryColor : secondaryColor,
              scale: 20,
            ),
            label: null,
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/add.png',
              color: _page == 2 ? primaryColor : secondaryColor,
              scale: 14,
            ),
            label: null,
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/video-outline.png',
              color: _page == 3 ? primaryColor : secondaryColor,
              scale: 20,
            ),
            label: null,
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/user.png',
              color: _page == 4 ? primaryColor : secondaryColor,
              scale: 15,
            ),
            label: null,
            backgroundColor: primaryColor,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
