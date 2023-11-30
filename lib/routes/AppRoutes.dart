import 'package:attendance_employee/HomePage.dart';
import 'package:attendance_employee/ui/login/view/Login.dart';
import 'package:flutter/material.dart';

class Routesapp {
  static gotoBackPage(BuildContext context) async => Navigator.pop(context);

  static gotoHomeScreen(BuildContext context) async => Navigator.push(
      context, MaterialPageRoute(builder: (context) => HomePage()));


  static gotoLoginPage(BuildContext context) async =>
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginController()),
              (Route<dynamic> route) => false);

}
