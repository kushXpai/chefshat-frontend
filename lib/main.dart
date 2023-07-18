import 'package:chefs_hat/test.dart';
import 'package:chefs_hat/view/authentication/mobileNumber.dart';
import 'package:chefs_hat/view/authentication/otpVerification.dart';
import 'package:chefs_hat/view/homePage/homePage.dart';
import 'package:chefs_hat/view/landingPage/landingPage.dart';
import 'package:chefs_hat/view/registration/registrationStep1.dart';
import 'package:chefs_hat/view/registration/registrationStep2.dart';
import 'package:chefs_hat/view/registration/registrationStep3.dart';
import 'package:flutter/material.dart';

void main() {

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // initialRoute: 'landingPage',
    initialRoute: 'homePage',

    routes: {
      // VIEWS
      // VIEWS - LANDING PAGE
      'landingPage': (context) => const landingPage(),
      // VIEWS - AUTHENTICATION
      'mobileNumber': (context) => const mobileNumber(),
      'otpVerification': (context) => const otpVerification(),
      // VIEWS - REGISTRATION
      'registrationStep1': (context) => const registrationStep1(),
      'registrationStep2': (context) => const registrationStep2(),
      'registrationStep3': (context) => const registrationStep3(),
      // VIEWS - HOMEPAGE
      'homePage': (context) => const homePage(),

      'test': (context) => const test(),
    },
  ));
}