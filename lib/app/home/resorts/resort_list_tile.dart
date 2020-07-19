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
            _buildContents(context),
            Icon(Icons.chevron_right, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    return Flexible(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Text(resort.resortName,
              style: TextStyle(fontSize: 18.0, color: Colors.black87)),
        ]),
        Row(children: <Widget>[
           Text(resort.resortAddress+', ' + resort.postcode+ ', Setiu, Terengganu, Malaysia',
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(fontSize: 12.0, color: Colors.black54)),
   ]),
        Row(
          children: <Widget>[
            Text('+0'+ resort.resortTel.toString(),
              style: TextStyle(fontSize: 16.0, color: Colors.black54),
            ),
          ],
        ),
      ],
    ));
  }
}
