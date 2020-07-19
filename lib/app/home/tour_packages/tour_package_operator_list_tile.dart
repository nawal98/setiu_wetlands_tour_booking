import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/PackageDetail.dart';
class TourPackageOperatorListTile extends StatelessWidget {
  const TourPackageOperatorListTile({Key key, @required this.tourPackage, this.onTap}):super(key:key);
  final TourPackage tourPackage;
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
              Text(tourPackage.tourName,
                  style: TextStyle(fontSize: 18.0, color: Colors.green[900])),
            ]),



        ],
    );

  }
}