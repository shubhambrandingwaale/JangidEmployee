// To parse this JSON data, do
//
//     final payoutModel = payoutModelFromJson(jsonString);

import 'dart:convert';

PayoutModel payoutModelFromJson(String str) =>
    PayoutModel.fromJson(json.decode(str));

String payoutModelToJson(PayoutModel data) => json.encode(data.toJson());

class PayoutModel {
  String message;
  int status;
  List<Datum> data;

  PayoutModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory PayoutModel.fromJson(Map<String, dynamic> json) => PayoutModel(
        message: json["message"] ?? "",
        status: json["status"] ?? "",
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  int amount;
  String profileImg;
  String purpose;
  int siteId;
  DateTime createdAt;
  String comment;
  int supervisorId;
  int workerId;
  String supervisorName;

  Datum({
    required this.id,
    required this.amount,
    required this.profileImg,
    required this.purpose,
    required this.siteId,
    required this.createdAt,
    required this.comment,
    required this.supervisorId,
    required this.workerId,
    required this.supervisorName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? 0,
        amount: json["amount"] ?? 0,
        profileImg: json["profile_img"] ?? "",
        purpose: json["purpose"] ?? "",
        siteId: json["site_id"] ?? 0,
        createdAt: DateTime.parse(json["created_at"]),
        comment: json["comment"] ?? "",
        supervisorId: json["supervisor_id"] ?? 0,
        workerId: json["worker_id"] ?? 0,
        supervisorName: json["supervisor_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "purpose": purpose,
        "site_id": siteId,
        "created_at": createdAt.toIso8601String(),
        "comment": comment,
        "supervisor_id": supervisorId,
        "worker_id": workerId,
        "supervisor_name": supervisorName,
        "profile_img": profileImg,
      };
}
