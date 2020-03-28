import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';

class TourPackageListTile extends StatelessWidget {
  const TourPackageListTile({Key key, @required this.tourPackage, this.onTap}):super(key:key);
  final TourPackage tourPackage;
  final VoidCallback onTap;



  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(tourPackage.tourName),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
