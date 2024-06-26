import 'package:chefs_hat/controller/graphQL/queries/queries.dart';
import 'package:chefs_hat/view/authentication/otpVerification.dart';
import 'package:chefs_hat/view/homePage/homePage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../constants/colors/Colors.dart';
import '../../../controller/graphQL/graphQLClient.dart';
import '../../../controller/registration/registration.dart';

// import 'constants.dart';

class activity extends StatefulWidget {
  const activity({Key? key}) : super(key: key);

  static int tipsLength = 0;

  @override
  State<activity> createState() => _activityState();
}

class _activityState extends State<activity> {
  void addToRecentlyViewed(BuildContext context, String dishId) async {
    final String addRecipeMutation = """
    mutation AddRecipeToRecentlyViewed(\$userId: ID!, \$dishId: ID!) {
      addRecipeToRecentlyViewed(userId: \$userId, dishId: \$dishId) {
        recentlyViewed {
          id
          userId {
            id
            username
          }
          dishId {
            id
            dishName
          }
        }
      }
    }
  """;

    print("Entered Recentlt viewed");
    // Define variables for the mutation (assuming you have the user ID)
    final String userId =
        UserFormFields.userId.toString(); // Replace with the actual user ID
    final Map<String, dynamic> variables = {
      'userId': userId,
      'dishId': dishId,
    };

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink, // Replace with your GraphQL API endpoint
    );

    final MutationOptions options = MutationOptions(
      document: gql(addRecipeMutation),
      variables: variables,
    );

