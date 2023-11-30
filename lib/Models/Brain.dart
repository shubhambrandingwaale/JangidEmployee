import 'dart:convert';
import 'package:location/location.dart' as location;
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:attendance_employee/Models/BaseURL.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BrainCode{
   void push(BuildContext context,Route){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Route()));
  }
   Future<String> login_worker(String username,password) async {
    var response;
    response = await http.post(
         Uri.parse(BASEURL().login),
         body: jsonEncode(
          {
          "username":username.toString(),
          "password":password.toString(),
          "lat":"",
          "long":"",
          }
         ),
         headers: {'Content-Type':'application/json'}
        );
       
    String body = response.body;
    return body;
  }
  
}