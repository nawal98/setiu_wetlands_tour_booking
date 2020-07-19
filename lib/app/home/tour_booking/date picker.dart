import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/format.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/input_dropdown.dart';

class DatePicker extends StatelessWidget {
   DatePicker({
    Key key,
     this.labelText,
     this.selectedDate,
     this.selectedTime,
     this.selectDate,
     this.selectTime,

  }) : super(key: key);

   final String labelText;
   final DateTime selectedDate;
   final TimeOfDay selectedTime;
   final ValueChanged<DateTime> selectDate;
   final ValueChanged<TimeOfDay> selectTime;







//  DateTime selectedDate = DateTime.now();
Future<Void> _selectDate(BuildContext context) async {
  final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2018, 8),
      lastDate: DateTime(2101));
  if (picked != null && picked != selectedDate){
    selectDate(picked);

};}

@override
Widget build(BuildContext context) {
  final valueStyle = Theme.of(context).textTheme.title;
  return Scaffold(
    appBar: AppBar(

    ),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("${selectedDate.toLocal()}".split(' ')[0]),
          SizedBox(height: 10.0,),

          RaisedButton(
            onPressed: () => _selectDate(context),
            child: Text('Select date'),

          ),
        ],
      ),
    ),
  );
}}