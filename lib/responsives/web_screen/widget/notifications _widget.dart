import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../utils/utills.dart';

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({super.key});

  @override
  State<NotificationsWidget> createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  bool isShowUsers = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 35),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.white, offset: Offset(0.1, 0))],
          color: webBackgroundColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notifications",
              style: TextStyle(fontSize: 30),
            ),
            Divider(),
            Container(
              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Week",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // if (isShowUsers)
                  FutureBuilder(
                      future:
                          FirebaseFirestore.instance.collection('users').get(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Container(
                          height: 500,
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  print('object');
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                    snapshot.data!.docs[index]['photoUrl'],
                                  )),
                                  title: Text(
                                    snapshot.data!.docs[index]['username'],
                                  ),
                                  subtitle: Text(
                                    snapshot.data!.docs[index]['bio'],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
