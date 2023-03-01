import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_instagram/models/photo_url.dart';

class MessageStory extends StatefulWidget {
  const MessageStory({super.key});

  @override
  State<MessageStory> createState() => _MessageStoryState();
}

class _MessageStoryState extends State<MessageStory> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            CircleStory(photoUrl: PhotoUrl().photoUrl[1], name: 'Admim user'),
            Positioned(
                top: 0,
                right: 0,
                child: Container(
                    child: Image.asset(
                  'assets/icons/add-circle.png',
                  color: Colors.white,
                  scale: 15,
                ))),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 2),
          height: 110,
          width: MediaQuery.of(context).size.width - 100,
          child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CircleStory(
                    photoUrl: PhotoUrl().photoUrl[0], name: "username");
              }),
        ),
      ],
    );
  }
}

class CircleStory extends StatelessWidget {
  final photoUrl;
  final name;
  CircleStory({super.key, required this.photoUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.amberAccent,
            backgroundImage: NetworkImage(PhotoUrl().photoUrl[1]),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 10, color: Colors.white60),
          ),
        ],
      ),
    );
  }
}
