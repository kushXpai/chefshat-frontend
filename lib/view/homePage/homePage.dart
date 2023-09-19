import 'package:animate_gradient/animate_gradient.dart';
import 'package:chefs_hat/constants/colors/Colors.dart';
import 'package:chefs_hat/controller/graphQL/queries/queries.dart';
import 'package:chefs_hat/view/authentication/otpVerification.dart';
import 'package:chefs_hat/controller/entryPoint/entryPoint.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../controller/graphQL/graphQLClient.dart';
import '../../controller/registration/registration.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  static String dishId = "";
  static String dishCourse = "";

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final String getDishesQuery = Dishes.getDishesQuery;

  final String getLastDishesQuery = Dishes.getLastDishesQuery;

  final String getDishAddedLastWeek = Dishes.getDishAddedLastWeek;

  final String getDishTrending = Dishes.getDishTrending;

  final String getAllUserUploads = Uploads.getAllUserUploads;


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

    final String userId = otpVerification.userId.toString();
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
      } else {
        print("Mutation result: ${result.data.toString()}");
      }
    } catch (e) {
      print("Mutation error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: CustomColors.backgroundBlack,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // What are we loving now
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 50,
                bottom: 0,
              ),
              child: _buildSectionHeader("What are we loving now"),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 0,
                bottom: 20,
              ),
              child: GraphQLProvider(
                client: client,
                child: _buildLastDishView(width),
              ),
            ),

            // Trending
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 0,
                bottom: 0,
              ),
              child: _buildSectionHeader('Trending'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 0,
                bottom: 10,
              ),
              child: GraphQLProvider(
                client: client,
                child: _buildDishListViewTrending(width),
              ),
            ),

            // Community
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 0,
                bottom: 0,
              ),
              child: _buildSectionHeader("What's our community cooking"),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 0,
                bottom: 10,
              ),
              child: GraphQLProvider(
                client: client,
                child: _buildDishListViewCommunity(width),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 0,
                bottom: 0,
              ),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    entryPointStatics.indexBottomNavigationBar == 2;
                  });
                  Navigator.pushNamed(context, "entryPoint");
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.all(0),
                ),
                child: const SizedBox(
                  child: Row(
                    children: [
                      Text(
                        "See more Community ",
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.lime,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.lime,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Recommended
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 0,
                bottom: 0,
              ),
              child: _buildSectionHeader('Recommended for you'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 0,
                bottom: 10,
              ),
              child: GraphQLProvider(
                client: client,
                child: _buildDishListViewRecommended(width),
              ),
            ),

            // This week
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 0,
                bottom: 0,
              ),
              child: _buildSectionHeader('Popular recipes this week'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 0,
                bottom: 10,
              ),
              child: GraphQLProvider(
                client: client,
                child: _buildDishListAddedLastWeek(width),
              ),
            ),

            // Footer
            const Padding(
              padding: EdgeInsets.only(
                  left: 20, right: 20, top: 100, bottom: 20),
              child: Text(
                "Unleash Your Culinary Creativity!",
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.textWhite,
                ),
                maxLines: 3,
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 100),
              child: Row(
                children: [
                  Text(
                    "Crafted with ",
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.favorite_sharp,
                    color: Colors.red,
                    size: 20,
                  ),
                  Text(
                    " in Mumbai, India",
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 20),
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

  Widget _buildLastDishView(double width) {
    return Query(
      options: QueryOptions(
        document: gql(getLastDishesQuery),
      ),
      builder: (QueryResult result, {fetchMore, refetch}) {
        if (result.hasException) {
          print(result.exception.toString());
          return Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: RotatedBox(
                    quarterTurns:
                        1, // Rotate 90 degrees clockwise (left to right)
                    child: AnimateGradient(
                      primaryColors: const [
                        Colors.black,
                        Colors.grey,
                        Colors.white,
                      ],
                      secondaryColors: const [
                        Colors.white,
                        Colors.grey,
                        Colors.black,
                      ],
                      duration: const Duration(milliseconds: 1500),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          height: width,
                          width: 337,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: RotatedBox(
                    quarterTurns:
                        1, // Rotate 90 degrees clockwise (left to right)
                    child: AnimateGradient(
                      primaryColors: const [
                        Colors.black,
                        Colors.grey,
                        Colors.white,
                      ],
                      secondaryColors: const [
                        Colors.white,
                        Colors.grey,
                        Colors.black,
                      ],
                      duration: const Duration(milliseconds: 1500),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          height: width,
                          width: 70,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (result.isLoading) {
          return Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: RotatedBox(
                    quarterTurns:
                        1, // Rotate 90 degrees clockwise (left to right)
                    child: AnimateGradient(
                      primaryColors: const [
                        Colors.black,
                        Colors.grey,
                        Colors.white,
                      ],
                      secondaryColors: const [
                        Colors.white,
                        Colors.grey,
                        Colors.black,
                      ],
                      duration: const Duration(milliseconds: 1500),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          height: width,
                          width: 337,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: RotatedBox(
                    quarterTurns:
                        1, // Rotate 90 degrees clockwise (left to right)
                    child: AnimateGradient(
                      primaryColors: const [
                        Colors.black,
                        Colors.grey,
                        Colors.white,
                      ],
                      secondaryColors: const [
                        Colors.white,
                        Colors.grey,
                        Colors.black,
                      ],
                      duration: const Duration(milliseconds: 1500),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          height: width,
                          width: 70,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        final Map<String, dynamic> data = result.data?['displayLastAddedDish'];

        if (data == null) {
          return const Text('No dishes found');
        }

        // final String id = data['id'];
        final String dishName = data['dishName'];

        return ElevatedButton(
          onPressed: () {
            setState(() {
              homePage.dishId = data['id'];
            });
            addToRecentlyViewed(context, data['id']);
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
            child: Container(
              width: width - 40,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: width - 40,
                    height: width - 40,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: Image(
                        image: NetworkImage(
                          httpLinkImage + data['dishImage'],
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 20,
                    ),
                    child: Text(
                      dishName,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontFamily: 'Georgia',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: CustomColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDishListViewTrending(double width) {
    return SizedBox(
      height: 190,
      child: Query(
        options: QueryOptions(
          document: gql(getDishTrending),
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            print(result.exception.toString());
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          if (result.isLoading) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                            child: SizedBox(
                              height: width / 3 - 60,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                            child: SizedBox(
                              height: width / 3 - 60,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          final List<dynamic> dishes =
              result.data?['displayDishesTrending'] ?? [];

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: dishes.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 10);
            },
            itemBuilder: (context, index) {
              final dish = dishes[index];
              return Mutation(
                options: MutationOptions(
                  document: gql('''
                    mutation UpdateDishVisits(\$id: ID!) {
                      increaseDishvisits(id: \$id) {
                        dish {
                          id
                          dishVisits
                        }
                      }
                    }
                  '''),
                  variables: {'id': dish['id']},
                ),
                builder:
                    (RunMutation runMutation, QueryResult? mutationResult) {
                  return ElevatedButton(
                    onPressed: () {
                      runMutation({'id': dish['id']});
                      setState(() {
                        homePage.dishId = dish['id'];
                        homePage.dishCourse = dish['dishCategoryCourse'];
                      });
                      addToRecentlyViewed(context, dish['id']);
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
                                  httpLinkImage + dish['dishImage'],
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
                              dish['dishName'],
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
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDishListViewRecommended(double width) {
    return SizedBox(
      height: 190,
      child: Query(
        options: QueryOptions(
          document: gql(getDishesQuery),
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            print(result.exception.toString());
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          if (result.isLoading) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                            child: SizedBox(
                              height: width / 3 - 60,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                            child: SizedBox(
                              height: width / 3 - 60,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          final List<dynamic> dishes = result.data?['displayDish'] ?? [];

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: dishes.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 10);
            },
            itemBuilder: (context, index) {
              final dish = dishes[index];
              return Mutation(
                options: MutationOptions(
                  document: gql('''
                    mutation UpdateDishVisits(\$id: ID!) {
                      increaseDishvisits(id: \$id) {
                        dish {
                          id
                          dishVisits
                        }
                      }
                    }
                  '''),
                  variables: {'id': dish['id']},
                ),
                builder:
                    (RunMutation runMutation, QueryResult? mutationResult) {
                  return ElevatedButton(
                    onPressed: () {
                      runMutation({'id': dish['id']});
                      setState(() {
                        homePage.dishId = dish['id'];
                        homePage.dishCourse = dish['dishCategoryCourse'];
                      });
                      addToRecentlyViewed(context, dish['id']);
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
                                  httpLinkImage + dish['dishImage'],
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
                              dish['dishName'],
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
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDishListViewCommunity(double width) {
    return SizedBox(
      height: 250,
      child: Query(
        options: QueryOptions(
          document: gql(getAllUserUploads),
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            print(result.exception.toString());
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          if (result.isLoading) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                            child: SizedBox(
                              height: width / 3 - 60,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                            child: SizedBox(
                              height: width / 3 - 60,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          final List<dynamic> savedRecipes =
              result.data?['displayUserUpload'] ?? [];

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // Use the length of the saved recipes list
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              final savedRecipe = savedRecipes[index];

              // Accessing the details of the dish
              final String username = savedRecipe['userId']['username'];
              final String userImage =
                  savedRecipe['userId']['profilePhoto'] ?? "";
              final String uploadName = savedRecipe['uploadName'];
              final String uploadImage = savedRecipe['uploadImage'];
              final String uploadDescription = savedRecipe['uploadDescription'];

              return Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 20, top: 0, bottom: 0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'community');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.all(0),
                  ),
                  child: Container(
                    width: width / 1.8,
                    decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width / 1.8,
                          height: width / 2.5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image(
                              image: NetworkImage(
                                httpLinkImage + uploadImage,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 0, top: 20, bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 1)),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      NetworkImage(httpLinkImage + userImage),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 0, top: 0, bottom: 0),
                                child: SizedBox(
                                  width: 155,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 14,
                                            color: Colors.amber[600],
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(text: '$username '),
                                            const TextSpan(
                                                text: 'cooked',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '$uploadName',
                                        style: TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 14,
                                            color: Colors.amber[600]),
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDishListAddedLastWeek(double width) {
    return SizedBox(
      height: 190,
      child: Query(
        options: QueryOptions(
          document: gql(getDishAddedLastWeek),
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            print(result.exception.toString());
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3 - 27,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          if (result.isLoading) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: width / 3,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                            child: SizedBox(
                              height: width / 3 - 60,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate 90 degrees clockwise (left to right)
                        child: AnimateGradient(
                          primaryColors: const [
                            Colors.black,
                            Colors.grey,
                            Colors.white,
                          ],
                          secondaryColors: const [
                            Colors.white,
                            Colors.grey,
                            Colors.black,
                          ],
                          duration: const Duration(milliseconds: 1500),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                            child: SizedBox(
                              height: width / 3 - 60,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          final List<dynamic> dishes =
              result.data?['displayDishesAddedLastWeek'] ?? [];

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: dishes.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 10);
            },
            itemBuilder: (context, index) {
              final dish = dishes[index];
              return Mutation(
                options: MutationOptions(
                  document: gql('''
                    mutation UpdateDishVisits(\$id: ID!) {
                      increaseDishvisits(id: \$id) {
                        dish {
                          id
                          dishVisits
                        }
                      }
                    }
                  '''),
                  variables: {'id': dish['id']},
                ),
                builder:
                    (RunMutation runMutation, QueryResult? mutationResult) {
                  return ElevatedButton(
                    onPressed: () {
                      runMutation({'id': dish['id']});
                      setState(() {
                        homePage.dishId = dish['id'];
                        homePage.dishCourse = dish['dishCategoryCourse'];
                      });
                      addToRecentlyViewed(context, dish['id']);
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
                                  httpLinkImage + dish['dishImage'],
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
                              dish['dishName'],
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
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