    try {
      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        print("Mutation error: ${result.exception.toString()}");
        // Handle the error here, e.g., show a snackbar or display an error message.
      } else {
        print("Mutation result: ${result.data.toString()}");
        // Mutation was successful, you can perform any necessary UI updates here.
      }
    } catch (e) {
      print("Mutation error: $e");
      // Handle exceptions that occur during the mutation.
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      height: height * 0.62,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 0,
                top: 0,
                bottom: 0,
              ),
              child: _buildSectionHeader("My Ratings"),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 0,
                bottom: 0,
              ),
              child: GraphQLProvider(
                client: client,
                child: _buildUserRatedRecipe(width),
              ),
            ),
          ),
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.only(
          //       left: 20,
          //       right: 0,
          //       top: 20,
          //       bottom: 0,
          //     ),
          //     child: _buildSectionHeader("My Tips"),
          //   ),
          // ),
          // SliverToBoxAdapter(
          //   child: GraphQLProvider(
          //     client: client,
          //     child: _buildUserTips(width),
          //   ),
          // ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 0,
                top: 20,
                bottom: 0,
              ),
              child: _buildSectionHeader("Recently Viewed"),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 0,
                bottom: 0,
              ),
              child: GraphQLProvider(
                client: client,
                child: _buildUserRecentlyViewed(width),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 75,
            ),
          )
        ],
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

  Widget _buildUserRatedRecipe(double width) {
    return SizedBox(
      child: Query(
        options: QueryOptions(
          document: gql(RatedRecipes.getRatedRecipes),
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

          final List<dynamic>? savedRecipes =
              result.data?['displayUserRatedRecipeById'];

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
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
                  child: Text(
                    "Rate your first recipe to see it here.",
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          } else {
            int savedRecipesLength = savedRecipes.length.clamp(0, 3); // Limit to 2 saved recipes
            return Column(
              children: [
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: savedRecipesLength,
                  shrinkWrap: true, // Added this
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    final savedRecipe = savedRecipes![index];
                    final String dishName = savedRecipe['dishId']['dishName'];
                    final String dishImage =
                        savedRecipe['dishId']['dishImage'];
                    final String dishRating = savedRecipe['rating'];
                    final String dishRecipeRated = savedRecipe['recipeRated'];

                    // rated ${formatTimeDifference(dishRatedTime)}
                    return Stack(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              homePage.dishId = savedRecipe['dishId']["id"];
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
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 0, top: 10, bottom: 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 90,
                                  width: 90,

                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      httpLinkImage + dishImage,
                                      fit: BoxFit.cover, // Adjust the image's fit as needed
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
                                        child: Text(
                                          dishName,
                                          style:  const TextStyle(
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
                                        padding: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
                                        child: Text(
                                          '${formatTimeDifference(dishRecipeRated)}',
                                          style:  const TextStyle(
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: dishRating == "THUMBSUP"
                                    ? const AssetImage(
                                        'assets/general/ThumbsUp.png')
                                    : const AssetImage(
                                        'assets/general/ThumbsDown.png'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: Container(
                    width: width,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.lime, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'ratedRecipes');
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

  Widget _buildUserTips(double width) {
    return Query(
      options: QueryOptions(
        document: gql(Tips.getTips),
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

        final List<dynamic>? tips = result.data?['displayUserTipById'];

        if (tips == null || tips.isEmpty) {
          return Column(
            children: [
              Container(
                height: 120,
                width: width,
                child: Image.asset(
                  'assets/profilePagePhotos/tips.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
                child: Text(
                  "Leave your first tip to see it here.",
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        } else {
          activity.tipsLength = tips.length.clamp(0, 2);
          return Column(
            children: [
              ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: activity.tipsLength,
                shrinkWrap: true, // Added this
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  final tip = tips![index];
                  final String dishName = tip['dishId']['dishName'];
                  final String dishImage = tip['userTipImage'];
                  final String dishTipDescription = tip['tipDescription'];
                  final String dishTipTime = tip['recipeTiped'];

                  return Container(
                    width: width - 20,
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, top: 0, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      border: Border.all(color: Colors.transparent, width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        dishTipDescription,
                                        style: const TextStyle(
                                          fontFamily: 'Georgia',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.thumb_up_alt_outlined,
                                            color: CustomColors.grey,
                                            size: 18,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '10',
                                            style: TextStyle(
                                              fontFamily: 'Georgia',
                                              fontSize: 15,
                                              color: CustomColors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 250,
                                            child: Text(
                                              dishName,
                                              style: TextStyle(
                                                fontFamily: 'Georgia',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.amber[600],
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'added ${formatTimeDifference(dishTipTime)}',
                                            style: const TextStyle(
                                              fontFamily: 'Georgia',
                                              fontSize: 12,
                                              color: CustomColors.grey,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  height: 160,
                                  width: 90,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image(
                                      image:
                                          NetworkImage(httpLinkImage + dishImage),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 10),
                child: Container(
                  width: width,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.lime, width: 2),
                    borderRadius: BorderRadius.circular(10),
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
    );
  }

  Widget _buildUserRecentlyViewed(double width) {
    return SizedBox(
      child: Query(
        options: QueryOptions(
          document: gql(RecentlyViewedRecipes.getRecentlyViewedRecipes),
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

          final List<dynamic>? savedRecipes =
              result.data?['displayUserRecentlyViewed'];

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
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
                  child: Text(
                    "You haven't viewed any recipes yet.",
                    style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.white),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          } else {
            int savedRecipesLength =
                savedRecipes.length.clamp(0, 5); // Limit to 2 saved recipes
            print(savedRecipesLength);
            return SizedBox(
              height: 210,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: savedRecipesLength,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  final savedRecipe = savedRecipes![index];
                  final String dishName = savedRecipe['dishId']['dishName'];
                  final String dishImage = savedRecipe['dishId']['dishImage'];

                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 0, right: 0, top: 0, bottom: 0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          homePage.dishId = savedRecipe['dishId']["id"];
                        });
                        addToRecentlyViewed(context, homePage.dishId);
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
                      child: SizedBox(
                        width: width / 3 + 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width / 3,
                              height: width / 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image(
                                  image: NetworkImage(
                                    httpLinkImage + dishImage,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 0,
                                right: 0,
                                top: 10,
                                bottom: 0,
                              ),
                              child: Text(
                                dishName,
                                style: const TextStyle(
                                  fontFamily: 'Georgia',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
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
