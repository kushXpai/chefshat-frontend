import 'package:chefs_hat/view/authentication/otpVerification.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../constants/colors/customColors.dart';
import '../../../controller/graphQL/graphQLClient.dart';

// import 'constants.dart';

class activity extends StatefulWidget {
  const activity({Key? key}) : super(key: key);

  @override
  State<activity> createState() => _activityState();
}

class _activityState extends State<activity> {

  final String getRatedRecipe = '''
    query {
      displayUserRatedRecipeById(userId: ${otpVerification.userId}) {
        id
        userId {
          id
          username
        }
        dishId {
          id
          dishName
          dishImage
        }
        rating
        recipeRated
      }
    }
  ''';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 0,
                bottom: 0,
              ),
              child: _buildSectionHeader("My Ratings ( 0 )"),
            ),
            GraphQLProvider(
              client: client,
              child: _buildUserRatedRecipe(width),
            ),


          ],
        )
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserRatedRecipe(double width) {
    return SizedBox(
      child: Query(
        options: QueryOptions(
          document: gql(getRatedRecipe),
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            print(result.exception.toString());
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<dynamic>? savedRecipes = result.data?['displayUserRatedRecipeById'];

          if (savedRecipes == null || savedRecipes.isEmpty) {
            return Column(
              children: [
                Container(
                  height: 120,
                  width: width,
                  child: Image.asset(
                    'assets/profilePagePhotos/ratings.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
                  child: Text(
                    "Rate your first recipe to see it here.",
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.white,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          } else {
            int savedRecipesLength = savedRecipes.length.clamp(0, 2); // Limit to 2 saved recipes
            print(savedRecipesLength);
            return Column(
              children: [
                SizedBox(
                  height: savedRecipesLength.toDouble() * 125,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: savedRecipesLength,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10);
                    },
                    itemBuilder: (context, index) {
                      final savedRecipe = savedRecipes![index];
                      final String dishName = savedRecipe['dishId']['dishName'];
                      final String dishImage = savedRecipe['dishId']['dishImage'];
                      final String dishRating = savedRecipe['rating'];
                      final String dishRatedTime = savedRecipe['recipeRated'];
                      final int dishRatings = 142;

                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 10, top: 10, bottom: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {});
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.transparent,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                minimumSize: Size.zero,
                                padding: const EdgeInsets.all(0),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 90,
                                    width: 90,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "http://192.168.68.105:8000/media/" + dishImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0, right: 0, top: 5, bottom: 5),
                                          child: Text(
                                            dishName,
                                            style: const TextStyle(
                                              fontFamily: 'Georgia',
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: CustomColors.white,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0, right: 0, top: 5, bottom: 5),
                                          child: Text(
                                            "rated ${formatTimeDifference(dishRatedTime)}",
                                            style: const TextStyle(
                                              fontFamily: 'Georgia',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: CustomColors.grey,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 45,
                                  width: 45,

                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: dishRating == "THUMBSUP"
                                        ? AssetImage('assets/general/ThumbsUp.png')
                                        : AssetImage('assets/general/ThumbsDown.png'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: Container(
                    width: width,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.lime, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'savedRecipes');
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.transparent,
                        backgroundColor: Colors.white10,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.all(0),
                      ),
                      child: const Text(
                        "See more",
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 20,
                          color: Colors.lime,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  String formatTimeDifference(String time) {
    final now = DateTime.now();
    final ratedTime = DateTime.parse(time);

    final difference = now.difference(ratedTime);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 365) {
      final months = difference.inDays ~/ 30;
      return '${months} ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = difference.inDays ~/ 365;
      return '${years} ${years == 1 ? 'year' : 'years'} ago';
    }
  }

// return SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       // Ratings
    //       Container(
    //         margin: const EdgeInsets.only(left: 0, right: 20, top: 20, bottom: 20),
    //         child: Column(
    //           children: [
    //             const Padding(
    //               padding: EdgeInsets.only(left: 20, bottom: 20),
    //               child: Row(
    //                 children: [
    //                   Text('My Ratings (5)',
    //                     style:  TextStyle(
    //                       fontFamily: 'Georgia',
    //                       fontSize: 22,
    //                       fontWeight: FontWeight.bold,
    //                       color: CustomColors.selfWhite,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             // const SizedBox(height: 20,),
    //
    //             Stack(
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
    //                   child: ElevatedButton(
    //                     onPressed: (){
    //                       setState(() {
    //                       });
    //                     },
    //
    //                     style: ElevatedButton.styleFrom(
    //                       foregroundColor: Colors.transparent,
    //                       backgroundColor: Colors.transparent,
    //                       elevation: 0,
    //                       shadowColor: Colors.transparent,
    //                       minimumSize: Size.zero,
    //                       padding: const EdgeInsets.all(0),
    //                     ),
    //
    //                     child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: [
    //                         SizedBox(
    //                           height: 80,
    //                           width: 80,
    //
    //                           child: ClipRRect(
    //                             borderRadius: BorderRadius.circular(10),
    //                             child: Image.asset(
    //                               'assets/demoassets/dish07.jpg',
    //                               fit: BoxFit.cover, // Adjust the image's fit as needed
    //                             ),
    //                           ),
    //                         ),
    //                         const SizedBox(width: 10,),
    //                         const Expanded(
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               Text('Gnocchi with Tomato Sauce and Mozzarella',
    //                                 style:  TextStyle(
    //                                   fontFamily: 'Georgia',
    //                                   fontSize: 15,
    //                                   fontWeight: FontWeight.bold,
    //                                   color: CustomColors.selfWhite,
    //                                 ),
    //                                 maxLines: 2,
    //                                 overflow: TextOverflow.ellipsis,
    //                               ),
    //                               SizedBox(height: 5,),
    //                               Text('rated 2 days ago',
    //                                 style:  TextStyle(
    //                                   fontFamily: 'Georgia',
    //                                   fontSize: 12,
    //                                   fontWeight: FontWeight.bold,
    //                                   color: CustomColors.selfGrey,
    //                                 ),
    //                                 maxLines: 2,
    //                                 overflow: TextOverflow.ellipsis,
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //
    //                 const Padding(
    //                   padding: EdgeInsets.only(left: 10),
    //                   child: Row(
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       SizedBox(
    //                         height: 40,
    //                         width: 40,
    //
    //                         child: CircleAvatar(
    //                           backgroundColor: Colors.transparent,
    //                           backgroundImage: AssetImage('assets/finalassets/ThumbsDown.png'),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //
    //             Stack(
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
    //                   child: ElevatedButton(
    //                     onPressed: (){
    //                       setState(() {
    //                       });
    //                     },
    //
    //                     style: ElevatedButton.styleFrom(
    //                       foregroundColor: Colors.transparent,
    //                       backgroundColor: Colors.transparent,
    //                       elevation: 0,
    //                       shadowColor: Colors.transparent,
    //                       minimumSize: Size.zero,
    //                       padding: const EdgeInsets.all(0),
    //                     ),
    //
    //                     child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: [
    //                         SizedBox(
    //                           height: 80,
    //                           width: 80,
    //
    //                           child: ClipRRect(
    //                             borderRadius: BorderRadius.circular(10),
    //                             child: Image.asset(
    //                               'assets/demoassets/dish08.jpg',
    //                               fit: BoxFit.cover, // Adjust the image's fit as needed
    //                             ),
    //                           ),
    //                         ),
    //                         const SizedBox(width: 10,),
    //                         const Expanded(
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               Text('Caprese Stuffed Portabello Mushrooms',
    //                                 style:  TextStyle(
    //                                   fontFamily: 'Georgia',
    //                                   fontSize: 15,
    //                                   fontWeight: FontWeight.bold,
    //                                   color: CustomColors.selfWhite,
    //                                 ),
    //                                 maxLines: 2,
    //                                 overflow: TextOverflow.ellipsis,
    //                               ),
    //                               SizedBox(height: 5,),
    //                               Text('rated 2 days ago',
    //                                 style:  TextStyle(
    //                                   fontFamily: 'Georgia',
    //                                   fontSize: 12,
    //                                   fontWeight: FontWeight.bold,
    //                                   color: CustomColors.selfGrey,
    //                                 ),
    //                                 maxLines: 2,
    //                                 overflow: TextOverflow.ellipsis,
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //
    //                 const Padding(
    //                   padding: EdgeInsets.only(left: 10),
    //                   child: Row(
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       SizedBox(
    //                         height: 40,
    //                         width: 40,
    //
    //                         child: CircleAvatar(
    //                           backgroundColor: Colors.transparent,
    //                           backgroundImage: AssetImage('assets/finalassets/ThumbsUp.png'),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //
    //             Stack(
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
    //                   child: ElevatedButton(
    //                     onPressed: (){
    //                       setState(() {
    //                       });
    //                     },
    //
    //                     style: ElevatedButton.styleFrom(
    //                       foregroundColor: Colors.transparent,
    //                       backgroundColor: Colors.transparent,
    //                       elevation: 0,
    //                       shadowColor: Colors.transparent,
    //                       minimumSize: Size.zero,
    //                       padding: const EdgeInsets.all(0),
    //                     ),
    //
    //                     child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: [
    //                         SizedBox(
    //                           height: 80,
    //                           width: 80,
    //
    //                           child: ClipRRect(
    //                             borderRadius: BorderRadius.circular(10),
    //                             child: Image.asset(
    //                               'assets/demoassets/dish10.jpg',
    //                               fit: BoxFit.cover, // Adjust the image's fit as needed
    //                             ),
    //                           ),
    //                         ),
    //                         const SizedBox(width: 10,),
    //                         const Expanded(
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               Text('Risotto with Mushroom and Parmesan',
    //                                 style:  TextStyle(
    //                                   fontFamily: 'Georgia',
    //                                   fontSize: 15,
    //                                   fontWeight: FontWeight.bold,
    //                                   color: CustomColors.selfWhite,
    //                                 ),
    //                                 maxLines: 2,
    //                                 overflow: TextOverflow.ellipsis,
    //                               ),
    //                               SizedBox(height: 5,),
    //                               Text('rated 2 weeks ago',
    //                                 style:  TextStyle(
    //                                   fontFamily: 'Georgia',
    //                                   fontSize: 12,
    //                                   fontWeight: FontWeight.bold,
    //                                   color: CustomColors.selfGrey,
    //                                 ),
    //                                 maxLines: 2,
    //                                 overflow: TextOverflow.ellipsis,
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //
    //                 const Padding(
    //                   padding: EdgeInsets.only(left: 10),
    //                   child: Row(
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       SizedBox(
    //                         height: 40,
    //                         width: 40,
    //
    //                         child: CircleAvatar(
    //                           backgroundColor: Colors.transparent,
    //                           backgroundImage: AssetImage('assets/finalassets/ThumbsUp.png'),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //
    //             Padding(
    //               padding: const EdgeInsets.only(left: 20, top: 10,),
    //               child: Container(
    //                 width: width,
    //                 height: 50,
    //
    //                 decoration: BoxDecoration(
    //                   border: Border.all(
    //                       color: Colors.lime,
    //                       width: 2
    //                   ), // Set the border color
    //                   borderRadius: BorderRadius.circular(10),
    //                   // Set the border radius
    //                 ),
    //
    //                 child: ElevatedButton(
    //                   onPressed: () {
    //                     Navigator.pushNamed(context, 'activityRatings');
    //                   },
    //
    //                   style: ElevatedButton.styleFrom(
    //                     foregroundColor: Colors.transparent,
    //                     backgroundColor: Colors.white10,
    //                     elevation: 0,
    //                     shadowColor: Colors.transparent,
    //                     minimumSize: Size.zero,
    //                     padding: const EdgeInsets.all(0),
    //                   ),
    //
    //                   child: const Text(
    //                     "See more",
    //                     style: TextStyle(
    //                       fontFamily: 'Georgia',
    //                       fontSize: 20,
    //                       color: Colors.lime,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //
    //       // Tips
    //       Container(
    //         margin: const EdgeInsets.only(left: 0, right: 20, top: 20, bottom: 20),
    //         child: Column(
    //           children: [
    //             const Padding(
    //               padding: EdgeInsets.only(left: 20, bottom: 20),
    //               child: const Row(
    //                 children: [
    //                   Text('My Tips (4)',
    //                     style:  TextStyle(
    //                       fontFamily: 'Georgia',
    //                       fontSize: 22,
    //                       fontWeight: FontWeight.bold,
    //                       color: CustomColors.selfWhite,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //
    //             Padding(
    //               padding: const EdgeInsets.only(left: 20, right: 0, top: 10, bottom: 10),
    //               child: Container(
    //
    //                 decoration: const BoxDecoration(
    //                   color: Colors.white12,
    //                   borderRadius: BorderRadius.all(Radius.circular(20)),
    //                 ),
    //
    //                 child: Column(
    //                   children: [
    //                     Padding(
    //                         padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
    //
    //                         child: Row(
    //                           children: [
    //                             Expanded(
    //                               child: Column(
    //                                 children: [
    //                                   const Text('I used brown sugar and red apples instead and it turned out great!!!',
    //                                     style:  TextStyle(
    //                                       fontFamily: 'Georgia',
    //                                       fontSize: 15,
    //                                       fontWeight: FontWeight.bold,
    //                                       color: CustomColors.selfWhite,
    //                                     ),
    //                                     maxLines: 2,
    //                                     overflow: TextOverflow.ellipsis,
    //                                   ),
    //                                   const SizedBox(height: 10,),
    //                                   const Row(
    //                                     mainAxisAlignment: MainAxisAlignment.start,
    //                                     children: [
    //                                       Icon(Icons.thumb_up_alt_outlined, color: CustomColors.selfGrey, size: 18,),
    //                                       SizedBox(width: 5,),
    //                                       Text('10',
    //                                         style:  TextStyle(
    //                                           fontFamily: 'Georgia',
    //                                           fontSize: 15,
    //                                           color: CustomColors.selfWhite,
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   const SizedBox(height: 20,),
    //                                   Row(
    //                                     mainAxisAlignment: MainAxisAlignment.start,
    //                                     children: [
    //                                       Text('Apple Pie',
    //                                         style:  TextStyle(
    //                                           fontFamily: 'Georgia',
    //                                           fontSize: 15,
    //                                           fontWeight: FontWeight.bold,
    //                                           color: Colors.amber[600],
    //                                         ),
    //                                         maxLines: 2,
    //                                         overflow: TextOverflow.ellipsis,
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   const SizedBox(height: 10,),
    //                                   const Row(
    //                                     mainAxisAlignment: MainAxisAlignment.start,
    //                                     children: [
    //                                       Text('added 4 months ago',
    //                                         style:  TextStyle(
    //                                           fontFamily: 'Georgia',
    //                                           fontSize: 12,
    //                                           color: CustomColors.selfGrey,
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   )
    //                                 ],
    //                               ),
    //                             ),
    //                             const SizedBox(width: 5,),
    //                             SizedBox(
    //                               height: 160,
    //                               width: 90,
    //                               child: ClipRRect(
    //                                 borderRadius: BorderRadius.circular(20),
    //                                 child: const Image(
    //                                   image: AssetImage('assets/demoassets/TipsImageDish1.jpg'),
    //                                   fit: BoxFit.fill,
    //                                 ),
    //                               ),
    //                             ),
    //                           ],
    //                         )
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //
    //             Padding(
    //               padding: const EdgeInsets.only(left: 20, right: 0, top: 10, bottom: 10),
    //               child: Container(
    //
    //                 decoration: const BoxDecoration(
    //                   color: Colors.white12,
    //                   borderRadius: BorderRadius.all(Radius.circular(20)),
    //                 ),
    //
    //                 child: Column(
    //                   children: [
    //                     Padding(
    //                       padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
    //
    //                       child: Column(
    //                         children: [
    //                           const Text('Added 3 tsp of butter and used welches white grape juice and vinegar as substitutes for white wine. Loved it!!!',
    //                             style:  TextStyle(
    //                               fontFamily: 'Georgia',
    //                               fontSize: 15,
    //                               fontWeight: FontWeight.bold,
    //                               color: CustomColors.selfWhite,
    //                             ),
    //                             maxLines: 2,
    //                             overflow: TextOverflow.ellipsis,
    //                           ),
    //                           const SizedBox(height: 10,),
    //                           const Row(
    //                             mainAxisAlignment: MainAxisAlignment.start,
    //                             children: [
    //                               Icon(Icons.thumb_up_alt_outlined, color: CustomColors.selfGrey, size: 18,),
    //                               SizedBox(width: 5,),
    //                               Text('15',
    //                                 style:  TextStyle(
    //                                   fontFamily: 'Georgia',
    //                                   fontSize: 15,
    //                                   color: CustomColors.selfWhite,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                           const SizedBox(height: 20,),
    //                           Row(
    //                             mainAxisAlignment: MainAxisAlignment.start,
    //                             children: [
    //                               Text('Garlic Shrimp Spaghetti',
    //                                 style:  TextStyle(
    //                                   fontFamily: 'Georgia',
    //                                   fontSize: 15,
    //                                   fontWeight: FontWeight.bold,
    //                                   color: Colors.amber[600],
    //                                 ),
    //                                 maxLines: 2,
    //                                 overflow: TextOverflow.ellipsis,
    //                               ),
    //                             ],
    //                           ),
    //                           const SizedBox(height: 10,),
    //                           const Row(
    //                             mainAxisAlignment: MainAxisAlignment.start,
    //                             children: [
    //                               Text('added 7 months ago',
    //                                 style:  TextStyle(
    //                                   fontFamily: 'Georgia',
    //                                   fontSize: 12,
    //                                   color: CustomColors.selfGrey,
    //                                 ),
    //                               ),
    //                             ],
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //
    //             Padding(
    //               padding: const EdgeInsets.only(left: 20, right: 0, top: 10, bottom: 10),
    //               child: Container(
    //
    //                 decoration: const BoxDecoration(
    //                   color: Colors.white12,
    //                   borderRadius: BorderRadius.all(Radius.circular(20)),
    //                 ),
    //
    //                 child: Column(
    //                   children: [
    //                     Padding(
    //                         padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
    //
    //                         child: Row(
    //                           children: [
    //                             Expanded(
    //                               child: Column(
    //                                 children: [
    //                                   const Text('Make sure to add enough mozzarella cheese to get that pull.',
    //                                     style:  TextStyle(
    //                                       fontFamily: 'Georgia',
    //                                       fontSize: 15,
    //                                       fontWeight: FontWeight.bold,
    //                                       color: CustomColors.selfWhite,
    //                                     ),
    //                                     maxLines: 2,
    //                                     overflow: TextOverflow.ellipsis,
    //                                   ),
    //                                   const SizedBox(height: 10,),
    //                                   const Row(
    //                                     mainAxisAlignment: MainAxisAlignment.start,
    //                                     children: [
    //                                       Icon(Icons.thumb_up_alt_outlined, color: CustomColors.selfGrey, size: 18,),
    //                                       SizedBox(width: 5,),
    //                                       Text('5',
    //                                         style:  TextStyle(
    //                                           fontFamily: 'Georgia',
    //                                           fontSize: 15,
    //                                           color: CustomColors.selfWhite,
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   const SizedBox(height: 20,),
    //                                   Text('Caprese Stuffed Portabello Mushrooms',
    //                                     style:  TextStyle(
    //                                       fontFamily: 'Georgia',
    //                                       fontSize: 15,
    //                                       fontWeight: FontWeight.bold,
    //                                       color: Colors.amber[600],
    //                                     ),
    //                                     maxLines: 2,
    //                                     overflow: TextOverflow.ellipsis,
    //                                   ),
    //                                   const SizedBox(height: 10,),
    //                                   const Row(
    //                                     mainAxisAlignment: MainAxisAlignment.start,
    //                                     children: [
    //                                       Text('added 7 months ago',
    //                                         style:  TextStyle(
    //                                           fontFamily: 'Georgia',
    //                                           fontSize: 12,
    //                                           color: CustomColors.selfGrey,
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   )
    //                                 ],
    //                               ),
    //                             ),
    //                             const SizedBox(width: 5,),
    //                             SizedBox(
    //                               height: 160,
    //                               width: 90,
    //                               child: ClipRRect(
    //                                 borderRadius: BorderRadius.circular(20),
    //                                 child: const Image(
    //                                   image: AssetImage('assets/demoassets/TipsImageDish2.jpg'),
    //                                   fit: BoxFit.fill,
    //                                 ),
    //                               ),
    //                             ),
    //                           ],
    //                         )
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //
    //             Padding(
    //               padding: const EdgeInsets.only(left: 20, top: 10,),
    //               child: Container(
    //                 width: width,
    //                 height: 50,
    //
    //                 decoration: BoxDecoration(
    //                   border: Border.all(
    //                       color: Colors.lime,
    //                       width: 2
    //                   ), // Set the border color
    //                   borderRadius: BorderRadius.circular(10),
    //                   // Set the border radius
    //                 ),
    //
    //                 child: ElevatedButton(
    //                   onPressed: () {
    //                     Navigator.pushNamed(context, 'activityTips');
    //                   },
    //
    //                   style: ElevatedButton.styleFrom(
    //                     foregroundColor: Colors.transparent,
    //                     backgroundColor: Colors.white10,
    //                     elevation: 0,
    //                     shadowColor: Colors.transparent,
    //                     minimumSize: Size.zero,
    //                     padding: const EdgeInsets.all(0),
    //                   ),
    //
    //                   child: const Text(
    //                     "See more",
    //                     style: TextStyle(
    //                       fontFamily: 'Georgia',
    //                       fontSize: 20,
    //                       color: Colors.lime,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //
    //       // recently Viewed
    //       Container(
    //         margin: const EdgeInsets.only(left: 0, right: 20, top: 20, bottom: 20),
    //         child: Column(
    //           children: [
    //             const Padding(
    //               padding: EdgeInsets.only(left: 20, bottom: 20),
    //               child: Row(
    //                 children: [
    //                   Text('Recently Viewed',
    //                     style:  TextStyle(
    //                       fontFamily: 'Georgia',
    //                       fontSize: 22,
    //                       fontWeight: FontWeight.bold,
    //                       color: CustomColors.selfWhite,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //
    //             Padding(
    //               padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
    //               child: SizedBox(
    //                 width: size.width,
    //                 height: size.width / 3 + 130,
    //                 child: ListView(
    //                   scrollDirection: Axis.horizontal,
    //
    //                   children: [
    //                     SizedBox(
    //                       width: size.width / 3 + 10,
    //
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Container(
    //                             width: size.width / 3,
    //                             height: size.width / 3,
    //                             child: ClipRRect(
    //                               borderRadius: BorderRadius.circular(20),
    //                               child: const Image(
    //                                 image: AssetImage('assets/demoassets/dish01.jpg'),
    //                                 fit: BoxFit.fill,
    //                               ),
    //                             ),
    //                           ),
    //                           const SizedBox(height: 10,),
    //                           const Text('BBQ Ribs with Coleslaw',
    //                             style:  TextStyle(
    //                                 fontFamily: 'Georgia',
    //                                 fontSize: 18,
    //                                 color: Colors.white
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     const SizedBox(width: 15,),
    //                     SizedBox(
    //                       width: size.width / 3 + 10,
    //
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Container(
    //                             width: size.width / 3,
    //                             height: size.width / 3,
    //                             child: ClipRRect(
    //                               borderRadius: BorderRadius.circular(20),
    //                               child: const Image(
    //                                 image: AssetImage('assets/demoassets/dish08.jpg'),
    //                                 fit: BoxFit.fill,
    //                               ),
    //                             ),
    //                           ),
    //                           const SizedBox(height: 10,),
    //                           const Text('Caprese stuffed Portabello Mushrooms',
    //                             style:  TextStyle(
    //                                 fontFamily: 'Georgia',
    //                                 fontSize: 18,
    //                                 color: Colors.white
    //                             ),
    //                           ),
    //                           const SizedBox(height: 10,),
    //                           const Row(
    //                             children: [
    //                               Icon(Icons.shopping_bag, color: Colors.tealAccent, size: 18,),
    //                               SizedBox(width: 10,),
    //                               Text('Affordable',
    //                                 style:  TextStyle(
    //                                   fontFamily: 'Georgia',
    //                                   fontSize: 15,
    //                                   color: Colors.tealAccent,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     const SizedBox(width: 15,),
    //                     SizedBox(
    //                       width: size.width / 3 + 10,
    //
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Container(
    //                             width: size.width / 3,
    //                             height: size.width / 3,
    //                             child: ClipRRect(
    //                               borderRadius: BorderRadius.circular(20),
    //                               child: const Image(
    //                                 image: AssetImage('assets/demoassets/dish09.jpg'),
    //                                 fit: BoxFit.fill,
    //                               ),
    //                             ),
    //                           ),
    //                           const SizedBox(height: 10,),
    //                           const Text('Palak Paneer',
    //                             style:  TextStyle(
    //                                 fontFamily: 'Georgia',
    //                                 fontSize: 18,
    //                                 color: Colors.white
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     const SizedBox(width: 15,),
    //                     SizedBox(
    //                       width: size.width / 3 + 10,
    //
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Container(
    //                             width: size.width / 3,
    //                             height: size.width / 3,
    //                             child: ClipRRect(
    //                               borderRadius: BorderRadius.circular(20),
    //                               child: const Image(
    //                                 image: AssetImage('assets/demoassets/dish10.jpg'),
    //                                 fit: BoxFit.fill,
    //                               ),
    //                             ),
    //                           ),
    //                           const SizedBox(height: 10,),
    //                           const Text('Risotto with Mushroom and Parmesan',
    //                             style:  TextStyle(
    //                                 fontFamily: 'Georgia',
    //                                 fontSize: 18,
    //                                 color: Colors.white
    //                             ),
    //                           ),
    //                           const SizedBox(height: 10,),
    //                           const Row(
    //                             children: [
    //                               Icon(Icons.shopping_bag, color: Colors.tealAccent, size: 18,),
    //                               SizedBox(width: 10,),
    //                               Text('Affordable',
    //                                 style:  TextStyle(
    //                                   fontFamily: 'Georgia',
    //                                   fontSize: 15,
    //                                   color: Colors.tealAccent,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     const SizedBox(width: 15,),
    //                     SizedBox(
    //                       width: size.width / 3 + 10,
    //
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Container(
    //                             width: size.width / 3,
    //                             height: size.width / 3,
    //                             child: ClipRRect(
    //                               borderRadius: BorderRadius.circular(20),
    //                               child: const Image(
    //                                 image: AssetImage('assets/demoassets/dish11.jpg'),
    //                                 fit: BoxFit.fill,
    //                               ),
    //                             ),
    //                           ),
    //                           const SizedBox(height: 10,),
    //                           const Text('Mutton Kheema',
    //                             style:  TextStyle(
    //                                 fontFamily: 'Georgia',
    //                                 fontSize: 18,
    //                                 color: Colors.white
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     const SizedBox(width: 15,),
    //                     SizedBox(
    //                       width: size.width / 3 + 10,
    //
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Container(
    //                             width: size.width / 3,
    //                             height: size.width / 3,
    //                             child: ClipRRect(
    //                               borderRadius: BorderRadius.circular(20),
    //                               child: const Image(
    //                                 image: AssetImage('assets/demoassets/dish12.jpg'),
    //                                 fit: BoxFit.fill,
    //                               ),
    //                             ),
    //                           ),
    //                           const SizedBox(height: 10,),
    //                           const Text('Fried Chicken with Mashed Potatoes and Gravy',
    //                             style:  TextStyle(
    //                                 fontFamily: 'Georgia',
    //                                 fontSize: 18,
    //                                 color: Colors.white
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     const SizedBox(width: 15,),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //
    //       const SizedBox(height: 100,),
    //     ],
    //   ),
    // );
}
