import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_instagram/resources/resources.dart';
import 'package:flutter_instagram/screens/screens.dart';
import 'package:flutter_instagram/utils/colors.dart';
import 'package:flutter_instagram/utils/utills.dart';
import 'package:flutter_instagram/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../responsives/responsives.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailControllor = TextEditingController();
  final TextEditingController _passwordControllor = TextEditingController();
  final TextEditingController _bioControllor = TextEditingController();
  final TextEditingController _usernameControllor = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailControllor.dispose();
    _passwordControllor.dispose();
    _bioControllor.dispose();
    _usernameControllor.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailControllor.text,
        password: _passwordControllor.text,
        username: _usernameControllor.text,
        bio: _bioControllor.text,
        file: _image!);
    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const responsiveLayout(
              WebScreenLayout: WebScreenLayout(),
              MobileScreenLayout: MobileScreenLayout()),
        ),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Flexible(
                  //   child: Container(),
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
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(
                                  "https://law.ucdavis.edu/sites/g/files/dgvnsk10866/files/styles/sf_profile/public/media/images/website-user-icon-01b.png?h=b4f6d533&itok=J9JTcFmm")),
                      Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            icon: Icon(Icons.add_a_photo),
                            onPressed: () {
                              selectImage();
                              print("add avatar");
                            },
                          ))
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  TextFieldInput(
                      textEditingController: _usernameControllor,
                      hintText: "Enter your username",
                      textInputType: TextInputType.text),
                  const SizedBox(height: 24.0),
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
                  TextFieldInput(
                      textEditingController: _bioControllor,
                      hintText: "Enter your bio",
                      textInputType: TextInputType.text),
                  const SizedBox(height: 24.0),
                  InkWell(
                    onTap: signUpUser,
                    child: Container(
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            )
                          : const Text("Sign up"),
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
                        child: Text("your have an account? "),
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                      ),
                      GestureDetector(
                        onTap: navigateToLogin,
                        child: Container(
                          child: Text("login.",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 20)),
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                        ),
                      )
                    ],
                  ),
                ]),
          ),
        ),
      )),
    );
  }
}
