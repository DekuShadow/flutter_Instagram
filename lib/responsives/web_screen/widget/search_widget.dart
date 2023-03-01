import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../utils/utills.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            "Search",
            style: TextStyle(fontSize: 30),
          ),
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 48, 48, 48),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration.collapsed(hintText: 'Search'),
              onSubmitted: (value) => setState(() {
                isShowUsers = true;
              }),
            ),
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
                      "Latest",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextButton(onPressed: () {}, child: Text("DelectAll"))
                  ],
                ),
                if (isShowUsers)
                  FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .where('username', isEqualTo: searchController.text)
                          .get(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Container(
                          // color: Colors.white,
                          height: 700,
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  print('object');
                                  print(searchController.text);
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
    );
  }
}
