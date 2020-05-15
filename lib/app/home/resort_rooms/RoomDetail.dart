import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/resort_rooms_customer_page.dart';
import 'package:setiuwetlandstourbooking/app/models/room.dart';
import 'package:setiuwetlandstourbooking/plugins/firetop/storage/fire_storage_service.dart';
import 'package:setiuwetlandstourbooking/app/models/booking.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
class RoomDetail extends StatefulWidget {

  const RoomDetail(
      {@required this.database, @required this.room, this.booking});
  final Room room;
  final Booking booking;
  final Database database;

  State<StatefulWidget> createState() => _RoomDetailState();
}
class _RoomDetailState extends State<RoomDetail> {
  String get image => null;
  int _r = 0;
  void addr() {
    setState(() {
      _r++;
    });
  }

  void minusr() {
    setState(() {
      if (_r != 0) _r--;
    });
  }
  @override
  Widget build(BuildContext context) {
    final Room room = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(room.bedType),
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
                          Text('RM'+
                            room.roomPrice,
                            style: TextStyle(fontSize: 18.0, color: Colors.green[700],fontWeight: FontWeight.bold,),
                          ),
                        ],
                      ),

                      SizedBox(height: 12),
                      SizedBox(
                        width: 360,
                        child: Text(
                          room.roomNo,
//                  textAlign: TextAlign.left,
                          style:
                          TextStyle(fontSize: 15.0, color: Colors.black54),
                        ),
                      ),
                      SizedBox(height: 18),
            SizedBox(
              width: 300,
              child: Text(
                'Select Rooms',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black54),
              ),
            ),
            SizedBox(height: 12),
            Row(
                children: <Widget>[
                  SizedBox(width: 10),
                  SizedBox(
                    width: 30,
                    child: FloatingActionButton(
                      heroTag: "bt7",
                      onPressed: minusr,
                      child: new Icon(
                          const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                          color: Colors.black),
                      backgroundColor: Colors.lightGreen,
                    ),
                  ),
                  SizedBox(width: 10),
                  new Text('$_r', style: new TextStyle(fontSize: 15.0)),
                  SizedBox(width: 10),
                  SizedBox(
                      width: 30,
                      child: FloatingActionButton(
                        heroTag: "bt8",
                        onPressed: addr,
                        child: new Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.lightGreen,
                      )),

//                      Row(children: <Widget>[
//
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Icon(Icons.hotel, color: Colors.lightGreen),
//                        ),
//                        SizedBox(
//                          width: 260,
//                          child:
//                          Text(room.resortAddress, style: TextStyle(fontSize: 16.0, color: Colors.black54)),
//                        ), ]), SizedBox(height: 16),
//                      Row(children: <Widget>[
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Icon(Icons.phone, color: Colors.lightGreen),
//                        ),
//
//                        Text('+'+resort.resortTel, style: TextStyle(fontSize: 16.0, color: Colors.black54)),
//                      ]),
//                      SizedBox(height: 18),
                ],
            ),

                      const SizedBox(height: 20),


                      ButtonTheme(
                        minWidth: 325.0,
                        child: RaisedButton(
                          onPressed: ()  {},


                          color: Colors.lightGreen,
                          child: const Text('Add to Booking',
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