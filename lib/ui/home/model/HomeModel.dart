// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  String message;
  int status;
  Data data;

  HomeModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        message: json["message"] ?? "",
        status: json["status"] ?? 0,
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  int dailyWage;
  dynamic totalPayoutThisMonth;
  dynamic paidThisMonth;
  String workerName;
  bool isPresent;
  dynamic pendingPayout;

  Data({
    required this.dailyWage,
    required this.totalPayoutThisMonth,
    required this.workerName,
    required this.paidThisMonth,
    required this.isPresent,
    required this.pendingPayout,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        dailyWage: json["daily_wage"] ?? 0,
        totalPayoutThisMonth: json["total_payout_this_month"] ?? "0",
        workerName: json["worker_name"] ?? "",
        paidThisMonth: json["paid_this_month"] ?? "0",
        isPresent: json["is_present"] ?? false,
        pendingPayout: json["pending_payout"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "daily_wage": dailyWage,
        "total_payout_this_month": totalPayoutThisMonth,
        "paid_this_month": paidThisMonth,
        "is_present": isPresent,
        "pending_payout": pendingPayout,
        "worker_name": workerName,
      };
}
