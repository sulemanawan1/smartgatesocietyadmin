class ReportNotification {
   int? id;
  String? firstname;
  String? lastname;
  String? cnic;
  String? address;
  String? mobileno;
  int? roleid;
  String? rolename;
  String? image;

  int? userid;
  int? subadminid;
  String? title;
  String? description;
  String? date;
  int? status;
  String? statusdescription;

  String? created_at;
  String? updated_at;

  ReportNotification(
      {required this.id,
      required this.firstname,
      required this.lastname,
      
      required this.address,
      required this.mobileno,
      
      
      required this.userid,
      required this.subadminid,
      required this.title,
      required this.description,
      required this.date,
      required this.status,
      required this.statusdescription,
      required this.created_at,
      required this.updated_at});
}
