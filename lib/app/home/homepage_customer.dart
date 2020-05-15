import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/account/account_page.dart';
import 'package:setiuwetlandstourbooking/app/home/account/account_page_operator.dart';
import 'package:setiuwetlandstourbooking/app/home/cupertino_home_scaffold.dart';
import 'package:setiuwetlandstourbooking/app/home/resorts/resort_customer_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tab_item.dart';
import 'package:setiuwetlandstourbooking/app/home/resorts/resort_admin_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_activities/tour_activity_admin_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_activities/tour_activity_customer_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/tour_Package_customer_list_tile.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/tour_package_admin_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/tour_package_customer_page.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/app/home/navigationDrawer.dart';
import 'package:setiuwetlandstourbooking/app/home/pageRoute.dart';
class HomepageCustomer extends StatefulWidget {
  @override
  _HomepageCustomerState createState() => _HomepageCustomerState();
}

class _HomepageCustomerState extends State<HomepageCustomer> {
//customers, bookings, payment, feedback
  TabItem _currentTab = TabItem.tourPackages;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.tourPackages: GlobalKey<NavigatorState>(),
    TabItem.resorts: GlobalKey<NavigatorState>(),
//    TabItem.bookings: GlobalKey<NavigatorState>(),
    TabItem.tourActivities: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.tourPackages: (_) => TourPackageCustomer(),
      TabItem.resorts: (_) => ResortCustomer(),
      TabItem.tourActivities: (_) => TourActivityCustomer(),
      TabItem.account: (_) => AccountPage(),
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

//    return new MaterialApp(
//      title: 'NavigationDrawer Demo',
//      theme: new ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: title: 'Home Page'),
//      routes:  {
//        PageRoutes.profile: (context) => AccountPage(),
//        PageRoutes.tourPackages: (context) => TourPackageCustomer(),
//        PageRoutes.tourActivities: (context) => TourActivityAdmin(),
//        PageRoutes.resorts: (context) => ResortAdmin(),
//        routes: {
//          // When navigating to the "/" route, build the FirstScreen widget.
//          '/account': (context) => AccountPage(),
//          '/tourPackage': (context) => TourPackageCustomer(),
//          '/tourActivity': (context) => TourActivityAdmin(),
//          '/resort': (context) => ResortAdmin(),
//      },
//        );

//  }
//}
