import 'package:attendance_employee/HomePage.dart';
import 'package:attendance_employee/ui/login/view/Login.dart';
import 'package:attendance_employee/utility/Util.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Future.delayed(const Duration(seconds: 0), () async {
    if(await Util.gettoken()==''){
      runApp(const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:LoginController(),
      ));
    } else {
      runApp(const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:HomePage(),
      ));
    }
  });
}