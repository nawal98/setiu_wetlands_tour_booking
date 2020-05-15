import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/PackageDetail.dart';
import 'package:setiuwetlandstourbooking/app/home/pageRoute.dart';
class TourPackageCustomerListTile extends StatelessWidget {
  const TourPackageCustomerListTile({Key key, @required this.tourPackage, this.onTap}):super(key:key);
  final TourPackage tourPackage;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PackageDetail(),
            // Pass the arguments as part of the RouteSettings. The
            // DetailScreen reads the arguments from these settings.
            settings: RouteSettings(
              arguments: tourPackage,),),);
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
              Text(tourPackage.tourName,
                  style: TextStyle(fontSize: 18.0, color: Colors.black87)),
            ]),

        Row(children: <Widget>[
          Text('RM '+
              (tourPackage.tourAdultAmount).toString() + 'per Adult',
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
        ],
        ),
        Row(children: <Widget>[
          Text(
            (tourPackage.durationPerHour).toString()+'hours',
            style: TextStyle(fontSize: 16.0, color: Colors.black54),
          ),
        ],
        ),
        Row(children: <Widget>[
          Text(
            (tourPackage.tourDiscount).toString() +'% Discount',
            style: TextStyle(fontSize: 16.0, color: Colors.green),
          ),
        ],


        ),],
    );

  }
}