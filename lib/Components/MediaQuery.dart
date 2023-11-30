import 'package:flutter/material.dart';

class media_query{
  double mquery(BuildContext context,given_height){
    return MediaQuery.of(context).size.height/given_height;
  }
}