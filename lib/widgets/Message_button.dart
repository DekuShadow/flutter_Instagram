import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../utils/global_variables.dart';

class MessageButton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final String text;
  final Color textColor;
  const MessageButton(
      {super.key,
      this.function,
      required this.backgroundColor,
      required this.text,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      width: width > webScreenSize ? width * 0.15 : width / 3.0,
      height: 30,
    );
  }
}
