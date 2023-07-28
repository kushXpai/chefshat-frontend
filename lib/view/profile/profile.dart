import 'package:chefs_hat/model/profile/activity/activity.dart';
import 'package:chefs_hat/model/profile/cookbooks/cookbooks.dart';
import 'package:chefs_hat/model/profile/photos/photos.dart';
import 'package:chefs_hat/model/profile/profile.dart';
import 'package:chefs_hat/view/authentication/otpVerification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../constants/colors/customColors.dart';
import '../../controller/graphQL/graphQLClient.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  final String getUserById = r'''
    query($id: ID!) {
      displayUserById(id: $id) {
        username
        profilePhoto
      }
    }
  ''';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: SizedBox(
                height: height,
                width: width,
                child: const Image(
                  image: AssetImage(
                    'assets/backgroundPhotos/woodenBackground.jpg',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 30, top: 67, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: const BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '');
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.all(10),
                          ),
                          child: const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: [
                GraphQLProvider(
                  client: client,
                  child: _buildUserProfileNameImage(width),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 60, right: 0, top: 0, bottom: 0),
                        child: ElevatedButton(
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
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'ratings',
                                style: TextStyle(
                                    fontFamily: 'Georgia',
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
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
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'comments',
                              style: TextStyle(
                                  fontFamily: 'Georgia',
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 60, top: 0, bottom: 0),
                        child: ElevatedButton(
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
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'photos',
                                style: TextStyle(
                                    fontFamily: 'Georgia',
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          padding: const EdgeInsets.all(10),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              'Photos',
                              style: TextStyle(
                                  fontFamily: 'Georgia',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
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
                          padding: const EdgeInsets.all(10),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              'Cookbooks',
                              style: TextStyle(
                                  fontFamily: 'Georgia',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
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
                          padding: const EdgeInsets.all(10),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              'Activity',
                              style: TextStyle(
                                  fontFamily: 'Georgia',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
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
                const Divider(
                  color: CustomColors.white,
                  thickness: 1,
                ),
                SizedBox(
                  height: height - 322,
                  width: width,

                  child: SingleChildScrollView(
                    child: profileStatics.profileIndexTabs == 0
                        ? const photos(): profileStatics.profileIndexTabs == 1
                        ? const cookbooks(): const activity(),
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
      child: Query(
        options: QueryOptions(
          document: gql(getUserById),
          variables: {'id': '${otpVerification.userId}'},
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

          final Map<String, dynamic>? data =
              result.data?['displayUserById'];

          if (data == null) {
            return const Text('No dishes found');
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 0, top: 50, bottom: 5),
                child: Center(
                  child: Container(
                    height: 95,
                    width: 95,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1)),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                          "http://192.168.68.105:8000/media/" + data['profilePhoto']),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 5),
                child: Text(
                  data['username'],
                  style: GoogleFonts.abrilFatface(
                    color: Colors.white,
                    fontSize: 27,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
