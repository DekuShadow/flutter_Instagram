import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram/models/models.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String postUrl;
  final String postVideo;
  final String profImage;
  final likes;
  const Post({
    required this.postVideo,
    required this.description,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.likes,
    required this.uid,
    required this.username,
  });

  Map<String, dynamic> toJosn() => {
        "description": description,
        "uid": uid,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        "profImage": profImage,
        "likes": likes,
        "postUrl": postUrl,
        "postVideo": postVideo,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
        description: snapshot['description'],
        uid: snapshot['uid'],
        username: snapshot['username'],
        postId: snapshot['postId'],
        datePublished: snapshot['datePublished'],
        profImage: snapshot['profImage'],
        likes: snapshot['likes'],
        postUrl: snapshot['postUrl'],
        postVideo: snapshot['postVideo']);
  }
}

class PostReels {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String postReels;
  final String profImage;
  final likes;
  const PostReels({
    required this.postReels,
    required this.description,
    required this.postId,
    required this.datePublished,
    required this.profImage,
    required this.likes,
    required this.uid,
    required this.username,
  });
  Map<String, dynamic> toJosn() => {
        "description": description,
        "uid": uid,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        "profImage": profImage,
        "likes": likes,
        "postReels": postReels,
      };
  static PostReels fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return PostReels(
        description: snapshot['description'],
        uid: snapshot['uid'],
        username: snapshot['username'],
        postId: snapshot['postId'],
        datePublished: snapshot['datePublished'],
        profImage: snapshot['profImage'],
        likes: snapshot['likes'],
        postReels: snapshot['postReels']);
  }
}
