import 'package:chefs_hat/model/profile/activity/activity.dart';
import 'package:chefs_hat/model/profile/cookbooks/cookbooks.dart';
import 'package:chefs_hat/model/profile/photos/uploadsGrid.dart';
import 'package:chefs_hat/model/profile/profile.dart';
import 'package:chefs_hat/view/authentication/otpVerification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/colors/Colors.dart';
import '../../controller/graphQL/graphQLClient.dart';
import '../../controller/graphQL/queries/queries.dart';
import '../../controller/registration/registration.dart';
import '../../utils/sharedPreferences.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _logOut() async {
    await SharedPreferencesUtil.clearUserId();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    Navigator.pushReplacementNamed(context, 'landingPage');
  }



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 40,
              child: ElevatedButton(
                onPressed: () {
                  // _showBottomSheet(context);
                  Navigator.pushNamed(context, 'postUpload');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 5, bottom: 5),
                ),
                child: const Icon(
                  Icons.add_a_photo_outlined,
                  color: Colors.white,
                  size: 27,
                ),
              ),
            ),
            SizedBox(
              width: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'pantry');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 5, bottom: 5),
                ),
                child: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 27,
                ),
              ),
            ),
            SizedBox(
              width: 40,
              child: ElevatedButton(
                onPressed: () {
                  _showBottomSheet(context, width);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 5, bottom: 5),
                ),
                child: const Icon(
                  Icons.menu_rounded,
                  color: Colors.white,
                  size: 27,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 80, bottom: 20),
                  child: SizedBox(
                    // height: height * 0.165,
                    // decoration: BoxDecoration(color: Colors.red),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GraphQLProvider(
                          client: client,
                          child: _buildUserProfileNameImage(width),
                        ),
                        GraphQLProvider(
                          client: client,
                          child: _buildUserUploads(width),
                        ),
                        GraphQLProvider(
                          client: client,
                          child: _buildUserRatings(width),
                        ),
                        GraphQLProvider(
                          client: client,
                          child: _buildUserSavedRecipes(width),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 0, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: width / 1.254,
                        height: width / 10,
                        decoration: const BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'editProfile');
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.all(0),
                          ),
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontFamily: 'Georgia',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: width / 10,
                        height: width / 10,
                        decoration: const BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.all(5),
                          ),
                          child: const Column(
                            children: [
                              Text(
                                '',
                                style: TextStyle(
                                  fontFamily: 'Georgia',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width / 3,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            profileStatics.profileIndexTabs = 0;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.all(5),
                        ),
                        child: const Text(
                          'Photos',
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width / 3,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            profileStatics.profileIndexTabs = 1;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.all(5),
                        ),
                        child: const Text(
                          'Cookbooks',
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width / 3,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            profileStatics.profileIndexTabs = 2;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.all(5),
                        ),
                        child: const Text(
                          'Activity',
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0, right: 0, top: 6, bottom: 0),
                          child: AnimatedAlign(
                            alignment: profileStatics.profileIndexTabs == 0
                                ? Alignment.centerLeft
                                : profileStatics.profileIndexTabs == 1
                                    ? Alignment.center
                                    : Alignment.centerRight,
                            duration: const Duration(milliseconds: 350),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0, right: 0),
                              child: Container(
                                width: width / 3,
                                height: 1,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: CustomColors.white,
                      thickness: 0.4,
                    ),
                  ],
                ),
                SizedBox(
                  height: height - 322,
                  width: width,
                  child: SingleChildScrollView(
                    child: profileStatics.profileIndexTabs == 0
                        ? const uploadsGrid()
                        : profileStatics.profileIndexTabs == 1
                            ? const cookbooks()
                            : const activity(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfileNameImage(double width) {
    return SizedBox(
      width: width / 3,
      child: Query(
        options: QueryOptions(
          document: gql(Profile.getUserById),
          variables: {'id': '${UserFormFields.userId}'},
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            print(result.exception.toString());
            return Center(
              child: Text(
                'Error fetching dishes: ${result.exception.toString()}',
              ),
            );
          }

          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final Map<String, dynamic>? data = result.data?['displayUserById'];

          if (data == null) {
            return const Text('No dishes found');
          }

          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                child: Center(
                  child: Container(
                    height: 95,
                    width: 95,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1)),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          NetworkImage(httpLinkImage + data['profilePhoto']),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 0, top: 10, bottom: 5),
                child: Text(
                  data['username'],
                  style: GoogleFonts.abrilFatface(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUserUploads(double width) {
    return SizedBox(
      child: Query(
        options: QueryOptions(
          document: gql(Profile.getAllUserUploadsById),
          variables: {'userId': '${UserFormFields.userId}'},
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            print(result.exception.toString());
            return Center(
              child: Text(
                'Error fetching dishes: ${result.exception.toString()}',
              ),
            );
          }

          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<dynamic> data = result.data?['displayUserUploadById'];
          int numberOfRatedRecipies = 0;
          numberOfRatedRecipies = data.length;

          if (data.isEmpty) {
            return ElevatedButton(
              onPressed: () {
                setState(() {
                  profileStatics.profileIndexTabs == 0;
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: Colors.transparent,
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(10),
              ),
              child: const Column(
                children: [
                  Text(
                    '0',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'photos',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'uploadsList');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: Colors.transparent,
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(10),
              ),
              child: Column(
                children: [
                  Text(
                    "$numberOfRatedRecipies",
                    style: const TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'photos',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildUserRatings(double width) {
    return SizedBox(
      child: Query(
        options: QueryOptions(
          document: gql(Profile.getRatedRecipeById),
          variables: {'id': '${UserFormFields.userId}'},
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            print(result.exception.toString());
            return Center(
              child: Text(
                'Error fetching dishes: ${result.exception.toString()}',
              ),
            );
          }

          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<dynamic> data = result.data?['displayUserRatedRecipeById'];
          int numberOfRatedRecipies = 0;
          numberOfRatedRecipies = data.length;

          if (data.isEmpty) {
            return ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: Colors.transparent,
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(10),
              ),
              child: const Column(
                children: [
                  Text(
                    '0',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'ratings',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'ratedRecipes');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: Colors.transparent,
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(10),
              ),
              child: Column(
                children: [
                  Text(
                    "$numberOfRatedRecipies",
                    style: const TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'ratings',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildUserSavedRecipes(double width) {
    return SizedBox(
      child: Query(
        options: QueryOptions(
          document: gql(Profile.getSavedRecipeById),
          variables: {'userId': '${UserFormFields.userId}'},
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            print(result.exception.toString());
            return Center(
              child: Text(
                'Error fetching dishes: ${result.exception.toString()}',
              ),
            );
          }

          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<dynamic> data = result.data?['displayUserSavedRecipeById'];
          int numberOfRatedRecipies = 0;
          numberOfRatedRecipies = data.length;

          if (data.isEmpty) {
            return ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: Colors.transparent,
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(10),
              ),
              child: const Column(
                children: [
                  Text(
                    '0',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'saved',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'savedRecipes');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: Colors.transparent,
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(10),
              ),
              child: Column(
                children: [
                  Text(
                    "$numberOfRatedRecipies",
                    style: const TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'saved',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _showBottomSheet(BuildContext context, double width) {
    Scaffold.of(context)?.showBottomSheet<void>(
      backgroundColor: Colors.black,
      (BuildContext context) {
        return Container(
          width: width,
          decoration: BoxDecoration(
            color: Colors.grey[800], // Dark grey background
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min, // Column size will be as small as needed
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Handle the "Settings" action here
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent, // Transparent background
                    onPrimary: Colors.white, // White text color
                    elevation: 0, // No elevation
                    alignment: Alignment.centerLeft, // Align text to the left
                  ),
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Settings',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: width,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _logOut();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent, // Transparent background
                    onPrimary: Colors.white, // White text color
                    elevation: 0, // No elevation
                    alignment: Alignment.centerLeft, // Align text to the left
                  ),
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
