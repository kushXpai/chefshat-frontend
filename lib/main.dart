import 'package:chefs_hat/entryPoint.dart';
import 'package:chefs_hat/model/pantry/pantryCategory.dart';
import 'package:chefs_hat/model/pantry/pantryDishes.dart';
import 'package:chefs_hat/model/profile/activity/activity.dart';
import 'package:chefs_hat/model/profile/activity/ratedRecipes.dart';
import 'package:chefs_hat/model/profile/cookbooks/cookbooks.dart';
import 'package:chefs_hat/model/profile/cookbooks/savedRecipeCourse.dart';
import 'package:chefs_hat/model/profile/cookbooks/savedRecipes.dart';
import 'package:chefs_hat/model/profile/photos/uploadsGrid.dart';
import 'package:chefs_hat/model/profile/photos/uploadsList.dart';
import 'package:chefs_hat/test.dart';
import 'package:chefs_hat/view/authentication/mobileNumber.dart';
import 'package:chefs_hat/view/authentication/otpVerification.dart';
import 'package:chefs_hat/view/community/community.dart';
import 'package:chefs_hat/view/dishDescription/dishDescription.dart';
import 'package:chefs_hat/view/homePage/homePage.dart';
import 'package:chefs_hat/view/landingPage/landingPage.dart';
import 'package:chefs_hat/view/pantry/pantry.dart';
import 'package:chefs_hat/view/profile/editProfile.dart';
import 'package:chefs_hat/view/profile/postUpload.dart';
import 'package:chefs_hat/view/profile/profile.dart';
import 'package:chefs_hat/view/recipeGenerator/displayDishList.dart';
import 'package:chefs_hat/view/recipeGenerator/recipeGenerator.dart';
import 'package:chefs_hat/view/registration/registrationStep1.dart';
import 'package:chefs_hat/view/registration/registrationStep2.dart';
import 'package:chefs_hat/view/registration/registrationStep3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // initialRoute: 'landingPage',
    initialRoute: 'entryPoint',
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
      'editProfile' : (context) => const editProfile(),
      'postUpload' : (context) => const postUpload(),
      // MODELS - PROFILE - PHOTOS
      'uploadsGrid' : (context) => const uploadsGrid(),
      'uploadsList' : (context) => const uploadsList(),
      // MODELS - PROFILE - COOKBOOKS
      'cookbooks' : (context) => const cookbooks(),
      'savedRecipeCourse' : (context) => const savedRecipeCourse(),
      'savedRecipes' : (context) => const savedRecipes(),
      // MODELS - PROFILE - ACTIVITY
      'activity' : (context) => const activity(),
      'ratedRecipes' : (context) => const ratedRecipes(),
      // VIEWS - RECIPE GENERATOR
      'recipeGenerator' : (context) => const recipeGenerator(),
      'displayDishList' : (context) => const displayDishList(),
      // VIEWS - PANTRY
      'pantry' : (context) => const pantry(),
      // MODELS - PANTRY
      'pantryCategory' : (context) => const pantryCategory(),
      'pantryDishes' : (context) => const pantryDishes(),
      // VIEWS - COMMUNITY
      'community' : (context) => const community(),

      'entryPoint': (context) => const entryPoint(),
      'test': (context) => const test(),
    },
  ));
}