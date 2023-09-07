import 'package:flutter/material.dart';
import 'package:chefs_hat/view/authentication/otpVerification.dart';
import 'package:chefs_hat/view/homePage/homePage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../constants/colors/customColors.dart';
import '../../../controller/graphQL/graphQLClient.dart';

class ratedRecipes extends StatefulWidget {
  const ratedRecipes({Key? key}) : super(key: key);

  @override
  State<ratedRecipes> createState() => _ratedRecipesState();
}

class _ratedRecipesState extends State<ratedRecipes> {
  final String getRatedRecipe = '''
    query {
      displayUserRatedRecipeById(userId: ${otpVerification.userId}) {
        id
        userId{
          username
        }
        dishId{
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

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: _buildSectionHeader("My Ratings"),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(
                  left: 0, right: 0, top: 20, bottom: 0),
              child: GraphQLProvider(
                client: client,
                child: _buildUserSavedRecipe(width),
              ),
            ),
          ],
        )
      ),
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

  Widget _buildUserSavedRecipe(double width) {
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

          final List<dynamic> savedRecipes =
              result.data?['displayUserRatedRecipeById'];

          if (savedRecipes.isEmpty) {
            return Column(
              children: [
                Container(
                    height: 120,
                    width: width,
                    child: Image.asset(
                      'assets/profilePagePhotos/savedRecipes.png',
                      fit: BoxFit.fitWidth,
                    )),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
                  child: Text(
                    "You haven't liked any recipes yet. When you do they'll appear here.",
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
            return Column(
              children: [
                SizedBox(
                  height: 795,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: savedRecipes.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10);
                    },
                    itemBuilder: (context, index) {
                      final savedRecipe = savedRecipes[index];

                      final String dishName = savedRecipe['dishId']['dishName'] ?? "";
                      final String dishImage = savedRecipe['dishId']['dishImage'] ?? "";
                      final String dishRating = savedRecipe['rating'] ?? "";
                      final String dishRated = savedRecipe['recipeRated'];

                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 10, top: 10, bottom: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  homePage.dishId = savedRecipe['id'];
                                });
                                Navigator.pushNamed(context, 'dishDescription');
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
                                    height: width / 3 - 10,
                                    width: width / 3 - 10,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        httpLinkImage + dishImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0,
                                              right: 0,
                                              top: 5,
                                              bottom: 5),
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
                                              left: 0,
                                              right: 0,
                                              top: 5,
                                              bottom: 5),
                                          child: Text(
                                            'rated ${formatTimeDifference(dishRated)}',
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
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: dishRating == "THUMBSUP"
                                          ? const AssetImage(
                                              'assets/general/ThumbsUp.png')
                                          : const AssetImage(
                                              'assets/general/ThumbsDown.png')),
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
                      border: Border.all(
                          color: Colors.lime, width: 2), // Set the border color
                      borderRadius: BorderRadius.circular(10),
                      // Set the border radius
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
}
