import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? uid;
  String? username;
  DateTime? timestamp;

  UserModel({
    this.email,
    this.uid,
    this.username,
    this.timestamp,
  });

  Map<String, dynamic> toMap(UserModel user) {
    var data = <String, dynamic>{
      "uid": user.uid,
      "username": user.username,
      "email": user.email,
      "timestamp": user.timestamp,
    };

    return data;
  }

  UserModel.fromMap(Map<String, dynamic> mapData) {
    uid = mapData["uid"];
    username = mapData["username"];
    email = mapData["email"];
    timestamp = (mapData["timestamp"] as Timestamp?)?.toDate();
  }
}
