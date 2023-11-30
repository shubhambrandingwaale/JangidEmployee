import 'dart:convert';

import 'package:attendance_employee/ui/payout/model/PayoutModel.dart';
import 'package:attendance_employee/utility/Api.dart';
import 'package:attendance_employee/utility/CustomFunctions.dart';
import 'package:attendance_employee/utility/MyStatus.dart';
import 'package:attendance_employee/utility/Util.dart';
import 'package:attendance_employee/widgets/ToastBar.dart';
import 'package:attendance_employee/utility/MyStatus.dart';
import 'package:flutter/material.dart';

class PayoutRepository with ChangeNotifier {
  String error = "";
  Status _status = Status.Uninitialized;
  Status get status => _status;


  PayoutModel get payoutData => _payoutData;
  late List<Datum> payoutListData;
  var _payoutData;

  Future<bool> getWorkerPayout(BuildContext context) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.workerPayout;
    String token = await Util.gettoken();
    final response = await Api.getrequest(url, context, token: token);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("getData in json: $json");
        error = '';
        _status = Status.Authenticated;
        _payoutData = PayoutModel.fromJson(json);
        payoutListData = payoutData.data;
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
