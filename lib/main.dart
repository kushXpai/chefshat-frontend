import 'package:chefs_hat/controller/profile/activity/activity.dart';
import 'package:chefs_hat/controller/profile/cookbooks/cookbooks.dart';
import 'package:chefs_hat/controller/profile/cookbooks/savedRecipes.dart';
import 'package:chefs_hat/controller/profile/photos/photos.dart';
import 'package:chefs_hat/entryPoint.dart';
import 'package:chefs_hat/test.dart';
import 'package:chefs_hat/view/authentication/mobileNumber.dart';
import 'package:chefs_hat/view/authentication/otpVerification.dart';
import 'package:chefs_hat/view/dishDescription/dishDescription.dart';
import 'package:chefs_hat/view/homePage/homePage.dart';
import 'package:chefs_hat/view/landingPage/landingPage.dart';
import 'package:chefs_hat/view/profile/profile.dart';
import 'package:chefs_hat/view/registration/registrationStep1.dart';
import 'package:chefs_hat/view/registration/registrationStep2.dart';
import 'package:chefs_hat/view/registration/registrationStep3.dart';
import 'package:flutter/material.dart';


void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'landingPage',
    // initialRoute: 'entryPoint',
    // initialRoute: 'test',

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
      // VIEWS - DESCRIPTION
      'dishDescription': (context) => const dishDescription(),
      // VIEWS - PROFILE
      'profile' : (context) => const profile(),
      // VIEWS - PROFILE - PHOTOS
      'photos' : (context) => const photos(),
      // VIEWS - PROFILE - COOKBOOKS
      'cookbooks' : (context) => const cookbooks(),
      'savedRecipes' : (context) => const savedRecipes(),
      // VIEWS - PROFILE - ACTIVITY
      'activity' : (context) => const activity(),

      'entryPoint': (context) => const entryPoint(),
      'test': (context) => const test(),
    },
  ));
}