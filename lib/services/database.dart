import 'package:flutter/foundation.dart';
import 'package:setiuwetlandstourbooking/app/models/resort.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/services/api_path.dart';
import 'package:setiuwetlandstourbooking/services/firestore_service.dart';
import 'dart:async';

abstract class Database {
  Future<void> setTourPackage(TourPackage tourPackage);
  Future<void> deleteTourPackage(TourPackage tourPackage);
  Stream<List<TourPackage>> tourPackagesStream();

  Future<void> setResort(Resort resort);
  Future<void> deleteResort(Resort resort);
  Stream<List<Resort>> resortsStream();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;
  final _service = FirestoreService.instance;

  @override
  Future<void> setTourPackage(TourPackage tourPackage) async =>
      await _service.setData(
        path: APIPath.tourPackage(uid,tourPackage.tourPackageId),
        data: tourPackage.toMap(),
      );

  @override
  Future<void> deleteTourPackage(TourPackage tourPackage) async =>
      await _service.deleteData(
        path: APIPath.tourPackage(uid,tourPackage.tourPackageId),
      );
//read all list
  Stream<List<TourPackage>> tourPackagesStream() => _service.collectionStream(
        path: APIPath.tourPackages(uid),
        builder: (data, documentId) => TourPackage.fromMap(data, documentId),
      );


  @override
  Future<void> setResort(Resort resort) async =>
      await _service.setData(
        path: APIPath.resort(uid,resort.resortId),
        data: resort.toMap(),
      );

  @override
  Future<void> deleteResort(Resort resort) async =>
      await _service.deleteData(
        path: APIPath.resort(uid,resort.resortId),
      );
//read all list
  Stream<List<Resort>> resortsStream() => _service.collectionStream(
    path: APIPath.resorts(uid),
    builder: (data, documentId) => Resort.fromMap(data, documentId),
  );
}
