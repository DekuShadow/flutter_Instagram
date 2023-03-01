import 'package:cloud_firestore/cloud_firestore.dart';

class chats {
  final String form_avatar;
  final String form_name;
  final String form_uid;
  final String last_msg;
  final last_time;
  final String to_avatar;
  final String to_name;
  final String to_uid;
  final String chatId;

  const chats(
      {required this.form_avatar,
      required this.form_name,
      required this.form_uid,
      required this.last_msg,
      required this.last_time,
      required this.to_avatar,
      required this.to_name,
      required this.to_uid,
      required this.chatId});

  Map<String, dynamic> toJosn() => {
        "form_avatar": form_avatar,
        "form_name": form_name,
        "form_uid": form_uid,
        "last_msg": last_msg,
        "last_time": last_time,
        "to_avatar": to_avatar,
        "to_name": to_name,
        "to_uid": to_uid,
        "chatId": chatId,
      };
  static chats fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return chats(
      form_avatar: snapshot['form_avatar'],
      form_name: snapshot['form_name'],
      form_uid: snapshot['form_uid'],
      last_msg: snapshot['last_msg'],
      last_time: snapshot['last_time'],
      to_avatar: snapshot['to_avatar'],
      to_name: snapshot['to_name'],
      to_uid: snapshot['to_uid'],
      chatId: snapshot['chatId'],
    );
  }
}

class Message {
  final addtime;
  final String content;
  final String type;
  final String uid;

  const Message({
    required this.addtime,
    required this.content,
    required this.type,
    required this.uid,
  });

  Map<String, dynamic> toJosn() => {
        "form_avatar": addtime,
        "form_name": content,
        "form_uid": type,
        "last_msg": uid,
      };
  static Message fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Message(
      addtime: snapshot['addtime'],
      content: snapshot['content'],
      type: snapshot['type'],
      uid: snapshot['uid'],
    );
  }
}
