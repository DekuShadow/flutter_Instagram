import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../../../models/photo_url.dart';

class ListMessage extends StatelessWidget {
  String form_uid;
  String to_avatar;
  String to_name;
  ListMessage(
      {super.key,
      required this.to_avatar,
      required this.to_name,
      required this.form_uid});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(color: Colors.red),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  foregroundImage: NetworkImage(to_avatar),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(to_name), Text("2H ago")],
                ),
              ],
            ),
          ),
          Icon(Icons.camera_alt_outlined)
        ],
      ),
    );
  }
}
