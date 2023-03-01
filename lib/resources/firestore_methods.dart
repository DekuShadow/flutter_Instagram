import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram/resources/resources.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// upload post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage, bool isVideo) async {
    String res = "some error occurred";
    String videoUrl = '';
    String photoUrl = '';
    if (isVideo) {
      print("isVideo" + isVideo.toString());
      videoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
    } else {
      photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
    }
    try {
      String postId = const Uuid().v1();

      print("VideoUrllllllllllllllllllllllllll          " + videoUrl);
      Post post = Post(
          description: description,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          postVideo: videoUrl,
          profImage: profImage,
          likes: [],
          uid: uid,
          username: username);

      _firestore.collection('posts').doc(postId).set(post.toJosn());

      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> uploadReels(String description, Uint8List file, String uid,
      String username, String profImage, bool isVideo) async {
    String res = "some error occurred";
    String videoReels = '';

    videoReels =
        await StorageMethods().uploadImageToStorage('Reels', file, true);

    try {
      String postId = const Uuid().v1();

      PostReels post = PostReels(
          description: description,
          postId: postId,
          datePublished: DateTime.now(),
          postReels: videoReels,
          profImage: profImage,
          likes: [],
          uid: uid,
          username: username);

      _firestore.collection('Reels').doc(postId).set(post.toJosn());

      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  Future<void> postComment(String postId, String text, String uid, String name,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
      } else {
        print("Text is empty");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> NewMessage({
    required String form_avatar,
    required String form_name,
    required String form_uid,
    required String last_msg,
    required String last_time,
    required String to_avatar,
    required String to_name,
    required String to_uid,
    // required String chatId,
  }) async {
    try {
      if (last_msg.isNotEmpty) {
        // String messageId = const Uuid().v1();
        String chatId = const Uuid().v1();
        await _firestore
            .collection('message')
            .doc(chatId)
            // .collection('msglist')
            // .doc(messageId)
            .set({
          'form_avatar': form_avatar,
          'form_name': form_name,
          'form_uid': form_uid,
          'last_msg': last_msg,
          'last_time': DateTime.now(),
          'to_avatar': to_avatar,
          'to_name': to_name,
          'to_uid': to_uid,
          'chatId': chatId,
        });
      } else {
        print("Text is empty");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> sendMessage({
    required String addtime,
    required String content,
    required String type,
    required String uid,
    required String chatId,
  }) async {
    try {
      if (content.isNotEmpty) {
        String messageId = const Uuid().v1();
        await _firestore
            .collection('message')
            .doc(chatId)
            .collection('msglist')
            .doc(messageId)
            .set({
          'addtime': addtime,
          'content': content,
          'type': type,
          'uid': uid,
        });
      } else {
        print("Text is empty");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      _firestore.collection('posts').doc(postId).delete();
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        print(uid);
        print(followId);
        print(following.contains(followId));
        await _firestore.collection('users').doc(followId).update({
          'follower': FieldValue.arrayRemove([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'follower': FieldValue.arrayUnion([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {}
  }
}
