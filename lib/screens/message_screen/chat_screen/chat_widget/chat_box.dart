import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChatBox extends StatelessWidget {
  String content;
  bool isIndex;
  ChatBox({super.key, required this.isIndex, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: double.infinity,
      width: MediaQuery.of(context).size.width,
      alignment: isIndex ? Alignment.bottomRight : Alignment.bottomLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ColumnBox(
            content: content,
          ),
        ],
      ),
    );
  }
}

class ColumnBox extends StatelessWidget {
  String content;
  ColumnBox({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white24, borderRadius: BorderRadius.circular(10)),
        child: Text(content));
  }
}
