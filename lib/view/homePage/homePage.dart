import 'package:animate_gradient/animate_gradient.dart';
import 'package:chefs_hat/constants/colors/Colors.dart';
import 'package:chefs_hat/controller/graphQL/queries/queries.dart';
import 'package:chefs_hat/model/homepage/homepageTile.dart';
import 'package:chefs_hat/view/authentication/otpVerification.dart';
import 'package:chefs_hat/controller/entryPoint/entryPoint.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../constants/homepagePhotos.dart';
import '../../controller/graphQL/graphQLClient.dart';
import '../../controller/registration/registration.dart';
import '../../utils/sharedPreferences.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  static String dishId = "";
  static String dishCourse = "";

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  Future<void> _loadUserId() async {
    final int? storedUserId = await SharedPreferencesUtil.getInt('userId');
    print("Homepage ${storedUserId}");
    setState(() {
      UserFormFields.userId = storedUserId ?? 0;
    });
  }

  final ScrollController _scrollController1 = ScrollController();

  @override
  void initState() {
    _loadUserId();

    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      double maxScrollExtent1 = _scrollController1.position.maxScrollExtent;
      double minScrollExtent1 = _scrollController1.position.minScrollExtent;

      animateToMaxMin(
        maxScrollExtent1,
        minScrollExtent1,
        1,
        10,
        _scrollController1,
      );
    });
  }

  void animateToMaxMin(
    double max,
    double min,
    double direction,
    int seconds,
    ScrollController scrollController,
  ) async {
    while (true) {
      await Future.delayed(Duration(seconds: seconds));
      scrollController.animateTo(
        direction == 1 ? max : min,
        duration: Duration(seconds: seconds),
        curve: Curves.linear,
      );
      direction = 1 - direction; // Toggle between 0 and 1 to change direction
    }
  }

  final List<String> listImages1 = [
    'assets/general/1.png',
    'assets/general/2.png',
    'assets/general/3.png',
  ];

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

    final String userId = UserFormFields.userId.toString();
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
            GraphQLProvider(
              client: client,
              child: _buildUserProfileNameImage(width),
            ),

            const Divider(
              color: Colors.white,
              thickness: 0.3,
            ),
            // What are we loving now
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 20,
            //     right: 20,
            //     top: 50,
            //     bottom: 0,
            //   ),
            //   child: _buildSectionHeader("What are we loving now"),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 20,
            //     right: 20,
            //     top: 0,
            //     bottom: 20,
            //   ),
            //   child: GraphQLProvider(
            //     client: client,
            //     child: _buildLastDishView(width),
            //   ),
            // ),

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
                top: 10,
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
                top: 10,
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
                top: 10,
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
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 100, bottom: 20),
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
              padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 60),
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

            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 0,
                bottom: 60,
              ),
              child: homepageTile(
                scrollController: _scrollController1,
                images: listImages,
              ),
            ),

            // List
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 0, top: 0, bottom: 0),
              child: Row(
                children: [
                  Text(
                    'Recent',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            GraphQLProvider(
              client: client,
              child: _buildDishes(width, height),
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

          return SizedBox(
            width: width,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 40, bottom: 5),
              child: Row(
                children: [
                  Text(
                    "Welcome, ",
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    "${data['username']}",
                    style: GoogleFonts.playfairDisplay(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold),
                  ),
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0, right: 0, top: 0, bottom: 0),
                    child: Center(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1)),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(
                              httpLinkImage + data['profilePhoto']),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDishListViewTrending(double width) {
    return SizedBox(
      height: 190,
      child: Query(
        options: QueryOptions(
          document: gql(Homepage.getDishTrending),
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
          document: gql(Homepage.getDishesQuery),
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
          document: gql(Uploads.getAllUserUploads),
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
            itemCount: savedRecipes.length > 5
                ? 5
                : savedRecipes
                    .length, // Use the length of the saved recipes list
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
          document: gql(Homepage.getDishAddedLastWeek),
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

  Widget _buildDishes(double width, double height) {
    return Query(
      options: QueryOptions(
        document: gql(Homepage.getDishesQuery),
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

        final List<dynamic>? dishes = result.data?['displayDish'];

        if (dishes == null || dishes.isEmpty) {
          return const Text('No dishes found');
        }

        return GridView.builder(
          itemCount: dishes.length,
          shrinkWrap: true, // Added this
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.72, // Adjust this value
          ),
          itemBuilder: (BuildContext context, int index) {
            final dish = dishes[index];

            final String dishName = dish['dishName'];
            final String dishImage = dish['dishImage'];
            final String dishTotalTime = dish['dishTotalTime'];

            return ElevatedButton(
              onPressed: () {
                setState(() {
                  print(dish['id']);
                  homePage.dishId = dish['id'];
                  print('Value set');
                });
                Navigator.pushNamed(context, 'dishDescription');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onPrimary: Colors.transparent,
                onSurface: Colors.transparent,
                elevation: 0,
                shadowColor: Colors.transparent,
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(0),
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: width / 4),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: (width / 2) - 54,
                                      child: Text(
                                        dishName,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: 'Georgia'),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.timelapse_rounded,
                                    color: Colors.lime,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    dishTotalTime,
                                    style: const TextStyle(
                                        color: Colors.lime,
                                        fontSize: 15,
                                        fontFamily: 'Georgia'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Column(
                        children: [
                          Container(
                            height: 140,
                            width: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: ClipOval(
                              child: Image(
                                image: NetworkImage(
                                  httpLinkImage + dishImage,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
