import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ActivityTabItem {uploadImage,viewImage}
//tourPackages
class TabItemData {
  const TabItemData({@required this.icon,@required this.title});
  final String title;
  final IconData icon;

  static const Map<ActivityTabItem, TabItemData> allTabs ={
    ActivityTabItem.uploadImage:TabItemData(title:'Tour Packages', icon:Icons.work),
    ActivityTabItem.viewImage:TabItemData(title:'Resorts', icon:Icons.hotel),


  };
}