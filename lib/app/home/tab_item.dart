import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem {tourPackages, resorts, account}

class TabItemData {
  const TabItemData({@required this.icon,@required this.title});
  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs ={
    TabItem.tourPackages:TabItemData(title:'Tour Packages', icon:Icons.work),
    TabItem.resorts:TabItemData(title:'Resorts', icon:Icons.view_headline),
    TabItem.account:TabItemData(title:'Account', icon:Icons.person),
  };
}