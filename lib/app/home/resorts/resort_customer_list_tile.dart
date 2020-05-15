import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/models/resort.dart';
import 'package:setiuwetlandstourbooking/app/home/resorts/ResortDetail.dart';

class ResortCustomerListTile extends StatelessWidget {
  const ResortCustomerListTile({Key key, @required this.resort, this.onTap})
      : super(key: key);
  final Resort resort;
  final VoidCallback onTap;

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResortDetail(),
            // Pass the arguments as part of the RouteSettings. The
            // DetailScreen reads the arguments from these settings.
            settings: RouteSettings(
              arguments: resort,
            ),
          ),
        );
      },
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
            Expanded(
              child: Text(resort.resortDescription,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(fontSize: 16.0, color: Colors.grey)),
            ),
          ]),
        ],
      ),
    );
  }
}
