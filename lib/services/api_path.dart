class APIPath {

  static String tourPackage(String tourPackageid) =>
      'tourPackages/$tourPackageid';
  static String tourPackages(String uid) => '/tourPackages';


  static String resort( String resortid) =>
      'resorts/$resortid';
  static String resorts(String uid) => '/resorts';

  static String tourActivity(String tourActivityid) =>
      'tourActivities/$tourActivityid';
  static String tourActivities(String uid) => '/tourActivities';

  static String room( String roomid) =>
      'rooms/$roomid';
  static String rooms(String uid) => '/rooms';


  static String booking( String bookingid) =>
      'bookings/$bookingid';
  static String bookings(String uid) => '/bookings';



  static String userInfo(String uid, String userid) =>
      'users/$uid/userInfos/$userid';
  static String userInfos(String uid) => 'users/$uid/userInfos';


  static String bookingRoom( String bookingRoomid) =>
      'bookingsRoom/$bookingRoomid';
  static String bookingsRoom(String uid) => '/bookingsRoom';


  static String feedback( String feedbackid) =>
      'feedbacks/$feedbackid';
  static String feedbacks(String uid) => '/feedbacks';

//  static String feedback(String uid, String feedbackid) =>
//      'users/$uid/feedbacks/$feedbackid';
//  static String feedbacks(String uid) => 'users/$uid/feedbacks';
}
