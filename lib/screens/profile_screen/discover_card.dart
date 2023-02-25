import 'package:flutter/material.dart';
import '../../widgets/follow_button.dart';

class DiscoverCard extends StatelessWidget {
  final uid;

  const DiscoverCard({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              height: 190,
              width: 160,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: FollowButton(
                backgroundColor: Colors.blue,
                text: "Follow",
                textColor: Colors.white,
                function: () {},
              ))),
    );
  }
}
