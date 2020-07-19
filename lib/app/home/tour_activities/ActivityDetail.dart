import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_activity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityDetail extends StatelessWidget {
  String get image => null;
  final Firestore fb = Firestore.instance;
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
                        future: getImages(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    contentPadding: EdgeInsets.all(8.0),
                                    title:
                                    Image.network(
                                        snapshot.data.documents[index].data["url"],
                                        fit: BoxFit.fill),
                                  );
                                });
                          } else if (snapshot.connectionState == ConnectionState.none) {
                            return Text("No data");
                          }
                          return CircularProgressIndicator();
                        },
                      ),
//                      FutureBuilder(
//                        future: _getImage(context, image),
//                        builder: (context, snapshot) {
//                          if (snapshot.connectionState == ConnectionState.done)
//                            return Container(
//                              height: MediaQuery.of(context).size.height / 2.5,
//                              width: MediaQuery.of(context).size.width / 1.25,
//                              child: snapshot.data,
//                            );
//
//                          if (snapshot.connectionState ==
//                              ConnectionState.waiting)
//                            return Container(
//                                height:
//                                    MediaQuery.of(context).size.height / 1.1,
//                                width: MediaQuery.of(context).size.width / 1.25,
//                                child: CircularProgressIndicator());
//
//                          return Container();
//                        },
//                      ),

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
                        ],
                      ),

                      SizedBox(height: 12),
                      SizedBox(
                        width: 360,
                        child: Text(
                          tourActivity.activityDescription,
//                  textAlign: TextAlign.left,
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.black54),
                        ),
                      ),
                    ]))));
  }


  Future<QuerySnapshot> getImages() {

    return fb.collection("tourActivities/").getDocuments();
  }
}
