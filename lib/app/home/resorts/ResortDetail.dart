import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/resort_rooms_customer_page.dart';
import 'package:setiuwetlandstourbooking/app/models/resort.dart';
import 'package:setiuwetlandstourbooking/plugins/firetop/storage/fire_storage_service.dart';

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
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FutureBuilder(
                        future: _getImage(context, image),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done)
                            return Container(
                              height: MediaQuery.of(context).size.height / 2.5,
                              width: MediaQuery.of(context).size.width / 1.25,
                              child: snapshot.data,
                            );

                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.1,
                                width: MediaQuery.of(context).size.width / 1.25,
                                child: CircularProgressIndicator());

                          return Container();
                        },
                      ),

//              loadButton(context),
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
                                  color: Colors.black54),
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
                      SizedBox(height: 18),
                      Row(children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.location_on, color: Colors.lightGreen),
                        ),
                        SizedBox(
                            width: 260,
                            child:
                        Text(resort.resortAddress, style: TextStyle(fontSize: 16.0, color: Colors.black54)),
                        ), ]), SizedBox(height: 16),
                      Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.phone, color: Colors.lightGreen),
                        ),

                        Text('+'+resort.resortTel, style: TextStyle(fontSize: 16.0, color: Colors.black54)),
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

  Future<Widget> _getImage(BuildContext context, String image) async {
    Image m;
    await FireStorageService.loadFromStorage(context, image)
        .then((downloadUrl) {
      m = Image.network(
        downloadUrl.toString(),
        fit: BoxFit.scaleDown,
      );
    });
    return m;
  }
}
