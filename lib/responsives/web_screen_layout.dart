import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram/utils/utills.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/bloc/auth_current_uid_bloc.dart';
import '../utils/colors.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  bool _more = true;
  int _page = 0;
  late PageController pageController;
  final double webIconsize = 10;
  final List<String> _listMenu = [
    'Homepage',
    'Search',
    'Explore',
    'Reels',
    // 'message',
    // 'Notificatons',
    // 'New Post',
    'Profile'
  ];
  final List<String> _Icons = [
    'assets/icons/home.png',
    'assets/icons/search-outline.png',
    'assets/icons/compass.png',
    'assets/icons/video-outline.png',
    'assets/icons/send.png',
    'assets/icons/like-outline.png',
    'assets/icons/add.png',
    'assets/icons/user.png',
  ];

  final List<String> _atnMenu = [
    'Setting',
    'History',
    'Bookmark',
    'Mode switch',
    'Report a problem',
    'Account switch',
    'Log out'
  ];
  final List<dynamic> _atnMenuIcons = [
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

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    BlocProvider.of<AuthCurrentUidBloc>(context).add(
      AuthCurrentUidUpDate(
        uid: FirebaseAuth.instance.currentUser!.uid,
      ),
    );
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    print(height);
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: mobileBackgroundColor,
      //   centerTitle: false,
      //   title: SvgPicture.asset(
      //     'assets/ic_instagram.svg',
      //     color: primaryColor,
      //     height: 32,
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () => navigationTapped(0),
      //       icon: Icon(Icons.home),
      //       color: _page == 0 ? primaryColor : secondaryColor,
      //     ),
      //     IconButton(
      //       onPressed: () => navigationTapped(1),
      //       icon: Icon(Icons.search),
      //       color: _page == 1 ? primaryColor : secondaryColor,
      //     ),
      //     IconButton(
      //       onPressed: () => navigationTapped(2),
      //       icon: Icon(Icons.add_a_photo),
      //       color: _page == 2 ? primaryColor : secondaryColor,
      //     ),
      //     IconButton(
      //       onPressed: () => navigationTapped(3),
      //       icon: Icon(Icons.favorite),
      //       color: _page == 3 ? primaryColor : secondaryColor,
      //     ),
      //     IconButton(
      //       onPressed: () => navigationTapped(4),
      //       icon: Icon(Icons.person),
      //       color: _page == 4 ? primaryColor : secondaryColor,
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: homeWebScreenItem,
            onPageChanged: onPageChanged,
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 5),
            // alignment: Alignment.,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              border: Border(
                // top: BorderSide(color: Color(0xFFFFFFFF)),
                // left: BorderSide(color: Color(0xFFFFFFFF)),
                right: BorderSide(color: Color(0xFFFFFFFF), width: 0.15),
                // bottom: BorderSide(),
              ),
            ),
            width: width < 1300 ? 70 : 245,
            height: MediaQuery.of(context).size.height,
            child: height < 250
                ? Container()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 20),
                        child: SvgPicture.asset(
                          width < 1300 ? '' : 'assets/ic_instagram.svg',
                          color: primaryColor,
                          height: 32,
                        ),
                      ),
                      Container(
                        // alignment: Alignment.topRight,
                        // color: Colors.white,
                        height: height - 250,
                        // width: double.infinity,
                        child: ListView.builder(
                          itemCount: _listMenu.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: FloatingActionButton.extended(
                                label: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      _Icons[index],
                                      scale: 20,
                                      color: _page == index
                                          ? primaryColor
                                          : secondaryColor,
                                    ),
                                    width < 1300
                                        ? SizedBox()
                                        : AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 200),
                                            padding: EdgeInsets.only(
                                                left: 10, right: 50),
                                            child: Text(
                                              _listMenu[index],
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                  ],
                                ),
                                foregroundColor: _page == index
                                    ? primaryColor
                                    : secondaryColor,
                                backgroundColor: webBackgroundColor,
                                onPressed: () => navigationTapped(index),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 25,
                        ),
                        child: FloatingActionButton.extended(
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.more_vert_sharp,
                                size: 35,
                                color: /* _page == index ? primaryColor : */
                                    secondaryColor,
                              ),
                              width < 1300
                                  ? SizedBox()
                                  : AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      padding:
                                          EdgeInsets.only(left: 10, right: 50),
                                      child: Text(
                                        'More',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                            ],
                          ),
                          foregroundColor:
                              _more ? primaryColor : secondaryColor,
                          backgroundColor: webBackgroundColor,
                          onPressed: () {
                            setState(() {
                              _more = !_more;
                              print(_more);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
          ),
          Positioned(
              left: 12,
              bottom: 85,
              child: AnimatedContainer(
                curve: Curves.bounceInOut,
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: webBackgroundColor,
                ),
                height: _more ? 0 : 330,
                width: 233,
                child: ListView.builder(
                    itemCount: _atnMenu.length,
                    itemBuilder: (contaxt, index) => Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                          height: 40,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _atnMenu[index],
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                              _atnMenuIcons[index] == null
                                  ? Text('')
                                  : _atnMenuIcons[index]
                            ],
                          ),
                        )),
              ))
        ],
      ),
    );
  }
}
