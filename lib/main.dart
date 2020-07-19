import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/landing_page.dart';
import 'package:setiuwetlandstourbooking/services/auth.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;

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
        ));
  }
}
