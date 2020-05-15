import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/account/account_page.dart';
import 'package:setiuwetlandstourbooking/app/home/resorts/resort_admin_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_activities/tour_activity_admin_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/tour_package_customer_page.dart';
import 'package:setiuwetlandstourbooking/app/landing_page.dart';
import 'package:setiuwetlandstourbooking/services/auth.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:setiuwetlandstourbooking/app/home/navigationDrawer.dart';
import 'package:setiuwetlandstourbooking/app/home/pageRoute.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Setiu Wetlands Tour Booking',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: LandingPage(),
        routes: <String, WidgetBuilder>{
    '/account': (BuildContext context) => new AccountPage(),
    '/tourPackage': (BuildContext context) => new TourPackageCustomer(),
    '/tourActivity': (BuildContext context) => new TourActivityAdmin(),
    '/resort': (BuildContext context) => new ResortAdmin(),
    },
//        routes: {
//          PageRoutes.profile: (context) => AccountPage(),
//          PageRoutes.tourPackages: (context) => TourPackageCustomer(),
//          PageRoutes.tourActivities: (context) => TourActivityAdmin(),
//          PageRoutes.resorts: (context) => ResortAdmin(),
//        },),
//          initialRoute: "/account",

//            routes: {
//                        PageRoutes.profile: (context) => AccountPage(),
//          PageRoutes.tourPackages: (context) => TourPackageCustomer(),
//          PageRoutes.tourActivities: (context) => TourActivityAdmin(),
//          PageRoutes.resorts: (context) => ResortAdmin(),
    // When navigating to the "/" route, build the FirstScreen widget.
//    '/account': (context) => AccountPage(),
//    '/tourPackage': (context) => TourPackageCustomer(),
//    '/tourActivity': (context) => TourActivityAdmin(),
//    '/resort': (context) => ResortAdmin(),
    ));}
  }

