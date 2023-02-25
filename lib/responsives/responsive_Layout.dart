import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram/models/user.dart';
import 'package:flutter_instagram/providers/providers.dart';
import 'package:flutter_instagram/resources/bloc/auth_current_uid_bloc.dart';
import 'package:provider/provider.dart';
import '../utils/utills.dart';

class responsiveLayout extends StatefulWidget {
  final Widget WebScreenLayout;
  final Widget MobileScreenLayout;
  const responsiveLayout(
      {super.key,
      required this.WebScreenLayout,
      required this.MobileScreenLayout});

  @override
  State<responsiveLayout> createState() => _responsiveLayoutState();
}

class _responsiveLayoutState extends State<responsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        return widget.WebScreenLayout;
      }
      return widget.MobileScreenLayout;
    });
  }
}
