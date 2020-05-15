import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem {tourPackages,tourActivities, resorts, account}
//tourPackages
class TabItemData {
  const TabItemData({@required this.icon,@required this.title});
  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs ={
    TabItem.tourPackages:TabItemData(title:'Tour Packages', icon:Icons.work),
    TabItem.resorts:TabItemData(title:'Resorts', icon:Icons.hotel),
      TabItem.tourActivities:TabItemData(title:'Tour Activities', icon:Icons.format_list_bulleted),
//    TabItem.account:TabItemData(title:'Staff', icon:Icons.group_add),
    TabItem.account:TabItemData(title:'Account', icon:Icons.person),
//    TabItem.tourPackages:TabItemData(title:'Customers', icon:Icons.people),
//    TabItem.resorts:TabItemData(title:'Bookings', icon:Icons.book),
//    TabItem.tourActivities:TabItemData(title:'Payment', icon:Icons.monetization_on),
//    TabItem.tourActivities:TabItemData(title:'Feedback', icon:Icons.feedback),
//    TabItem.tourPackages:TabItemData(title:'Tour Packages', icon:Icons.work),
//    TabItem.resorts:TabItemData(title:'Resorts', icon:Icons.hotel),
//    TabItem.tourPackages:TabItemData(title:'Tour Activities', icon:Icons.list),


  };
}