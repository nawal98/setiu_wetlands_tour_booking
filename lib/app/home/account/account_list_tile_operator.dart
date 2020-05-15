import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/models/user_info.dart';

class AccountListTileOperator extends StatelessWidget {
  const AccountListTileOperator({Key key, @required this.userInfo, this.onTap}):super(key:key);
  final UserInfo userInfo;
  final VoidCallback onTap;



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: _buildContents(context),
            ),
//            Icon(Icons.chevron_right, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
            children: <Widget>[
              Text(userInfo.userName,
                  style: TextStyle(fontSize: 18.0, color: Colors.black87)),

            ]),
//        SizedBox(height: 8),
        Row(children: <Widget>[
          Text(userInfo.email, style: TextStyle(fontSize: 16.0)),
        ]),
        Row(children: <Widget>[
          Text('0'+
              (userInfo.userPhone).toString(),
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
        ],
        ),
        Row(children: <Widget>[
          Text(
            userInfo.userGender,
            style: TextStyle(fontSize: 16.0, color: Colors.black54),
          ),
        ],
        ),
//        Row(children: <Widget>[
//          Text(
//            tourPackage.tourDiscount +'% Discount',
//            style: TextStyle(fontSize: 16.0, color: Colors.green),
//          ),
//        ],


      ],
    );

  }
}