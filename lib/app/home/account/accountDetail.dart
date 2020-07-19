import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_activity.dart';
import 'package:setiuwetlandstourbooking/app/models/user_info.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AccountDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserInfo userInfo = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('Customer Information'),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    children: <Widget>[
                      Row(children: <Widget>[
                        SizedBox(
                          width: 120,
                          child: Text(
                            'First Name',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15.0,  fontWeight: FontWeight.bold,color: Colors.black87),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(userInfo.firstName,
                              style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                        ),
                      ]),SizedBox(height: 10,),
                      Row(children: <Widget>[
                        SizedBox(
                          width: 120,
                          child: Text(
                            'Last Name',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15.0,  fontWeight: FontWeight.bold,color: Colors.black87),
                          ),
                        ),SizedBox(height: 10,),
                        SizedBox(
                          width: 150,
                          child: Text(userInfo.lastName,
                              style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                        ),
                      ]),SizedBox(height: 10,),
                      Row(children: <Widget>[
                        SizedBox(
                          width: 120,
                          child: Text(
                            'Gender',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15.0,  fontWeight: FontWeight.bold,color: Colors.black87),
                          ),
                        ),SizedBox(height: 10,),
                        SizedBox(
                          width: 150,
                          child: Text(userInfo.userGender,
                              style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                        ),
                      ]),SizedBox(height: 10,),
                      Row(children: <Widget>[
                        SizedBox(
                          width: 120,
                          child: Text(
                            'Phone Number',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15.0,  fontWeight: FontWeight.bold,color: Colors.black87),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Text('0'+userInfo.userPhone.toString(),
                              style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                        ),
                      ]),
                    ] ))
    ));
  }


}
