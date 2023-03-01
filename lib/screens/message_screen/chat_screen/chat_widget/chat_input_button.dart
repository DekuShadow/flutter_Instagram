import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_instagram/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class ChatInputButton extends StatefulWidget {
  const ChatInputButton({super.key});

  @override
  State<ChatInputButton> createState() => _ChatInputButtonState();
}

class _ChatInputButtonState extends State<ChatInputButton>
    with SingleTickerProviderStateMixin {
  TextEditingController _textconTroller = TextEditingController();
  bool isTextInput = false;
  late AnimationController _animationController;
  late Animation<double> scale;
  int isforvaer = 1;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    scale = Tween<double>(begin: 1, end: 1.2).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textconTroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
          color: Colors.black,
          border:
              Border.all(width: 0.8, color: Color.fromARGB(255, 105, 105, 105)),
          borderRadius: BorderRadius.circular(50)),
      child: TextFormField(
        controller: _textconTroller,
        onChanged: (value) async {
          print(value.length);
          if (value.length == isforvaer) {
            isforvaer == 1 ? isforvaer = 0 : isforvaer = 1;
            await _animationController.forward();
            await _animationController.reverse();
            if (_textconTroller.text != '') {
              setState(() {
                isTextInput = true;
              });
            } else {
              setState(() {
                isTextInput = false;
              });
            }
          }
        },
        cursorColor: Colors.white,
        // maxLength: 20,
        decoration: InputDecoration(
          iconColor: Colors.white,
          suffixIconColor: Colors.white,
          labelStyle: TextStyle(color: Colors.white),
          hintText: 'Message...',
          border: InputBorder.none,
          icon: ScaleTransition(
            scale: scale,
            child: AnimatedContainer(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 42, 212, 255),
                  borderRadius: BorderRadius.circular(30)),
              duration: Duration(milliseconds: 200),
              child: isTextInput
                  ? GestureDetector(
                      child: Icon(Icons.emoji_emotions_rounded),
                      onTap: () => print("Emoji"),
                    )
                  : GestureDetector(
                      child: Icon(Icons.camera_alt_rounded),
                      onTap: () async {
                        await pickImage(ImageSource.camera);
                        print("camera");
                      },
                    ),
            ),
          ),
          suffixIcon: isTextInput
              ? GestureDetector(
                  onTap: () => print('Sead'),
                  child: Container(
                      height: 1,
                      width: 60,
                      alignment: Alignment.center,
                      child: Text(
                        "Send",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 133, 64, 251)),
                      )),
                )
              : GestureDetector(
                  onTap: () async {
                    await pickImage(ImageSource.gallery);
                  },
                  child: Icon(
                    Icons.image,
                    size: 30,
                  ),
                ),
        ),
      ),
    );
  }
}

class subicons extends StatelessWidget {
  const subicons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.check_circle,
        ),
        Icon(
          Icons.check_circle,
        ),
        Icon(
          Icons.check_circle,
        ),
      ],
    );
  }
}
