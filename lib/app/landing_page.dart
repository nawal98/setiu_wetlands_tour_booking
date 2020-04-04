import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/home_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_activities/tour_activity_admin_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/tour_package_admin_page.dart';
import 'package:setiuwetlandstourbooking/app/sign_in/sign_in_page.dart';
import 'package:setiuwetlandstourbooking/app/home/resorts/resort_admin_page.dart';
import 'package:setiuwetlandstourbooking/services/auth.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'package:setiuwetlandstourbooking/services/database.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User users = snapshot.data;
          if (users == null) {
            return SignInPage.create(context);
          }
          return Provider<Database>(
            create: (_) => FirestoreDatabase(uid: users.uid),
            child: TourPackageAdmin(),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
