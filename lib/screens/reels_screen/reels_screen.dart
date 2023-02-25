import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_instagram/models/models.dart';
import 'package:flutter_instagram/screens/reels_screen/widgets/reels_card.dart';

import '../../utils/utills.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 50),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: width > webScreenSize ? width * 0.25 : 0,
            ),
            padding: EdgeInsets.only(left: 20, right: 17),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0)
                ])),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reels",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.camera_alt_outlined))
                ],
              ),
            ),
          ),
        ),
        body: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: PhotoUrl().photoUrl.length,
            itemBuilder: (context, index) {
              return ReelsCard(
                width: width,
                index: index,
              );
            }));
  }
}
