import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/tab_item.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_activities/tour_activity_admin_page.dart';

// what tab you want to present in app
//how to show navigation on screen
class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold(
      {Key key, @required this.currentTab, @required this.onSelectTab, @required this.widgetBuilders, @required this.navigatorKeys})
      : super(key: key);
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _buildItem(TabItem.tourPackages),
          _buildItem(TabItem.resorts),
          _buildItem(TabItem.account),
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
          navigatorKey: navigatorKeys[item],
          builder: (context) => widgetBuilders[item](context),

        );
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final color = currentTab == tabItem ? Colors.lightGreen : Colors.grey;
    return BottomNavigationBarItem(
      icon: Icon(itemData.icon, color: color),
      title: Text(
        itemData.title,
        style: TextStyle(color: color),
      ),
    );
  }
}
