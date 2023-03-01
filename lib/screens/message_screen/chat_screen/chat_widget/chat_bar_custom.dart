import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_instagram/models/models.dart';

class ChatBarCustom extends StatelessWidget {
  const ChatBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Row(
            children: [
              CircleAvatar(
                radius: 15,
                foregroundImage: NetworkImage(PhotoUrl().photoUrl[0]),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "username",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Bio",
                    style: TextStyle(color: Colors.white60),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            GestureDetector(
              child: Image.asset(
                'assets/icons/chat/telephone.png',
                scale: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 40,
            ),
            GestureDetector(
                child: Image.asset(
              'assets/icons/chat/video_recorder.png',
              scale: 25,
              color: Colors.white,
            ))
          ],
        )
      ],
    );
  }
}
