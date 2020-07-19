import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/resort_rooms_customer_page.dart';
import 'package:setiuwetlandstourbooking/app/models/resort.dart';


class ResortDetail extends StatelessWidget {
  String get image => null;

  @override
  Widget build(BuildContext context) {
    final Resort resort = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(resort.resortName),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 250,
                            child: Text(
                              'General Info',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.green[900]),
                            ),
                          ),
                          Expanded(child: Container()),
                          Text(
                             resort.resortType,
                            style: TextStyle(fontSize: 15.0, color: Colors.green[700],fontWeight: FontWeight.bold,),
                          ),
                        ],
                      ),

                      SizedBox(height: 12),
                      SizedBox(
                        width: 360,
                        child: Text(
                          resort.resortDescription,
//                  textAlign: TextAlign.left,
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.black54),
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.location_on, color: Colors.lightGreen),
                        ),
                        SizedBox(
                            width: 260,
                            child:
                        Text(resort.resortAddress+', '+ resort.postcode+', Setiu, Terengganu, Malaysia', style: TextStyle(fontSize: 16.0, color: Colors.black54)),
                        ), ]), SizedBox(height: 16),
                      Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.phone, color: Colors.lightGreen),
                        ),

                        Text('+0'+resort.resortTel.toString(), style: TextStyle(fontSize: 16.0, color: Colors.black54)),
                      ]),
                      SizedBox(height: 18),
                      ButtonTheme(
                        minWidth: 325.0,
                        child: RaisedButton(
                          onPressed: ()  => ResortRoomsCustomer.show(context, resort),

                          color: Colors.lightGreen,
                          child: const Text('Check Room Availability',
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ),
                      ),
                      SizedBox(height: 50),
                    ]))));
  }

  
}
