import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/account/account_page_operator.dart';
import 'package:setiuwetlandstourbooking/app/home/cupertiono_home_operator_scaffold.dart';
import 'package:setiuwetlandstourbooking/app/home/feedback/feedback_operator_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tab_item_operator.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/booking_operator_page.dart';
class HomepageOperator extends StatefulWidget {
  @override
  _HomepageOperatorState createState() => _HomepageOperatorState();
}

class _HomepageOperatorState extends State<HomepageOperator> {

  TabItem _currentTab = TabItem.bookings;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.bookings: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
    TabItem.feedbacks: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {



      TabItem.bookings: (_) => BookingOperator(),
      TabItem.account: (_) => AccountPageOperator(),
      TabItem.feedbacks: (_) => FeedbackOperator(),
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
