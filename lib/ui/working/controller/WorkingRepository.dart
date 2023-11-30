import 'dart:convert';
import 'package:attendance_employee/routes/AppRoutes.dart';
import 'package:attendance_employee/ui/home/model/HomeModel.dart';
import 'package:attendance_employee/ui/working/model/AttendanceModel.dart';
import 'package:attendance_employee/utility/Api.dart';
import 'package:attendance_employee/utility/CustomFunctions.dart';
import 'package:attendance_employee/utility/MyStatus.dart';
import 'package:attendance_employee/utility/Util.dart';
import 'package:attendance_employee/widgets/ToastBar.dart';
import 'package:attendance_employee/utility/MyStatus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:location/location.dart' as locator;
import 'package:permission_handler/permission_handler.dart' as pe;
import 'package:permission_handler/permission_handler.dart';

class WorkingRepository with ChangeNotifier {
  String error = "";
  Status _status = Status.Uninitialized;
  Status get status => _status;

  List<AllAttendanceWorker> attendanceList = [];

  Future<bool> getAttendanceById(BuildContext context) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.attendance;
    String workerId = await Util.getUserId();
    var keys = {"worker_id": workerId};
    final response = await Api.getrequestwithbody(url, context, keys);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("getAttendance in json: $json");
        error = '';
        _status = Status.Authenticated;
        attendanceList = allAttendanceWorkerFromJson(response);
        notifyListeners();
        return true;
      } catch (e) {
        _status = Status.Authenticated;
        error = e.toString();
        _status = Status.error;
        notifyListeners();
        return false;
      }
    } else {
      _status = Status.Authenticated;
      _status = Status.error;
      notifyListeners();
      return false;
    }
  }
}
