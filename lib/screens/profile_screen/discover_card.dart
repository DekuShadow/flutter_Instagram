import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram/screens/profile_screen/profile_screen.dart';
import '../../resources/bloc/auth_current_uid_bloc.dart';
import '../../resources/firestore_methods.dart';
import '../../widgets/follow_button.dart';
import 'bloc/app_bar/app_bar_bloc.dart';

class DiscoverCard extends StatefulWidget {
  final uid;
  const DiscoverCard({
    super.key,
    required this.uid,
  });

  @override
  State<DiscoverCard> createState() => _DiscoverCardState();
}

class _DiscoverCardState extends State<DiscoverCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('users').get(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  height: 200,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        List follower = snapshot.data!.docs[index]['follower'];
                        final userid = snapshot.data!.docs[index]['uid'];
                        final username = snapshot.data!.docs[index]['username'];
                        return BlocBuilder<AuthCurrentUidBloc,
                            AuthCurrentUidState>(
                          builder: (context, state) {
                            print(follower.contains(state.uid));

                            if (state.uid
                                .contains(snapshot.data!.docs[index]['uid'])) {
                              return Container();
                            }
                            return GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProFileScreen(uid: userid))),
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  height: 190,
                                  width: 160,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white24, width: 0.5),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(snapshot
                                            .data!.docs[index]['photoUrl']),
                                      ),
                                      Text(
                                        username,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      follower.contains(state.uid)
                                          ? FollowButton(
                                              backgroundColor: Colors.white,
                                              text: "Unfollow",
                                              textColor: Colors.black,
                                              function: () async {
                                                await FirestoreMethods()
                                                    .followUser(
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid,
                                                        userid);

                                                BlocProvider.of<AppBarBloc>(
                                                        context)
                                                    .add(followerEvent(
                                                        uid: widget.uid));
                                                setState(() {});
                                              },
                                            )
                                          : FollowButton(
                                              backgroundColor: Colors.blue,
                                              text: "Follow",
                                              textColor: Colors.white,
                                              function: () async {
                                                await FirestoreMethods()
                                                    .followUser(
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid,
                                                        userid);
                                                BlocProvider.of<AppBarBloc>(
                                                        context)
                                                    .add(followerEvent(
                                                        uid: widget.uid));
                                                setState(() {});
                                              },
                                            ),
                                    ],
                                  )),
                            );
                          },
                        );
                      }),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }
}
