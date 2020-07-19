import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/models/user_info.dart';

class AccountListTile extends StatelessWidget {
  const AccountListTile({Key key, @required this.userInfo, this.onTap})
      : super(key: key);
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
          ],
        ),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 18),
        Row(children: <Widget>[
          Icon(Icons.chevron_right, color: Colors.grey[50]),
          Icon(Icons.perm_contact_calendar, color: Colors.lightGreen),
          Icon(Icons.chevron_right, color: Colors.grey[50]),
          Text('Full Name: ', style: TextStyle(fontSize: 16.0)),
          Text(userInfo.firstName, style: TextStyle(fontSize: 16.0)),
          Text(' ', style: TextStyle(fontSize: 16.0)),
          Text(userInfo.lastName, style: TextStyle(fontSize: 16.0)),
        ]),
        SizedBox(height: 18),
        Row(children: <Widget>[
          Icon(Icons.chevron_right, color: Colors.grey[50]),
          Icon(Icons.phone_android, color: Colors.lightGreen),
          Icon(Icons.chevron_right, color: Colors.grey[50]),
          Text('Phone: 0' + (userInfo.userPhone).toString(),
              style: TextStyle(fontSize: 16.0)),
        ]),
        SizedBox(height: 18),
        Row(children: <Widget>[
          Icon(Icons.chevron_right, color: Colors.grey[50]),
          Icon(Icons.wc, color: Colors.lightGreen),
          Icon(Icons.chevron_right, color: Colors.grey[50]),
          Text('Gender: ' + userInfo.userGender,
              style: TextStyle(fontSize: 16.0)),
        ]),

        SizedBox(height: 18),
      ],
    );
  }
}
