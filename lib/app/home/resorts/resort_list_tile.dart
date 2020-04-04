import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/models/resort.dart';

class ResortListTile extends StatelessWidget {
  const ResortListTile({Key key, @required this.resort, this.onTap})
      : super(key: key);
  final Resort resort;
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
            Icon(Icons.chevron_right, color: Colors.black),
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
            Text(resort.resortName,
                style: TextStyle(fontSize: 18.0, color: Colors.black87)),
  ]),
        Row(children: <Widget>[
          Text(resort.resortType, style: TextStyle(fontSize: 16.0)),
        ]),
        Row(children: <Widget>[
          Text(
            resort.resortDescription,
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
        ],
        ),
            Row(children: <Widget>[
            Text(
              resort.resortAddress,
              style: TextStyle(fontSize: 16.0, color: Colors.black54),
            ),
          ],
        ),
        Row(children: <Widget>[
          Text(
            resort.resortTel,
            style: TextStyle(fontSize: 16.0, color: Colors.black54),
          ),
        ],
        ),

      ],
    );
  }
}
