import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/landing_page.dart';
import 'package:setiuwetlandstourbooking/services/auth.dart';

import 'package:provider/provider.dart';

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
          // This is the theme of your applicatio        // Try running your application with "flutter run". You'll see the

          primarySwatch: Colors.lightGreen,
        ),
        home: LandingPage(),
      ),
    );
  }
}
