import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/homepage_admin.dart';
import 'package:setiuwetlandstourbooking/app/home/homepage_customer.dart';
import 'package:setiuwetlandstourbooking/app/home/homepage_operator.dart';
import 'package:setiuwetlandstourbooking/app/sign_in/sign_in_page.dart';
import 'package:setiuwetlandstourbooking/app/home/resorts/resort_admin_page.dart';
import 'package:setiuwetlandstourbooking/services/auth.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'package:setiuwetlandstourbooking/services/database.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return SignInPage.create(context);
          }
          return Provider<User>.value(
            value:user,
            child: Provider<Database>(
              create: (_) => FirestoreDatabase(uid: user.uid),

              child:  HomepageCustomer(),
//              child:  HomepageAdmin(),
//              child:  HomepageOperator(),
            ),
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
