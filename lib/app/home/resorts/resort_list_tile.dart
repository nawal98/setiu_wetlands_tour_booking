import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/models/resort.dart';

class ResortListTile extends StatelessWidget {
  const ResortListTile({Key key, @required this.resort, this.onTap}):super(key:key);
  final Resort resort;
  final VoidCallback onTap;



  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(resort.resortName),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}