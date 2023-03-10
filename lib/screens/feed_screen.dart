import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram/models/models.dart';
import 'package:flutter_instagram/screens/message_screen/message_screen.dart';
import 'package:flutter_instagram/screens/profile_screen/profile_screen.dart';
import 'package:flutter_instagram/utils/colors.dart';
import 'package:flutter_instagram/utils/utills.dart';
import 'package:flutter_instagram/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/bloc/auth_current_uid_bloc.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 32,
              ),
              actions: [
                BlocBuilder<AuthCurrentUidBloc, AuthCurrentUidState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  MessageScreen(uid: state.uid))),
                      icon: Icon(Icons.message_outlined),
                      color: primaryColor,
                    );
                  },
                )
              ],
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("posts").snapshots(),
        builder: ((context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          int x = snapshot.data!.docs.length;
          print(
              "snapshot.data!.docs.length == 0 ${snapshot.data!.docs.length < 1}");
          return snapshot.data!.docs.length == 0
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(child: Text("There is no post yet.")),
                )
              : Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: width > webScreenSize ? width * 0.25 : 0,
                      vertical: width > webScreenSize ? 15 : 0),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        backgroundColor: mobileBackgroundColor,
                        // pinned: true,
                        expandedHeight: 116.0,
                        // leadingWidth: double.infinity,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Column(
                            children: [StoryCard(), const Divider()],
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: snapshot.data!.docs.length,
                          (context, index) {
                            return PostCard(
                              snap: snapshot.data!.docs[index].data(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}

class StoryCard extends StatelessWidget {
  const StoryCard({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("users").get(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshotAllser) {
          if (snapshotAllser.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            height: 100.0,
            child: ListView.builder(
                itemCount: snapshotAllser.data!.docs.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ProFileScreen(
                                    uid: snapshotAllser.data!.docs[index]
                                        ['uid']))),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          height: 70.0,
                          width: 70.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(snapshotAllser
                                      .data!.docs[index]['photoUrl'])),
                              // color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                      Text(
                        snapshotAllser.data!.docs[index]['username'],
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  );
                }),
          );
        });
  }
}
