import 'package:chefs_hat/test.dart';
import 'package:chefs_hat/view/landingPage/landingPage.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'landingPage',

    routes: {
      // VIEWS
      // VIEWS - LANDING PAGE
      'landingPage': (context) => landingPage(),

      'test': (context) => test(),
    },
  ));
}