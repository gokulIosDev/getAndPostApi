// To parse this JSON data, do
//
//     final session = sessionFromJson(jsonString);

import 'dart:convert';

List<Session> sessionFromJson(String str) => List<Session>.from(json.decode(str).map((x) => Session.fromJson(x)));

String sessionToJson(List<Session> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Session {
  int cashierid;
  String smname;
  String pwd;
  String? usertoken;
  String emailid;
  String mobileno;
  String isexists;
  String? userToken1;
  String deviceid;
  String isactive;
  String noteLanguage;
  String? ideviceid;
  String? iusertoken;

  Session({
    required this.cashierid,
    required this.smname,
    required this.pwd,
    required this.usertoken,
    required this.emailid,
    required this.mobileno,
    required this.isexists,
    required this.userToken1,
    required this.deviceid,
    required this.isactive,
    required this.noteLanguage,
    required this.ideviceid,
    required this.iusertoken,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    cashierid: json["cashierid"],
    smname: json["smname"],
    pwd: json["pwd"],
    usertoken: json["usertoken"],
    emailid: json["emailid"],
    mobileno: json["mobileno"],
    isexists: json["isexists"],
    userToken1: json["userToken1"],
    deviceid: json["deviceid"],
    isactive: json["isactive"],
    noteLanguage: json["NoteLanguage"],
    ideviceid: json["ideviceid"],
    iusertoken: json["iusertoken"],
  );

  Map<String, dynamic> toJson() => {
    "cashierid": cashierid,
    "smname": smname,
    "pwd": pwd,
    "usertoken": usertoken,
    "emailid": emailid,
    "mobileno": mobileno,
    "isexists": isexists,
    "userToken1": userToken1,
    "deviceid": deviceid,
    "isactive": isactive,
    "NoteLanguage": noteLanguage,
    "ideviceid": ideviceid,
    "iusertoken": iusertoken,
  };
}
