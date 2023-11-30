// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String message;
  int status;
  Data data;

  LoginModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    message: json["message"]??"",
    status: json["status"]??0,
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Worker worker;
  String token;

  Data({
    required this.worker,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    worker: Worker.fromJson(json["worker"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "worker": worker.toJson(),
    "token": token,
  };
}

class Worker {
  int id;
  String fullname;
  String phone;
  String role;
  List<dynamic> docs;
  dynamic profileImg;
  String username;
  int dailyWageSalary;
  bool isPresent;
  bool isDisabled;
  int totalWorkingHours;
  int totalPayout;
  int totalPaid;
  int pendingPayout;
  String lat;
  String long;
  DateTime createdAt;
  DateTime updatedAt;
  String address;
  dynamic supervisorId;
  String siteAssigned;

  Worker({
    required this.id,
    required this.fullname,
    required this.phone,
    required this.role,
    required this.docs,
    required this.profileImg,
    required this.username,
    required this.dailyWageSalary,
    required this.isPresent,
    required this.isDisabled,
    required this.totalWorkingHours,
    required this.totalPayout,
    required this.totalPaid,
    required this.pendingPayout,
    required this.lat,
    required this.long,
    required this.createdAt,
    required this.updatedAt,
    required this.address,
    required this.supervisorId,
    required this.siteAssigned,
  });

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
    id: json["id"]??0,
    fullname: json["fullname"]??"",
    phone: json["phone"]??"",
    role: json["role"]??"",
    docs: json["docs"] == null
        ? []
        :List<dynamic>.from(json["docs"].map((x) => x)),
    profileImg: json["profile_img"]??"",
    username: json["username"]??"",
    dailyWageSalary: json["daily_wage_salary"]??0,
    isPresent: json["is_present"]??false,
    isDisabled: json["is_disabled"]??false,
    totalWorkingHours: json["total_working_hours"]??0,
    totalPayout: json["total_payout"]??0,
    totalPaid: json["total_paid"]??0,
    pendingPayout: json["pending_payout"]??0,
    lat: json["lat"]??"",
    long: json["long"]??"",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    address: json["address"]??"",
    supervisorId: json["supervisor_id"],
    siteAssigned: json["site_assigned"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "phone": phone,
    "role": role,
    "docs": List<dynamic>.from(docs.map((x) => x)),
    "profile_img": profileImg,
    "username": username,
    "daily_wage_salary": dailyWageSalary,
    "is_present": isPresent,
    "is_disabled": isDisabled,
    "total_working_hours": totalWorkingHours,
    "total_payout": totalPayout,
    "total_paid": totalPaid,
    "pending_payout": pendingPayout,
    "lat": lat,
    "long": long,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "address": address,
    "supervisor_id": supervisorId,
    "site_assigned": siteAssigned,
  };
}
