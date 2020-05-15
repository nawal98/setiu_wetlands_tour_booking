import 'package:flutter/foundation.dart';

class UserInfo {
  UserInfo(
      {@required this.userId,
        @required this.userName,
        @required this.email,
        @required this.userGender,
        @required this.userPhone,
     });

  final String userId;
  final String userName;
  final String email;
  final String userGender;
  final int userPhone;


  factory UserInfo.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String userName = data['userName'];
    final String email = data['email'];
    final String userGender = data['userGender'];
    final int userPhone = data['userPhone'];

    return UserInfo(
      userId: documentId,
      userName: userName,
      email: email,
      userGender: userGender,
      userPhone: userPhone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'email': email,
      'userGender': userGender,
      'userPhone': userPhone,

    };
  }
}