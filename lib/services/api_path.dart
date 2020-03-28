class APIPath {
  static String tourPackage(String uid, String tourPackageid) =>
      'users/$uid/tourPackages/$tourPackageid';
  static String tourPackages(String uid) => 'users/$uid/tourPackages';


  static String resort(String uid, String resortid) =>
      'users/$uid/resorts/$resortid';
  static String resorts(String uid) => 'users/$uid/resorts';
//  static String tourPackage(String tourPackageid) =>
//      'users/$uid/tourPackages/$tourPackageid';
//  static String tourPackages(String uid) => 'users/$uid/tourPackages';
}
