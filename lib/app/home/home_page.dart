import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/landing_page.dart';
import 'package:setiuwetlandstourbooking/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/tour_package_admin_page.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_alert_dialog.dart';
import 'dart:async';
import 'package:setiuwetlandstourbooking/services/database.dart';

class HomePage extends StatelessWidget {
  List<String> events = ["Tour Package", "Tour Activity", "Resort", "Staff"];

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
//    final auth = Provider.of<AuthBase>(context);
//    return StreamBuilder<Customer>(
//      stream: auth.onAuthStateChanged,
//      builder: (context, snapshot) {
//        if (snapshot.connectionState == ConnectionState.active) {
//          Customer customers = snapshot.data;
//
//          return Provider<Database>(
//            create: (_) => FirestoreDatabase(cust_id: customers.cust_id),
//            child: TourPackageAdmin(),);
//        } else {
    return Scaffold(
        appBar: AppBar(
          elevation: 2.0,
          title: Text('Setiu Wetlands '),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              onPressed: () => _confirmSignOut(context),
            ),
          ],
        ),
        backgroundColor: Colors.grey[200],
        body: Container(
          child: ButtonTheme(
              minWidth: 150.0,
              height: 120.0,
              child: Container(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            child: Text('Tour Package'),
                            color: Colors.lightGreen,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TourPackageAdmin(),
                                  ));
                            },
                          ),
                          SizedBox(
                            height: 8.0,
                            width: 8.0,
                          ),
                        RaisedButton(
                          child: Text('Tour Activity'),
                          color: Colors.lightGreen,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TourPackageAdmin(),
                                ));
                          },
                        ),
                        SizedBox(
                          height: 8.0,
                          width: 8.0,
                        ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              child: Text('Staff'),
                              color: Colors.lightGreen,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TourPackageAdmin(),
                                    ));
                              },
                            ),
                            SizedBox(
                              height: 8.0,
                              width: 8.0,
                            ),
                            RaisedButton(
                              child: Text('Resort'),
                              color: Colors.lightGreen,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TourPackageAdmin()),
                                );
                              },
                            ),
                            SizedBox(
                              height: 8.0,
                              width: 8.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                 ] ),
                ]),
              )),
        ))));
  }
}

Column getCardbyTitle(String title) {
  String img = "";
  if (title == "Tour Package")
    img = 'images/tour_package.png';
  else if (title == "Tour Activity")
    img = 'images/tour_activity.png';
  else if (title == "Resort")
    img = 'images/resort.png';
  else
    img = 'images/staff.png';

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      new Center(
        child: Container(
          child: new Stack(
            children: <Widget>[
              new Image.asset(
                img,
                width: 80.0,
                height: 80.0,
              )
            ],
          ),
        ),
      ),
      Text(
        title,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      )
    ],
  );
}

//final auth = Provider.of<AuthBase>(context);
//return StreamBuilder<Customer>(
//stream: auth.onAuthStateChanged,
//builder: (context, snapshot) {
//if (snapshot.connectionState ==
//ConnectionState.active) {
//Customer customers = snapshot.data;
//if (customers == null) {
//return SignInPage.create(context);
//}
//return Provider<Database>(
//create: (_) =>
//FirestoreDatabase(cust_id: customers
//    .cust_id),
//child: Homepage(),);
//}
//}),
