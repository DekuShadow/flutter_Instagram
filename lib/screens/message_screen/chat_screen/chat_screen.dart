import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram/models/models.dart';

import 'chat_widget/chat_bar_custom.dart';
import 'chat_widget/chat_box.dart';
import 'chat_widget/chat_input_button.dart';

class ChatScreen extends StatefulWidget {
  String form_uid;
  ChatScreen({super.key, required this.form_uid});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ScrollController scrollController = ScrollController();
  double x = 0.0;
  @override
  void initState() {
    scrollController
      ..addListener(() {
        print(scrollController.offset);
        setState(() {
          x = scrollController.offset;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('message')
            .doc('rTYm4seRyblbAvMeCxy3')
            .collection('msglist')
            // .where('form_uid', isEqualTo: widget.form_uid)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          print(snapshot.data!.docs[0]['content']);

          return Scaffold(
            appBar: PreferredSize(
                child: SafeArea(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(color: Colors.black),
                        child: ChatBarCustom())),
                preferredSize: Size(double.infinity, 50)),
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                            alignment: Alignment.topCenter, child: initCat()),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: double.infinity,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0.0,
                            childAspectRatio: 10.0,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              bool x = true;
                              String uid = snapshot.data!.docs[index]['uid'];
                              print(uid);
                              print(uid == 'iq6TMnOf8aMklpT3JONlTk0KFEC2');

                              uid == widget.form_uid ? x = true : x = false;

                              return ChatBox(
                                isIndex: x,
                                content: snapshot.data!.docs[index]['content'],
                              );
                            },
                            childCount: snapshot.data!.docs.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    child: Container(
                        decoration: BoxDecoration(color: Colors.black),
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          bottom: 20,
                          top: 10,
                        ),
                        child: ChatInputButton()),
                  ),
                  Text(x.toString()),
                ],
              ),
            ),
          );
        });
  }
}

class initCat extends StatelessWidget {
  const initCat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(PhotoUrl().photoUrl[0]),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Username"),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.white24),
            ),
            onPressed: () => print("view profile"),
            child: Text("View Profilw"),
          ),
        ],
      ),
    );
  }
}
