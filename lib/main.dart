import 'package:chefs_hat/test.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'test',

    routes: {
      'test': (context) => test(),
    },
  ));
}