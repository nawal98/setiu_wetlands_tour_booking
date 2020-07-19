import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/account/accountDetail.dart';
import 'package:setiuwetlandstourbooking/app/models/user_info.dart';

class AccountListTileOperator extends StatelessWidget {
  const AccountListTileOperator({Key key, @required this.userInfo, this.onTap})
      : super(key: key);
  final UserInfo userInfo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  AccountDetail(),
            // Pass the arguments as part of the RouteSettings. The
            // DetailScreen reads the arguments from these settings.
            settings: RouteSettings(
              arguments: userInfo,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: _buildContents(context),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Text(userInfo.firstName +','+userInfo.lastName,
              style: TextStyle(fontSize: 18.0, color: Colors.black87)),
        ]),
//        SizedBox(height: 8),
        Row(
          children: <Widget>[
            Text(
              '0' + (userInfo.userPhone).toString(),
              style: TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              userInfo.userGender,
              style: TextStyle(fontSize: 16.0, color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }
}
