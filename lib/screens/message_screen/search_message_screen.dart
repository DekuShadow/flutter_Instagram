import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_instagram/screens/message_screen/widget_screen_widget/list_message.dart';

class SearchMessageScreen extends StatelessWidget {
  const SearchMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: double.infinity,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0.0,
                  childAspectRatio: 5.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ListMessage(
                      to_avatar: '',
                      to_name: 'username',
                      form_uid: '',
                    );
                  },
                  childCount: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
