class APIPath {
  static String tourPackage(String uid, String tourPackageid) =>
      'users/$uid/tourPackages/$tourPackageid';
  static String tourPackages(String uid) => 'users/$uid/tourPackages';


  static String resort(String uid, String resortid) =>
      'users/$uid/resorts/$resortid';
  static String resorts(String uid) => 'users/$uid/resorts';

  static String tourActivity(String uid, String tourActivityid) =>
      'users/$uid/tourActivities/$tourActivityid';
  static String tourActivities(String uid) => 'users/$uid/tourActivities';

  static String room(String uid, String roomid) =>
      'users/$uid/rooms/$roomid';
  static String rooms(String uid) => 'users/$uid/rooms';

  static String userInfo(String uid, String userid) =>
      'users/$uid/userInfos/$userid';
  static String userInfos(String uid) => 'users/$uid/userInfos';

  static String booking(String uid, String bookingid) =>
      'users/$uid/bookings/$bookingid';
  static String bookings(String uid) => 'users/$uid/bookings';
}
