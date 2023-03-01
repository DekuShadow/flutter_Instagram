import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_instagram/models/models.dart';

class MessageAppBar extends StatelessWidget {
  String username;
  VoidCallback function;
  MessageAppBar({super.key, required this.function, required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: function,
          child: Row(
            children: [
              Text(
                username,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
        Row(
          children: [
            GestureDetector(
              child: Image.asset(
                'assets/icons/chat/video_recorder.png',
                scale: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 30,
            ),
            GestureDetector(
              child: Image.asset(
                'assets/icons/add.png',
                scale: 20,
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
  }
}
