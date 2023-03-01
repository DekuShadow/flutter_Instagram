import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram/responsives/web_screen/widget/new_post.dart';
import 'package:flutter_instagram/responsives/web_screen/widget/notifications%20_widget.dart';
import 'package:flutter_instagram/responsives/web_screen/widget/search_widget.dart';
import 'package:flutter_instagram/screens/message_screen/message_screen.dart';
import 'package:flutter_instagram/screens/profile_screen/profile_screen.dart';
import 'package:flutter_instagram/utils/utills.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../resources/auth_methods.dart';
import '../../resources/bloc/auth_current_uid_bloc.dart';
import '../../screens/login_screen.dart';
import '../../utils/colors.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  late PageController pageController;
  final double webIconsize = 10;
  bool _more = true;
  int _page = 0;
  bool _isSearch = false;
  bool _isNotificatons = false;

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

  void navigationTapped(
    String page,
    int index,
  ) {
    BlocProvider.of<AuthCurrentUidBloc>(context).add(
      AuthCurrentUidUpDate(
        uid: FirebaseAuth.instance.currentUser!.uid,
      ),
    );
    switch (page) {
      case 'Homepage':
        pageController.jumpToPage(index);
        setState(() {
          _page = index;
          _isSearch = false;
          _isNotificatons = false;
        });
        break;
      case 'Search':
        setState(() {
          _isSearch = !_isSearch;
          print(_isSearch);
          _page = index;
        });
        break;
      case 'Explore':
        pageController.jumpToPage(index - 1);
        setState(() {
          _page = index;
          _isSearch = false;
          _isNotificatons = false;
        });
        break;
      case 'Reels':
        pageController.jumpToPage(index);
        setState(() {
          _page = index;
          _isSearch = false;
          _isNotificatons = false;
        });
        break;
      case 'message':
        // pageController.jumpToPage(index);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                BlocBuilder<AuthCurrentUidBloc, AuthCurrentUidState>(
                  builder: (context, state) {
                    return MessageScreen(
                      uid: state.uid,
                    );
                  },
                )));
        setState(() {
          _page = index;
          _isSearch = false;
          _isNotificatons = false;
        });
        break;
      case 'Notificatons':
        // pageController.jumpToPage(index);
        setState(() {
          _page = index;
          _isSearch = false;
          _isNotificatons = !_isNotificatons;
        });
        break;
      case 'New Post':
        // pageController.jumpToPage(index);
        showDialog(context: context, builder: (context) => NewPost());
        setState(() {
          _page = index;
          _isSearch = false;
          _isNotificatons = false;
        });
        break;
      case 'Profile':
        pageController.jumpToPage(index);
        setState(() {
          _page = index;
          _isSearch = false;
          _isNotificatons = false;
        });
        break;

      default:
    }
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
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: homeWebScreenItem,
            onPageChanged: onPageChanged,
          ),
          AnimatedPositioned(
            left: _isSearch ? 0 : -470,
            duration: Duration(milliseconds: 300),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 70),
              child: SearchWidget(),
            ),
          ),
          AnimatedPositioned(
            left: _isNotificatons ? 0 : -470,
            duration: Duration(milliseconds: 300),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 70),
              child: NotificationsWidget(),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              border: Border(
                right: BorderSide(color: Color(0xFFFFFFFF), width: 0.15),
              ),
            ),
            width: width < 1300 || _isSearch || _isNotificatons ? 70 : 245,
            height: MediaQuery.of(context).size.height,
            child: height < 250
                ? Container()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      width < 1300 || _isSearch || _isNotificatons
                          ? Image.asset(
                              'assets/logo.png',
                              fit: BoxFit.cover,
                              scale: 50,
                              color: Colors.white,
                            )
                          : SvgPicture.asset(
                              'assets/ic_instagram.svg',
                              color: primaryColor,
                              height: 32,
                            ),
                      Container(
                        height: height - 250,
                        child: ListView.builder(
                          itemCount: GlobalVariables.listMenu.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: FloatingActionButton.extended(
                                label: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      GlobalVariables.IconsMenu[index],
                                      scale: 22,
                                      color: _page == index
                                          ? primaryColor
                                          : secondaryColor,
                                    ),
                                    width < 1300 || _isSearch || _isNotificatons
                                        ? SizedBox()
                                        : AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 200),
                                            padding: EdgeInsets.only(
                                                left: 10, right: 50),
                                            child: Text(
                                              GlobalVariables.listMenu[index],
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                  ],
                                ),
                                foregroundColor: _page == index
                                    ? primaryColor
                                    : secondaryColor,
                                backgroundColor: webBackgroundColor,
                                onPressed: () => navigationTapped(
                                    GlobalVariables.listMenu[index], index),
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
                              width < 1300 || _isSearch || _isNotificatons
                                  ? SizedBox()
                                  : AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      padding:
                                          EdgeInsets.only(left: 10, right: 110),
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
            bottom: 110,
            child: AnimatedContainer(
              curve: Curves.bounceInOut,
              duration: Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 51, 51, 51),
              ),
              height: _more ? 0 : 330,
              width: 233,
              child: ListView.builder(
                itemCount: GlobalVariables.AdditionnalMenu.length,
                itemBuilder: (contaxt, index) => FloatingActionButton.extended(
                  hoverColor: Color.fromARGB(255, 18, 18, 18),
                  // focusColor: Colors.red,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  label: Container(
                    width: 200,
                    padding: EdgeInsets.only(left: 10, right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          GlobalVariables.AdditionnalMenu[index],
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        GlobalVariables.AdditionnalMenuIcons[index] == null
                            ? Text('')
                            : GlobalVariables.AdditionnalMenuIcons[index]
                      ],
                    ),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black.withOpacity(0),
                  onPressed: () {
                    setState(() {
                      GlobalVariables.singOut(
                          GlobalVariables.AdditionnalMenu[index], contaxt);
                      print(_more);
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
