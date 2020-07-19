import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/account/account_page.dart';
import 'package:setiuwetlandstourbooking/app/home/account/account_page_operator.dart';
import 'package:setiuwetlandstourbooking/app/home/cupertino_home_admin_scaffold.dart';
import 'package:setiuwetlandstourbooking/app/home/tab_item.dart';
import 'package:setiuwetlandstourbooking/app/home/resorts/resort_admin_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_activities/tour_activity_admin_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/booking_customer_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/tour_package_admin_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/tour_package_customer_page.dart';

class HomepageAdmin extends StatefulWidget {
  @override
  _HomepageAdminState createState() => _HomepageAdminState();
}
//tour packages,activities,resorts
class _HomepageAdminState extends State<HomepageAdmin> {
  TabItem _currentTab = TabItem.tourPackages;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.tourPackages: GlobalKey<NavigatorState>(),
    TabItem.resorts: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.tourPackages: (_) => TourPackageAdmin(),
      TabItem.resorts: (_) => ResortAdmin(),
    };
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}