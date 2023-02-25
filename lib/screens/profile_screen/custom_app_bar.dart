import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/app_bar_bloc.dart';

class CustomAppBar extends StatelessWidget {
  int currentIndex;
  CustomAppBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            color: currentIndex == 0 ? Colors.white : Colors.white38,
            icon: Icon(
              Icons.auto_awesome_mosaic_rounded,
              size: 30,
            ),
            onPressed: () {
              BlocProvider.of<AppBarBloc>(context).add(IndexcurrentEvent(0));
            },
          ),
          IconButton(
            color: currentIndex == 1 ? Colors.white : Colors.white38,
            icon: Icon(
              Icons.assignment_ind_outlined,
              size: 30,
            ),
            onPressed: () {
              BlocProvider.of<AppBarBloc>(context).add(IndexcurrentEvent(1));
            },
          ),
        ],
      ),
    );
  }
}
