import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_instagram/models/photo_url.dart';
import 'package:flutter_instagram/screens/message_screen/chat_screen/chat_screen.dart';
import 'package:flutter_instagram/screens/message_screen/search_message_screen.dart';
import 'package:flutter_instagram/screens/message_screen/widget_screen_widget/message_app_bar.dart';
import 'package:flutter_instagram/screens/message_screen/widget_screen_widget/list_message.dart';
import 'package:flutter_instagram/screens/message_screen/widget_screen_widget/message_story.dart';

class MessageScreen extends StatefulWidget {
  String uid;
  MessageScreen({super.key, required this.uid});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  bool isWitchAccount = false;
  var switchAccountPosition = 0;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('message')
            .where('form_uid', isEqualTo: widget.uid)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return Container(
            // margin: const EdgeInsets.symmetric(horizontal: 500),
            // padding: EdgeInsets.symmetric(horizontal: 400),
            child: Scaffold(
              appBar: PreferredSize(
                  child: SafeArea(
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(color: Colors.black),
                          child: MessageAppBar(
                            function: () {
                              setState(() {
                                isWitchAccount = !isWitchAccount;
                                switchAccountPosition = height.toInt() - (250);
                              });
                            },
                            username: snapshot.data!.docs[0]['form_name'],
                          ))),
                  preferredSize: Size(double.infinity, 50)),
              body: !snapshot.hasData
                  ? Container(
                      child:
                          Center(child: CircularProgressIndicator.adaptive()),
                    )
                  : SafeArea(
                      child: Stack(
                        children: [
                          CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SearchMessageScreen()));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 15, right: 15, top: 20),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white24),
                                    height: 35,
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Icon(Icons.search_outlined),
                                        Text("Search")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Container(
                                    margin: EdgeInsets.only(top: 35),
                                    child: MessageStory()),
                              ),
                              SliverPadding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                sliver: SliverToBoxAdapter(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Messages',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            "Resquests",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blue),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SliverPadding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                sliver: SliverGrid(
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: double.infinity,
                                          mainAxisSpacing: 0,
                                          crossAxisSpacing: 0.0,
                                          childAspectRatio: width * 0.013),
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatScreen(
                                                            form_uid:
                                                                widget.uid)));
                                          },
                                          child: ListMessage(
                                            form_uid: snapshot.data!.docs[index]
                                                ['form_uid'],
                                            to_avatar: snapshot
                                                .data!.docs[index]['to_avatar'],
                                            to_name: snapshot.data!.docs[index]
                                                ['form_name'],
                                          ));
                                    },
                                    childCount: snapshot.data!.docs.length,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (isWitchAccount)
                            AnimatedContainer(
                              height: height,
                              width: width,
                              color: isWitchAccount
                                  ? Colors.black.withOpacity(0.5)
                                  : Colors.black.withOpacity(0.1),
                              duration: Duration(microseconds: 200),
                            ),
                          AnimatedPositioned(
                              curve: Curves.bounceInOut,
                              top: isWitchAccount
                                  ? switchAccountPosition.toDouble()
                                  : height + 170,
                              duration: Duration(milliseconds: 200),
                              child: GestureDetector(
                                  onPanUpdate: (details) {
                                    setState(() {
                                      if (details.globalPosition.dy.toInt() >
                                          height - 50) {
                                        switchAccountPosition =
                                            height.toInt() - (220);
                                        print(switchAccountPosition);
                                        isWitchAccount = false;
                                      } else if (details.globalPosition.dy
                                              .toInt() <
                                          height.toInt() - (220)) {
                                        switchAccountPosition =
                                            height.toInt() - (220);
                                      } else {
                                        switchAccountPosition =
                                            details.globalPosition.dy.toInt();
                                      }
                                    });
                                    print(details.globalPosition.dy);
                                  },
                                  child: AddAccount()))
                        ],
                      ),
                    ),
            ),
          );
        });
  }
}

class AddAccount extends StatelessWidget {
  const AddAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 15, right: 15),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 45, 45, 45),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
      height: 500,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            height: 5,
            width: 50,
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              print('profile');
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  foregroundImage: NetworkImage(PhotoUrl().photoUrl[1]),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "username",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              print('Add account');
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Icon(
                    Icons.add,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Add account",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
