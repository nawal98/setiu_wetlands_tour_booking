import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_activities/activity_tab_item.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_activities/tour_activity_admin_page.dart';

// what tab you want to present in app
//how to show navigation on screen
class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold(
      {Key key, @required this.currentTab, @required this.onSelectTab, @required this.widgetBuilders, @required this.navigatorKeys, Drawer drawer})
      : super(key: key);
  final ActivityTabItem currentTab;
  final ValueChanged<ActivityTabItem> onSelectTab;
  final Map<ActivityTabItem, WidgetBuilder> widgetBuilders;
  final Map<ActivityTabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {

    return  TabBarView(
        children:<Widget>[
          _buildItem(ActivityTabItem.uploadImage),
          _buildItem(ActivityTabItem.viewImage),


        ],
//        onTap: (index) => onSelectTab(ActivityTabItem.values[index]),
      );
//      tabBuilder: (context, index) {
//        final item = ActivityTabItem.values[index];
//        return CupertinoTabView(
//          navigatorKey: navigatorKeys[item],
//          builder: (context) => widgetBuilders[item](context),
//
//        );
//      },
//    );
  }

  Tab _buildItem(ActivityTabItem activityTabItem) {
    final itemData = TabItemData.allTabs[activityTabItem];
    final color = currentTab == activityTabItem ? Colors.lightGreen : Colors.grey;
    return Tab(
      icon: Icon(itemData.icon, color: color),
      text:
        itemData.title,


    );
  }
}