import 'dart:convert';

import 'package:attendance_employee/routes/AppRoutes.dart';
import 'package:attendance_employee/utility/Api.dart';
import 'package:attendance_employee/utility/CustomFunctions.dart';
import 'package:attendance_employee/utility/MyStatus.dart';
import 'package:attendance_employee/utility/Util.dart';
import 'package:flutter/material.dart';

class LoginRepository with ChangeNotifier {
  String error = "";
  Status _status = Status.Uninitialized;
  Status get status => _status;

/////////////////////////// API Calling ////////////////////////////////////

  Future<bool> login(
      BuildContext context, String userName, String password) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.login;
    var keys = {"username": userName, "password": password};
    final response = await Api.loginrequest(url, keys, false, context);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("post worker in json: $json");
        if (json['message'] == 'success') {
          error = '';
          _status = Status.Authenticated;
          Util.savetoken('${json['data']['token']}');
          String workerId = '${json['data']['worker']['id']}';
          Util.saveUserId(workerId.toString());
          // BrainCode().Navigatorpush(context, DashBoardController());
          Routesapp.gotoHomeScreen(context);
          notifyListeners();
          return true;
        } else {
          _status = Status.Authenticated;
          Customlog(json['message']);
          Util.showmessagebar(context, json['message'], iserror: true);
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
}
