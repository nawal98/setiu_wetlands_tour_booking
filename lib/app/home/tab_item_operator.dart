import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { bookings, account, feedbacks}
//tourPackages
class TabItemData {
  const TabItemData({@required this.icon,@required this.title});
  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs ={


    TabItem.account:TabItemData(title:'Account', icon:Icons.person),

    TabItem.bookings:TabItemData(title:'Bookings', icon:Icons.book),
    TabItem.feedbacks:TabItemData(title:'Feedback', icon:Icons.feedback),



  };
}