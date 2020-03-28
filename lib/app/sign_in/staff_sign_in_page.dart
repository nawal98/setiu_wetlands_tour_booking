import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/sign_in/email_sign_in_form_bloc_based.dart';
import 'package:setiuwetlandstourbooking/app/sign_in/email_sign_in_form_change_notifier.dart';
import 'package:setiuwetlandstourbooking/app/sign_in/email_sign_in_form_stateful.dart';
import 'package:setiuwetlandstourbooking/app/sign_in/staff_sign_in_form_change_notifier.dart';
import 'package:setiuwetlandstourbooking/services/auth.dart';

class StaffSignInPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Sign In'),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: StaffSignInFormChangeNotifier.create(context),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
