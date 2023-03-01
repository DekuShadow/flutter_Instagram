import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram/resources/auth_methods.dart';
import 'package:flutter_instagram/resources/firestore_methods.dart';
import 'package:flutter_instagram/screens/login_screen.dart';
import 'package:flutter_instagram/screens/profile_screen/discover_card.dart';
import 'package:flutter_instagram/utils/colors.dart';
import 'package:flutter_instagram/utils/utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../utils/global_variables.dart';
import '../../widgets/widgets.dart';
import 'bloc/app_bar/app_bar_bloc.dart';

class ProFileScreen extends StatefulWidget {
  final uid;
  const ProFileScreen({super.key, required this.uid});

  @override
  State<ProFileScreen> createState() => _ProFileScreenState();
}

class _ProFileScreenState extends State<ProFileScreen> {
  bool isDiscover = false;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      BlocProvider.of<AppBarBloc>(context).add(followerEvent(uid: widget.uid));
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('ProfileUid  ' + widget.uid);
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width > webScreenSize ? width * 0.25 : 0,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: BlocBuilder<AppBarBloc, AppBarState>(
            builder: (context, state) {
              if (state is FollowerFinishState) {
                return Text(state.userData['username']);
              }
              return Text("");
            },
          ),
          centerTitle: false,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.add_box_outlined)),
            IconButton(onPressed: () {}, icon: Icon(Icons.list))
          ],
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('posts')
                .where('uid', isEqualTo: widget.uid)
                .get(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return !snapshot.hasData
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          pinned: true,
                          // floating: true,
                          // snap: false,
                          backgroundColor: mobileBackgroundColor,
                          expandedHeight: isDiscover ? 250 : 470.0,
                          toolbarHeight: 64,
                          collapsedHeight: 64,
                          bottom: PreferredSize(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 24.0),
                              color: Colors.black,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    color: currentIndex == 0
                                        ? Colors.white
                                        : Colors.white38,
                                    icon: Icon(
                                      Icons.auto_awesome_mosaic_rounded,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        currentIndex = 0;
                                      });
                                    },
                                  ),
                                  IconButton(
                                    color: currentIndex == 1
                                        ? Colors.white
                                        : Colors.white38,
                                    icon: Icon(
                                      Icons.assignment_ind_outlined,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        currentIndex = 1;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            preferredSize:
                                Size(MediaQuery.of(context).size.width, 0),
                          ),
                          leadingWidth: double.infinity,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Column(
                              children: [
                                Container(child: TopProfile()),
                                DiscoverCard(
                                  uid: widget.uid,
                                )
                              ],
                            ),
                          ),
                        ),
                        currentIndex == 0
                            ? SliverGrid(
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150.0,
                                  mainAxisSpacing: 3.0,
                                  crossAxisSpacing: 3.0,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    if (snapshot.data!.docs[index]
                                            ['postVideo'] !=
                                        '') return Container();
                                    return Container(
                                      child: Image.network(
                                        snapshot.data!.docs[index]['postUrl'],
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                  childCount: snapshot.data!.docs.length,
                                ),
                              )
                            : SliverGrid(
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: double.infinity,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/icons/follower.png',
                                              color: Colors.white,
                                              scale: 5,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Photos and videos of you",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                "When people tag you in photos and videos,they'll appear here")
                                          ],
                                        ));
                                  },
                                  childCount: 1,
                                ),
                              ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  TopProfile() {
    return BlocBuilder<AppBarBloc, AppBarState>(
      builder: (context, state) {
        if (state is FollowerFinishState) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(state.userData['photoUrl']),
                      radius: 40,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildStatColumn(state.postLen, 'posts'),
                              buildStatColumn(state.followers, "follower"),
                              buildStatColumn(state.following, "following")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    state.userData['username'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                // Container(
                //   alignment: Alignment.centerLeft,
                //   padding: const EdgeInsets.only(top: 1),
                //   child: Text(
                //     state.userData['bio'],
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FirebaseAuth.instance.currentUser!.uid == widget.uid
                        ? FollowButton(
                            backgroundColor: Colors.white30,
                            text: "Sign out",
                            textColor: primaryColor,
                            function: () async {
                              await AuthMethods().signOut();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            },
                          )
                        : state.isFollowing
                            ? FollowButton(
                                backgroundColor: Colors.white,
                                text: "Unfollow",
                                textColor: Colors.black,
                                function: () async {
                                  await FirestoreMethods().followUser(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      state.userData['uid']);

                                  // isFollowing = false;
                                  BlocProvider.of<AppBarBloc>(context)
                                      .add(followerEvent(uid: widget.uid));

                                  // getData();
                                },
                              )
                            : FollowButton(
                                backgroundColor: Colors.blue,
                                text: "Follow",
                                textColor: Colors.white,
                                function: () async {
                                  await FirestoreMethods().followUser(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      state.userData['uid']);

                                  // state.isFollowing = true;
                                  BlocProvider.of<AppBarBloc>(context)
                                      .add(followerEvent(uid: widget.uid));
                                  // getData();
                                },
                              ),
                    FirebaseAuth.instance.currentUser!.uid == widget.uid
                        ? MessageButton(
                            function: () {},
                            backgroundColor: Colors.white30,
                            text: 'Share Profile',
                            textColor: Colors.white)
                        : MessageButton(
                            function: () {},
                            backgroundColor: Colors.white30,
                            text: 'Message',
                            textColor: Colors.white),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isDiscover = !isDiscover;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 3),
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/icons/add-user.png',
                          color: Colors.white,
                        ),
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
