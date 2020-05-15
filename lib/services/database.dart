import 'package:flutter/foundation.dart';
import 'package:setiuwetlandstourbooking/app/models/resort.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_activity.dart';
import 'package:setiuwetlandstourbooking/services/api_path.dart';
import 'package:setiuwetlandstourbooking/services/auth.dart';
import 'package:setiuwetlandstourbooking/services/firestore_service.dart';
import 'package:setiuwetlandstourbooking/app/models/room.dart';
import 'dart:async';
import 'package:setiuwetlandstourbooking/app/models/user_info.dart';
import 'package:setiuwetlandstourbooking/app/models/booking.dart';
abstract class Database {
  Future<void> setTourPackage(TourPackage tourPackage);
  Future<void> deleteTourPackage(TourPackage tourPackage);
  Stream<List<TourPackage>> tourPackagesStream();
  Stream<TourPackage> tourPackageStream({@required String tourPackageId});


  Future<void> setResort(Resort resort);
  Future<void> deleteResort(Resort resort);
  Stream<List<Resort>> resortsStream();
  Stream<Resort> resortStream({@required String resortId});

  Future<void> setTourActivity(TourActivity tourActivity);
  Future<void> deleteTourActivity(TourActivity tourActivity);
  Stream<List<TourActivity>> tourActivitiesStream();

  Future<void> setRoom(Room room);
  Future<void> deleteRoom(Room room);
  Stream<List<Room>> roomsStream({Resort resort});

  Future<void> setUserInfo(UserInfo userInfo);
  Future<void> deleteAccount(UserInfo userInfo);
  Stream<List<UserInfo>>userInfosStream();

  Future<void> setBooking(Booking booking);
  Future<void> deleteBooking(Booking booking);
  Stream<List<Booking>> bookingsStream({TourPackage tourPackage});
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;
  final _service = FirestoreService.instance;

  Stream<TourPackage> tourPackageStream({@required String tourPackageId}) =>
      _service.documentStream(
        path: APIPath.tourPackage(uid, tourPackageId),
        builder: (data, documentId) => TourPackage.fromMap(data, documentId),
      );
  @override
  Future<void> setTourPackage(TourPackage tourPackage) async =>
      await _service.setData(
        path: APIPath.tourPackage(uid, tourPackage.tourPackageId),
        data: tourPackage.toMap(),
      );

  @override
  Future<void> deleteTourPackage(TourPackage tourPackage) async {
    final allBookings = await bookingsStream(tourPackage: tourPackage).first;
    for (Booking booking in allBookings) {
      if (booking.tourPackageId == tourPackage.tourPackageId) {
        await deleteBooking(booking);
      }
    }

    await _service.deleteData(
      path: APIPath.tourPackage(uid, tourPackage.tourPackageId),
    );
  }
//read all list
  Stream<List<TourPackage>>  tourPackagesStream() => _service.collectionStream(
        path: APIPath.tourPackages(uid),
        builder: (data, documentId) => TourPackage.fromMap(data, documentId),
      );

    @override
    Future<void> setBooking(Booking booking) async => await _service.setData(
      path: APIPath.booking(uid, booking.bookingId),
      data: booking.toMap(),
    );
    @override
    Future<void> deleteBooking(Booking booking) async => await _service.deleteData(path: APIPath.booking(uid, booking.bookingId));

    @override
    Stream<List<Booking>> bookingsStream({TourPackage tourPackage}) => _service.collectionStream<Booking>(
      path: APIPath.bookings(uid),
      queryBuilder: tourPackage != null ? (query) => query.where('tourPackageId', isEqualTo: tourPackage.tourPackageId) : null,
      builder: (data, documentID) => Booking.fromMap(data, documentID),
      sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
    );

  @override
  Future<void> setResort(Resort resort) async => await _service.setData(
        path: APIPath.resort(uid, resort.resortId),
        data: resort.toMap(),
      );

  @override
  Future<void> deleteResort(Resort resort) async {
    // delete where entry.jobId == job.jobId
    final allRooms = await roomsStream(resort: resort).first;
    for (Room room in allRooms) {
      if (room.resortId == resort.resortId) {
        await deleteRoom(room);
      }
    }
    // delete job
    await _service.deleteData(path: APIPath.resort(uid, resort.resortId));
  }
@override
  Stream<Resort> resortStream({@required String resortId}) =>
      _service.documentStream(
        path: APIPath.resort(uid, resortId),
        builder: (data, documentId) => Resort.fromMap(data, documentId),
      );
//read all list
  @override
  Stream<List<Resort>> resortsStream() => _service.collectionStream(
        path: APIPath.resorts(uid),
        builder: (data, documentId) => Resort.fromMap(data, documentId),
      );
  @override
  Future<void> setRoom(Room room) async => await _service.setData(
        path: APIPath.room(uid, room.id),
        data: room.toMap(),
      );

  @override
  Future<void> deleteRoom(Room room) async =>
      await _service.deleteData(path: APIPath.room(uid, room.id));

  @override
  Stream<List<Room>> roomsStream({Resort resort}) =>
      _service.collectionStream<Room>(
        path: APIPath.rooms(uid),
        queryBuilder: resort != null
            ? (query) => query.where('resortId', isEqualTo: resort.resortId)
            : null,
        builder: (data, documentID) => Room.fromMap(data, documentID),
      );

  @override
  Future<void> setTourActivity(TourActivity tourActivity) async =>
      await _service.setData(
        path: APIPath.tourActivity(uid, tourActivity.tourActivityId),
        data: tourActivity.toMap(),
      );

  @override
  Future<void> deleteTourActivity(TourActivity tourActivity) async =>
      await _service.deleteData(
        path: APIPath.tourActivity(uid, tourActivity.tourActivityId),
      );
//read all list
  Stream<List<TourActivity>> tourActivitiesStream() =>
      _service.collectionStream(
        path: APIPath.tourActivities(uid),
        builder: (data, documentId) => TourActivity.fromMap(data, documentId),
      );

  Future<void> setUserInfo(UserInfo userInfo) async =>
      await _service.setData(
        path: APIPath.tourPackage(uid, userInfo.userId),
        data: userInfo.toMap(),
      );

  @override
  Future<void> deleteAccount(UserInfo userInfo) async =>
      await _service.deleteData(
        path: APIPath.tourPackage(uid, userInfo.userId),
      );
//read all list
  Stream<List<UserInfo>> userInfosStream() => _service.collectionStream(
    path: APIPath.userInfos(uid),
    builder: (data, documentId) => UserInfo.fromMap(data, documentId),
  );


}
