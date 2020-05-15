import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_activity.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_activities/ActivityDetail.dart';
class TourActivityCustomerListTile extends StatelessWidget {
  const TourActivityCustomerListTile({Key key, @required this.tourActivity, this.onTap}):super(key:key);
  final TourActivity tourActivity;
  final VoidCallback onTap;


  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActivityDetail(),
            // Pass the arguments as part of the RouteSettings. The
            // DetailScreen reads the arguments from these settings.
            settings: RouteSettings(
              arguments: tourActivity,),),);
      },
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
              Text(tourActivity.activityName,
                  style: TextStyle(fontSize: 18.0, color: Colors.black87)),
            ]),
        Row(children: <Widget>[
          Text(tourActivity.activityDescription, style: TextStyle(fontSize: 16.0, color: Colors.grey)),
        ]),


      ],
    );
  }
}
