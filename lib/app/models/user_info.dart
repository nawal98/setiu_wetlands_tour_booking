import 'package:flutter/foundation.dart';

class UserInfo {
  UserInfo(
      {@required this.userId,
        @required this.firstName,
        @required this.lastName,
//        @required this.email,
        @required this.userGender,
        @required this.userPhone,
     });

  final String userId;
  final String firstName;
  final String lastName;
//  final String email;
  final String userGender;
  final int userPhone;


  factory UserInfo.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String firstName = data['firstName'];
    final String lastName = data['lastName'];
//    final String email = data['email'];
    final String userGender = data['userGender'];
    final int userPhone = data['userPhone'];

    return UserInfo(
      userId: documentId,
      firstName: firstName,
      lastName: lastName,
//      email: email,
      userGender: userGender,
      userPhone: userPhone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
//      'email': email,
      'userGender': userGender,
      'userPhone': userPhone,

    };
  }
}