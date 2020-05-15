import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_activity.dart';
import 'package:setiuwetlandstourbooking/plugins/firetop/storage/fire_storage_service.dart';
class ActivityDetail extends StatelessWidget {
  String get image => null;

  @override
  Widget build(BuildContext context) {
    final TourActivity tourActivity = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(tourActivity.activityName),
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

      if (snapshot.connectionState == ConnectionState.waiting)
      return Container(
      height: MediaQuery.of(context).size.height / 1.1,
      width: MediaQuery.of(context).size.width / 1.25,
      child: CircularProgressIndicator());

      return Container();
      },
      ),

//              loadButton(context),
      Row(children: <Widget>[
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
 
    ],
    ),

    SizedBox(height: 12),
    SizedBox(
    width: 360,
    child: Text(
    tourActivity.activityDescription,
//                  textAlign: TextAlign.left,
    style: TextStyle(fontSize: 15.0, color: Colors.black54),
    ),
    ),
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