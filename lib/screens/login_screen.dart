import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/resources/resources.dart';
import 'package:flutter_instagram/screens/screens.dart';
import 'package:flutter_instagram/utils/colors.dart';
import 'package:flutter_instagram/utils/utills.dart';
import 'package:flutter_instagram/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../responsives/responsives.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailControllor = TextEditingController();
  final TextEditingController _passwordControllor = TextEditingController();

  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailControllor.dispose();
    _passwordControllor.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
      print(_isLoading);
    });
    String res = await AuthMethods().loginUser(
        email: _emailControllor.text, password: _passwordControllor.text);

    if (res == "success") {
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const responsiveLayout(
              WebScreenLayout: WebScreenLayout(),
              MobileScreenLayout: MobileScreenLayout()),
        ),
      );
    }
    setState(() {
      _isLoading = false;
      print(_isLoading);
    });
  }

  void navigateToSignup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: MediaQuery.of(context).size.width > webScreenSize
            ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 3.2)
            : const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Flexible(
              //   child: Container(
              //       // child: Text("test"),
              //       ),
              //   flex: 2,
              // ),
              SvgPicture.asset(
                "assets/ic_instagram.svg",
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64.0,
              ),
              TextFieldInput(
                  textEditingController: _emailControllor,
                  hintText: "Enter your Email",
                  textInputType: TextInputType.emailAddress),
              const SizedBox(height: 24.0),
              TextFieldInput(
                textEditingController: _passwordControllor,
                hintText: "Enter your password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(height: 24.0),
              InkWell(
                onTap: loginUser,
                child: Container(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Text("Log in"),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  decoration: const ShapeDecoration(
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(4.0)))),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              // Flexible(
              //   child: Container(),
              //   flex: 2,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Don't have an account? "),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                  ),
                  GestureDetector(
                    onTap: navigateToSignup,
                    child: Container(
                      child: Text(
                        "sing up.",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 18),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                    ),
                  )
                ],
              ),
            ]),
      )),
    );
  }
}
