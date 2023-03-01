import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';
import '../../../providers/user_provider.dart';
import '../../../resources/firestore_methods.dart';
import '../../../utils/utils.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;
  bool isVideo = false;
  bool isReels = false;

  void postImage(
    String uid,
    String username,
    String profImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text, _file!, uid, username, profImage, false);

      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        showSnackBar("Posted!", context);
        clearImage();
      } else {
        setState(() {
          _isLoading = true;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void postVedio(
    String uid,
    String username,
    String profImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text, _file!, uid, username, profImage, true);

      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        showSnackBar("Posted!", context);
        clearImage();
      } else {
        setState(() {
          _isLoading = true;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void postReels(
    String uid,
    String username,
    String profImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadReels(
          _descriptionController.text, _file!, uid, username, profImage, true);

      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        showSnackBar("Posted!", context);
        clearImage();
      } else {
        setState(() {
          _isLoading = true;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a Post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Takt a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);

                  setState(() {
                    isVideo = false;
                    isReels = false;
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Choose from gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    isVideo = false;
                    isReels = false;
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Video from gallery"),
                onPressed: () async {
                  Uint8List file = await pickVideo(ImageSource.gallery);
                  setState(() {
                    _file = file;
                    isVideo = true;
                    isReels = false;
                  });
                  Navigator.of(context).pop();
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Reels from gallery"),
                onPressed: () async {
                  Uint8List file = await pickVideo(ImageSource.gallery);
                  setState(() {
                    _file = file;
                    isVideo = false;
                    isReels = true;
                  });
                  Navigator.of(context).pop();
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Cancel"),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final User user = Provider.of<UserProvider>(context).getUser;
    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.black45,
            border:
                Border(bottom: BorderSide(width: 0.1, color: Colors.white30))),
        height: 40,
        child: Row(
          mainAxisAlignment: _file != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            if (_file != null)
              GestureDetector(
                onTap: () => clearImage,
                child: Icon(Icons.arrow_back),
              ),
            Text("New Post"),
            if (_file != null)
              GestureDetector(
                onTap: () {
                  isReels
                      ? postReels(user.uid, user.username, user.photoUrl)
                      : isVideo
                          ? postVedio(user.uid, user.username, user.photoUrl)
                          : postImage(user.uid, user.username, user.photoUrl);
                  Navigator.pop(context);
                },
                child: Text("Post"),
              ),
          ],
        ),
      ),
      content: _file == null
          ? Container(
              decoration: BoxDecoration(color: Colors.black45),
              height: height < 1000 ? 400 : 800,
              width: width < 1500 ? 350 : 750,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo_outlined,
                    size: 100,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text("Select photos and videos here."),
                  SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      _selectImage(context);
                    },
                    child: Container(
                      width: width * 0.18,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Center(
                        child: Text("Choose an image from your computer."),
                      ),
                    ),
                  )
                ],
              )),
            )
          : Column(
              children: [
                _isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(padding: EdgeInsets.only(top: 0)),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black45,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 600,
                        width: 600,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: MemoryImage(_file!),
                                fit: BoxFit.cover,
                                alignment: FractionalOffset.topCenter)),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: 300,
                        // height: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(user.photoUrl),
                              ),
                              title: Text(user.username),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _descriptionController,
                              decoration:
                                  InputDecoration.collapsed(hintText: 'Search'),
                              maxLines: 10,
                              maxLength: 2200,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
