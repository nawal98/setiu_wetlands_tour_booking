class Staff{
  int staffid;
  String staffrole;


Staff({this.staffid, this.staffrole});
 static List<Staff> getStaff() {
   return <Staff>[
     Staff(staffid: 1, staffrole: 'Tour Admin'),
     Staff(staffid: 2, staffrole: 'Tour Operator'),
     Staff(staffid: 3, staffrole: 'Tour Manager'),
   ];

 }
}