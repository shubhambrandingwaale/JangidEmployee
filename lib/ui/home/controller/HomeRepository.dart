import 'dart:convert';
import 'package:attendance_employee/routes/AppRoutes.dart';
import 'package:attendance_employee/ui/home/model/HomeModel.dart';
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

class HomeRepository with ChangeNotifier {
  String error = "";
  Status _status = Status.Uninitialized;
  Status get status => _status;

  String btnText = 'Punch - in ';
  bool serviceEnabled = false;
  bool isGPSEnabled = false;
  var latitude, longtitude;

  HomeModel get homeModelData => _homeModelData;
  Data? homeData;
  var _homeModelData;

/////////////////////////// create Model Variable ////////////////////////////////////
  checkGPSStatus() async {
    locator.Location location = locator.Location();
    await location.requestService();
    isGPSEnabled = await Geolocator.isLocationServiceEnabled();
    notifyListeners();
  }

  Future<bool> getCurrentLocation(BuildContext context) async {
    locator.Location location = locator.Location();
    final permission = await pe.Permission.location.request();
    // if (permission == PermissionStatus.permanentlyDenied) {
    //   await Util.showmessagebar(context, 'Location is Mandatory',
    //       iserror: true);
    //   // await AppSettings.openAppSettings(type: AppSettingsType.location);
    //   notifyListeners();
    // }
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      return false;
    } else {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: geolocator.LocationAccuracy.high,
      );
      String a = await _getAddressFromLatLng(position);
      Customlog(a);
      notifyListeners();
      return true;
    }
  }

  Future<String> _getAddressFromLatLng(Position position) async {
    await geo
        .placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<geo.Placemark> placemarks) async {
      geo.Placemark place = placemarks[3];
      Customlog('Address is :$place');
      Customlog(' ${position.latitude}${position.longitude}');
      latitude = position.latitude;
      longtitude = position.longitude;
      notifyListeners();
    }).catchError((e) {
      debugPrint(e);
      return '';
    });
    return '';
  }

  Future<bool> getHomeData(BuildContext context) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.dashBoard;
    String token = await Util.gettoken();
    final response = await Api.getrequest(url, context, token: token);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("getProfile in json: $json");
        error = '';
        if (json['message'] == 'success') {
          _status = Status.Authenticated;
          _homeModelData = HomeModel.fromJson(json);
          homeData = homeModelData.data;
          homeData!.isPresent ? btnText == 'Punch-Out' : btnText == 'Punch-In';
          notifyListeners();
          return true;
        } else {
          _status = Status.Authenticated;
          Toastbar.showToast(msg: json['message']);
          _status = Status.error;
          notifyListeners();
          return false;
        }
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

  String buttonName(BuildContext context, bool isPresent) {
    if (isPresent) {
      btnText = 'Punch-Out';
      return btnText;
    } else {
      btnText = 'Punch-In';
      return btnText;
    }
  }

  Future<bool> PunchIn(BuildContext context) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.punchIn;
    var keys = {"lat": latitude, "long": longtitude};
    final response = await Api.postrequest(url, keys, context);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("post worker in json: $json");
        if (json['message'] == 'success') {
          error = '';
          _status = Status.Authenticated;
          getHomeData(context);
          Util.showmessagebar(context, 'Punch-In Successfully');
          Util.saveSessionId(json['session_id']);
          // Routesapp.gotoWorkerListScreen(context);
          notifyListeners();
          return true;
        } else {
          error = '';
          _status = Status.Authenticated;
          Util.showmessagebar(context, json['message'], iserror: true);
          notifyListeners();
          return true;
        }
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

  Future<bool> PunchOut(BuildContext context) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.punchOut;
    String sessionId = await Util.getSessionId();
    var keys = {"session_id": sessionId, "lat": latitude, "long": longtitude};
    final response = await Api.postrequest(url, keys, context);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("post worker in json: $json");
        if (json['message'] == 'Logged out') {
          error = '';
          _status = Status.Authenticated;
          getHomeData(context);
          Util.showmessagebar(context, 'Punch-Out Successfully');
          // Routesapp.gotoWorkerListScreen(context);
          notifyListeners();
          return true;
        } else {
          error = '';
          _status = Status.Authenticated;
          Util.showmessagebar(context, json['message'], iserror: true);
          notifyListeners();
          return true;
        }
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
