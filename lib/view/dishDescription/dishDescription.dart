import 'dart:ui';

import 'package:chefs_hat/controller/graphQL/queries/queries.dart';
import 'package:chefs_hat/view/authentication/otpVerification.dart';
import 'package:chefs_hat/view/homePage/homePage.dart';
import 'package:customizable_counter/customizable_counter.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:like_button/like_button.dart';

import '../../constants/colors/Colors.dart';
import '../../controller/graphQL/graphQLClient.dart';
import '../../controller/registration/registration.dart';

class dishDescription extends StatefulWidget {
  const dishDescription({Key? key}) : super(key: key);

  static String rating = "";

  @override
  State<dishDescription> createState() => _dishDescriptionState();
}

class _dishDescriptionState extends State<dishDescription> {

  void addToRecentlyViewed(BuildContext context, String dishId) async {
    print("Recently viewed Dish\n\n\n");
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
  void initState() {
    addToRecentlyViewed(context, homePage.dishId);

    super.initState();
  }

  List<int> selectedIngredientIndices = [];

  bool added = false;
  Icon addedIcon = const Icon(
    Icons.add_circle,
    color: Colors.lime,
  );

  double _width1 = 392;
  double _height1 = 15;
  double _width2 = 392;
  double _height2 = 15 + 65;
  double _width3 = 392;
  double _height3 = 15 + 65 + 65;

  bool ext1 = false;
  Icon ext1icon = const Icon(
    Icons.arrow_drop_down_rounded,
    color: Colors.white,
    size: 30,
  );
  bool ext2 = false;
  Icon ext2icon = const Icon(
    Icons.arrow_drop_down_rounded,
    color: Colors.white,
    size: 30,
  );
  bool ext3 = false;
  Icon ext3icon = const Icon(
    Icons.arrow_drop_down_rounded,
    color: Colors.white,
    size: 30,
  );

  bool _isShowExt1 = false;
  bool _isShowExt2 = false;
  bool _isShowExt3 = false;

  double opacityext1 = 1;
  double opacityext2 = 1;
  double opacityext3 = 1;

  double serves = 2;

  bool isLiked = false;


  void toggleLike() async {
    setState(() {
      isLiked = !isLiked;
    });

    final userId = UserFormFields.userId;
    final dishId = homePage.dishId;
    final userSavedRecipeCategory = homePage.dishCourse;

    final GraphQLClient _client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );

    try {
      if (isLiked) {
        print("CREATE");
        final response = await _client.mutate(
          MutationOptions(
            document: gql(DishDescription.addRecipeToSavedRecipesMutation),
            variables: {
              'userId': userId,
              'dishId': dishId,
              'userSavedRecipeCategory': userSavedRecipeCategory
            },
          ),
        );
        print(response);
      } else {
        print("DELETE");
        final response = await _client.mutate(
          MutationOptions(
            document: gql(DishDescription.removeRecipeFromSavedRecipesMutation),
            variables: {'userId': userId, 'dishId': dishId},
          ),
        );
        print(response);
      }
    } catch (e) {
      print("Mutation Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: CustomColors.black,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
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
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
          child: Stack(
            children: [
              GraphQLProvider(
                client: client,
                child: _buildDishByIdImage(width),
              ),
              GraphQLProvider(
                client: client,
                child: _buildDishByIdDescription(width),
              ),
              GraphQLProvider(
                client: client,
                child: _buildDishByIdNutritionalFacts(width),
              ),
              GraphQLProvider(
                client: client,
                child: _buildDishByIdIngredients(width),
              ),
              GraphQLProvider(
                client: client,
                child: _buildDishByIdDirections(width),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 289, right: 0, top: 253, bottom: 0),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      toggleLike();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lime,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      padding: const EdgeInsets.all(0),
                    ),
                    child: LikeButton(
                      onTap: (bool isLiked) async {
                        toggleLike();
                      },
                      isLiked:
                          isLiked, // Replace 'isLiked' with your own variable that represents the liked state
                      size: 40,
                      animationDuration: const Duration(milliseconds: 900),
                      bubblesColor: const BubblesColor(
                        dotPrimaryColor: Color.fromARGB(255, 255, 255, 0),
                        dotSecondaryColor: Color.fromARGB(255, 255, 255, 255),
                      ),
                      likeBuilder: (bool isLiked) {
                        if (isLiked) {
                          return const Icon(
                            Icons.favorite,
                            size: 40,
                            color: Color.fromARGB(255, 255, 255, 215),
                          );
                        } else {
                          return const Icon(
                            Icons.favorite_outline,
                            size: 40,
                            color: Color.fromARGB(255, 255, 255, 255),
                          );
                        }
                      },
                      circleColor: const CircleColor(
                        start: Color.fromARGB(255, 255, 255, 255),
                        end: Color.fromARGB(255, 255, 255, 0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildDishByIdImage(double width) {
    return Query(
      options: QueryOptions(
        document: gql(DishDescription.getDishById),
        variables: {
          'id': '${homePage.dishId}',
        },
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

        final Map<String, dynamic> data = result.data?['displayDishById'];

        if (data == null) {
          return const Text('No dishes found');
        }

        final String dishImage = data['dishImage'];

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width,
                  height: width,
                  child: Image(
                    image: NetworkImage(
                      httpLinkImage + dishImage,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildDishByIdDescription(double width) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: width,
            height: 587.72,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            child: Column(
              children: [
                Container(
                  width: width,
                  height: 587.72,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40)),
                  ),
                  child: Query(
                    options: QueryOptions(
                      document: gql(DishDescription.getDishById),
                      variables: {
                        'id': '${homePage.dishId}',
                      },
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

                      final Map<String, dynamic> data =
                          result.data?['displayDishById'];

                      if (data == null) {
                        return const Text('No dishes found');
                      }

                      return Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: width - 40,
                                  child: Text(
                                    data['dishName'],
                                    style: const TextStyle(
                                      fontFamily: 'Georgia',
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  // width: (CustomSizes.width - 40) / 3,
                                  height: 42,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 9, right: 9),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              data['dishRating'],
                                              style: const TextStyle(
                                                fontFamily: 'Georgia',
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  // width: (CustomSizes.width - 40) / 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomizableCounter(
                                        showButtonText: false,
                                        borderColor: Colors.white,
                                        borderWidth: 0.5,
                                        borderRadius: 15,
                                        backgroundColor: Colors.transparent,
                                        buttonText: "Add Item",
                                        textColor: Colors.white,
                                        textSize: 15,
                                        count: 2,
                                        step: 1,
                                        minCount: 1,
                                        maxCount: 30,
                                        incrementIcon: const Icon(
                                          Icons.add,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                        decrementIcon: const Icon(
                                          Icons.remove,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                        onDecrement: (value) {
                                          setState(() {
                                            serves = value;
                                          });
                                          // ScaffoldMessenger.of(context).showSnackBar(
                                          //   SnackBar(
                                          //     content: Text("Value Decremented: $value"),
                                          //     duration: const Duration(milliseconds: 250),
                                          //   ),
                                          // );
                                        },
                                        onIncrement: (value) {
                                          setState(() {
                                            serves = value;
                                          });
                                          // ScaffoldMessenger.of(context).showSnackBar(
                                          //   SnackBar(
                                          //     content: Text("Value Incremented: $value"),
                                          //     duration: const Duration(milliseconds: 250),
                                          //   ),
                                          // );
                                        },
                                        onCountChange: (value) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  "Dish serves: ${(value).toInt()} people"),
                                              duration: const Duration(
                                                  milliseconds: 500),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                  height: 42,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 9, right: 9),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 255, 130, 0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                        ),
                                        padding: const EdgeInsets.all(0),
                                      ),
                                      child: Text(
                                        '${data['dishCalories']} kcal',
                                        style: const TextStyle(
                                          fontFamily: 'Georgia',
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Expanded(
                                child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width - 40,
                                        height: 165,
                                        child: Text(
                                          data['dishDescription'],
                                          style: const TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                          maxLines: 15,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDishByIdNutritionalFacts(double width) {
    return SizedBox(
        child: Opacity(
      opacity: opacityext3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedContainer(
            width: _width3,
            height: _height3 + 58,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(24, 24, 24, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            // Define how long the animation should take.
            duration: const Duration(seconds: 1),
            // Provide an optional curve to make the animation feel smoother.
            curve: Curves.fastOutSlowIn,

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 25, top: 10, bottom: 0),
                  child: SizedBox(
                    width: width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (ext3 == false) {
                          setState(() {
                            ext3 = true;
                            ext3icon = const Icon(
                              Icons.arrow_drop_up_rounded,
                              color: Colors.white,
                              size: 30,
                            );
                            opacityext1 = 0;
                            opacityext2 = 0;
                          });
                        } else {
                          setState(() {
                            ext3 = false;
                            ext2icon = const Icon(
                              Icons.arrow_drop_down_rounded,
                              color: Colors.white,
                              size: 30,
                            );
                            opacityext1 = 1;
                            opacityext2 = 1;
                          });
                        }
                        setState(() {
                          if (ext3 == true) {
                            _width3 = width;
                            _height3 = 530;
                            _isShowExt3 = !_isShowExt3;
                          } else {
                            _width3 = width;
                            _height3 = 145;
                            _isShowExt3 = !_isShowExt3;
                          }
                        });
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
                        children: [
                          const Text(
                            'Nutritional Facts',
                            style: TextStyle(
                              fontFamily: 'Georgia',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Expanded(child: SizedBox()),
                          ext3icon,
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Visibility(
                    visible: _isShowExt3,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 10),
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10),
                            child: Query(
                              options: QueryOptions(
                                document: gql(DishDescription.getDishById),
                                variables: {
                                  'id': '${homePage.dishId}',
                                },
                              ),
                              builder: (QueryResult result,
                                  {fetchMore, refetch}) {
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

                                final Map<String, dynamic> data =
                                    result.data?['displayDishById'];

                                if (data == null) {
                                  return const Text('No dishes found');
                                }

                                return Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Calories',
                                          style: TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Expanded(
                                            child: SizedBox(
                                          child: Text(
                                            '....................................................................',
                                            style: TextStyle(
                                              fontFamily: 'Georgia',
                                              fontSize: 20,
                                              color: Colors.grey,
                                            ),
                                            maxLines: 1,
                                          ),
                                        )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${data['dishCalories']} kcal',
                                          style: const TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 20,
                                            color: Colors.amber,
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
                                        const Text(
                                          'Proteins',
                                          style: TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Expanded(
                                            child: SizedBox(
                                          child: Text(
                                            '....................................................................',
                                            style: TextStyle(
                                              fontFamily: 'Georgia',
                                              fontSize: 20,
                                              color: Colors.grey,
                                            ),
                                            maxLines: 1,
                                          ),
                                        )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${data['dishProteins']}',
                                          style: const TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 20,
                                            color: Colors.amber,
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
                                        const Text(
                                          'Fats',
                                          style: TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Expanded(
                                            child: SizedBox(
                                          child: Text(
                                            '....................................................................',
                                            style: TextStyle(
                                              fontFamily: 'Georgia',
                                              fontSize: 20,
                                              color: Colors.grey,
                                            ),
                                            maxLines: 1,
                                          ),
                                        )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${data['dishFats']}',
                                          style: const TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 20,
                                            color: Colors.amber,
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
                                        const Text(
                                          'Carbohydrates',
                                          style: TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Expanded(
                                            child: SizedBox(
                                          child: Text(
                                            '....................................................................',
                                            style: TextStyle(
                                              fontFamily: 'Georgia',
                                              fontSize: 20,
                                              color: Colors.grey,
                                            ),
                                            maxLines: 1,
                                          ),
                                        )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${data['dishCarbohydrates']}',
                                          style: const TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 20,
                                            color: Colors.amber,
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
                                        const Text(
                                          'Fibre',
                                          style: TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Expanded(
                                            child: SizedBox(
                                          child: Text(
                                            '....................................................................',
                                            style: TextStyle(
                                              fontFamily: 'Georgia',
                                              fontSize: 20,
                                              color: Colors.grey,
                                            ),
                                            maxLines: 1,
                                          ),
                                        )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${data['dishFibres']}',
                                          style: const TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 20,
                                            color: Colors.amber,
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
                                        const Text(
                                          'Sugar',
                                          style: TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Expanded(
                                            child: SizedBox(
                                          child: Text(
                                            '....................................................................',
                                            style: TextStyle(
                                              fontFamily: 'Georgia',
                                              fontSize: 20,
                                              color: Colors.grey,
                                            ),
                                            maxLines: 1,
                                          ),
                                        )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${data['dishSugar']}',
                                          style: const TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 20,
                                            color: Colors.amber,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Estimated values based on serving size',
                                          style: TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 10,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildDishByIdIngredients(double width) {
    return SizedBox(
      child: Opacity(
        opacity: opacityext2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedContainer(
              width: _width2,
              height: _height2 + 58,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(40, 40, 40, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              // Define how long the animation should take.
              duration: const Duration(seconds: 1),
              // Provide an optional curve to make the animation feel smoother.
              curve: Curves.fastOutSlowIn,

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 25, top: 10, bottom: 0),
                    child: SizedBox(
                      width: width,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (ext2 == false) {
                            setState(() {
                              ext2 = true;
                              ext2icon = const Icon(
                                Icons.arrow_drop_up_rounded,
                                color: Colors.white,
                                size: 30,
                              );
                              opacityext1 = 0;
                            });
                          } else {
                            setState(() {
                              ext2 = false;
                              ext2icon = const Icon(
                                Icons.arrow_drop_down_rounded,
                                color: Colors.white,
                                size: 30,
                              );
                              opacityext1 = 1;
                            });
                          }
                          // Use setState to rebuild the widget with new values.
                          setState(() {
                            if (ext2 == true) {
                              _width2 = width;
                              _height2 = 530;
                              _isShowExt2 = !_isShowExt2;
                            } else {
                              _width2 = width;
                              _height2 = 80;
                              _isShowExt2 = !_isShowExt2;
                            }
                          });
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
                          children: [
                            const Text(
                              'Ingredients',
                              style: TextStyle(
                                fontFamily: 'Georgia',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Expanded(child: SizedBox()),
                            ext2icon,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Visibility(
                      visible: _isShowExt2,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: Divider(
                                color: Colors.white,
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 0,
                                            bottom: 0),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Ingredients for',
                                                  style: TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 23,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  '$serves servings',
                                                  style: const TextStyle(
                                                    fontFamily: 'Georgia',
                                                    fontSize: 17,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Expanded(child: SizedBox()),
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: const BoxDecoration(
                                                color: Colors.white38,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                              ),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  if (selectedIngredientIndices
                                                      .isNotEmpty) {
                                                    print(
                                                        selectedIngredientIndices);
                                                    selectedIngredientIndices
                                                        .clear();
                                                  }
                                                  _showSnackbarClear(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor:
                                                      Colors.transparent,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  elevation: 0,
                                                  shadowColor:
                                                      Colors.transparent,
                                                  minimumSize: Size.zero,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                ),
                                                child: const Icon(
                                                  Icons.add_shopping_cart_sharp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 400,
                                        child: Query(
                                          options: QueryOptions(
                                            document: gql(DishDescription.getDishIngredients),
                                            variables: {
                                              'id': '${homePage.dishId}',
                                              'dishId': '${homePage.dishId}'
                                            },
                                          ),
                                          builder: (QueryResult result,
                                              {fetchMore, refetch}) {
                                            if (result.hasException) {
                                              print(
                                                  result.exception.toString());
                                              return Center(
                                                child: Text(
                                                  'Error fetching dishes: ${result.exception.toString()}',
                                                ),
                                              );
                                            }

                                            if (result.isLoading) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }

                                            final Map<String, dynamic> data =
                                                result.data?['displayDishById'];

                                            final List<dynamic> ingredients =
                                                data['ingredients'];

                                            return ListView.separated(
                                              scrollDirection: Axis.vertical,
                                              itemCount: ingredients
                                                  .length, // Use the length of the ingredients list
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return const SizedBox(
                                                    height: 10);
                                              },
                                              itemBuilder: (context, index) {
                                                final ingredient =
                                                    ingredients[index];

                                                // Accessing the details of the ingredient
                                                final String ingredientName =
                                                    ingredient['ingredientId']
                                                        ['ingredientName'];
                                                final double quantity = double.parse(ingredient[
                                                    'dishIngredientQuantity']);
                                                final String unit = ingredient[
                                                    'dishIngredientQuantityUnit'];

                                                final bool isSelected =
                                                    selectedIngredientIndices
                                                        .contains(index);

                                                return ListTile(
                                                  leading: IconButton(
                                                    icon: Icon(
                                                      isSelected
                                                          ? Icons.check_circle
                                                          : Icons
                                                              .add_shopping_cart_sharp,
                                                      color: isSelected
                                                          ? Colors.lime
                                                          : Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (isSelected) {
                                                          selectedIngredientIndices
                                                              .remove(index);
                                                        } else {
                                                          selectedIngredientIndices
                                                              .add(index);
                                                        }
                                                      });
                                                      _showSnackbarAdd(context,
                                                          ingredientName);
                                                    },
                                                  ),
                                                  title: Text(
                                                    '$ingredientName',
                                                    style: const TextStyle(
                                                      fontFamily: 'Georgia',
                                                      fontSize: 15,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  trailing: Text(
                                                    quantity == 0
                                                        ? unit
                                                        : '${(quantity) * serves / 2} $unit',
                                                    style: const TextStyle(
                                                      fontFamily: 'Georgia',
                                                      fontSize: 15,
                                                      color: Colors.amber,
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
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

  Widget _buildDishByIdDirections(double width) {
    return SizedBox(
      child: Opacity(
        opacity: opacityext1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedContainer(
              width: _width1,
              height: _height1 + 58,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(56, 56, 56, 1),
                // color: Color.fromRGBO(56, 56, 56, 1).
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              // Define how long the animation should take.
              duration: const Duration(seconds: 1),
              // Provide an optional curve to make the animation feel smoother.
              curve: Curves.fastOutSlowIn,

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 25, top: 10, bottom: 0),
                    child: SizedBox(
                      width: width,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (ext1 == false) {
                            setState(() {
                              ext1 = true;
                              ext1icon = const Icon(
                                Icons.arrow_drop_up_rounded,
                                color: Colors.white,
                                size: 30,
                              );
                            });
                          } else {
                            setState(() {
                              ext1 = false;
                              ext1icon = const Icon(
                                Icons.arrow_drop_down_rounded,
                                color: Colors.white,
                                size: 30,
                              );
                            });
                          }
                          // Use setState to rebuild the widget with new values.
                          setState(() {
                            if (ext1 == true) {
                              _width1 = width;
                              _height1 = 530;
                              _isShowExt1 = !_isShowExt1;
                            } else {
                              _width1 = width;
                              _height1 = 15;
                              _isShowExt1 = !_isShowExt1;
                            }
                          });
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
                          children: [
                            const Text(
                              'Direction',
                              style: TextStyle(
                                fontFamily: 'Georgia',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Expanded(child: SizedBox()),
                            ext1icon,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Visibility(
                      visible: _isShowExt1,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Divider(
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: Container(
                                width: width,
                                child: Query(
                                  options: QueryOptions(
                                    document: gql(DishDescription.getDishById),
                                    variables: {
                                      'id': '${homePage.dishId}',
                                    },
                                  ),
                                  builder: (QueryResult result,
                                      {fetchMore, refetch}) {
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

                                    final Map<String, dynamic> data =
                                        result.data?['displayDishById'];

                                    if (data == null) {
                                      return const Text('No dishes found');
                                    }

                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Total Time',
                                              style: TextStyle(
                                                fontFamily: 'Georgia',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              '${data['dishTotalTime']}',
                                              style: const TextStyle(
                                                fontFamily: 'Georgia',
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Prep Time',
                                              style: TextStyle(
                                                fontFamily: 'Georgia',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              '${data['dishPreparationTime']}',
                                              style: const TextStyle(
                                                fontFamily: 'Georgia',
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Cook Time',
                                              style: TextStyle(
                                                fontFamily: 'Georgia',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              '${data['dishCookingTime']}',
                                              style: const TextStyle(
                                                fontFamily: 'Georgia',
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 0, bottom: 10),
                              child: Divider(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: width,
                              height: 340,
                              child: Query(
                                options: QueryOptions(
                                  document: gql(DishDescription.getDishSteps),
                                  variables: {'dishId': '${homePage.dishId}'},
                                ),
                                builder: (QueryResult result,
                                    {fetchMore, refetch}) {
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

                                  final List<dynamic> steps =
                                      result.data?['displayDishStepById'];
                                  if (steps == null || steps.isEmpty) {
                                    // Handle the case when there are no steps available for the dish
                                    return const Center(
                                      child: Text(
                                        'No steps found for this dish.',
                                      ),
                                    );
                                  }

                                  return ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    itemCount: steps.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(height: 15);
                                    },
                                    itemBuilder: (context, index) {
                                      final step = steps[index];
                                      final String stepDescription =
                                          step['dishStepDescription'];

                                      // Add 1 to the index to display the step number
                                      final int stepNumber = index + 1;

                                      return ListTile(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                        leading: Text(
                                          stepNumber
                                              .toString(), // Display the step number
                                          style: const TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 17,
                                            color: Colors.white,
                                          ),
                                        ),
                                        title: Text(
                                          stepDescription,
                                          style: const TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20, bottom: 20),
                              child: SizedBox(
                                width: width,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _showDialog(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 155, 167, 27),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: const Text(
                                    "I made this!",
                                    style: TextStyle(
                                      fontFamily: 'Georgia',
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Create a stack to overlay the blurred background and the dialog
        return Stack(
          children: [
            // Background with a blurred effect
            BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 7, sigmaY: 7), // Adjust the blur intensity as needed
              child: Container(
                color: Colors.black
                    .withOpacity(0.5), // Adjust the opacity as needed
              ),
            ),
            // Dialog content
            AlertDialog(
              backgroundColor:
                  Colors.transparent, // Make the dialog translucent
              title: const Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 10),
                child: Text(
                  "Rate this recipe",
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 17,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              content: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    // width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          dishDescription.rating = "THUMBSUP";
                        });
                        print("User ID: ${UserFormFields.userId}");
                        print("Dish ID: ${homePage.dishId}");
                        print("Rating: ${dishDescription.rating}");
                        addDishToRatedRecipe(
                            context,
                            UserFormFields.userId.toString(),
                            homePage.dishId.toString(),
                            dishDescription.rating.toString());
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        minimumSize: Size.zero,
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  AssetImage('assets/general/ThumbsUp.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    // width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          dishDescription.rating = "THUMBSDOWN";
                        });
                        print("User ID: ${UserFormFields.userId}");
                        print("Dish ID: ${homePage.dishId}");
                        print("Rating: ${dishDescription.rating}");
                        addDishToRatedRecipe(
                            context,
                            UserFormFields.userId.toString(),
                            homePage.dishId,
                            dishDescription.rating);
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        minimumSize: Size.zero,
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  AssetImage('assets/general/ThumbsDown.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void addDishToRatedRecipe(BuildContext context, String userId, String dishId, String rating) async {

    const String addDishToRatedRecipeMutation = r'''
    mutation AddRecipeToRatedRecipe($userId: ID!, $dishId: ID!, $rating: String!) {
      addRecipeToRatedRecipe(userId: $userId, dishId: $dishId, rating: $rating) {
        ratingRecipe {
          id
          userId{
            username
          }
          dishId{
            dishName
          }
          rating
          recipeRated
        }
      }
    }
  ''';

    // Your variables
    final Map<String, dynamic> variables = {
      'userId': UserFormFields.userId.toString(),
      'dishId': homePage.dishId.toString(),
      'rating': dishDescription.rating.toString(),
    };

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink, // Replace with your GraphQL API endpoint
    );

    // try {
    //   final QueryResult result = await client.mutate(
    //     MutationOptions(
    //       document: gql(addDishToRatedRecipeMutation),
    //       variables: variables,
    //     ),
    //   );
    //
    //   if (result.hasException) {
    //     // Handle error here
    //     print("Mutation error: ${result.exception}");
    //   } else {
    //     // Mutation was successful, you can access data here if needed
    //     final Map<String, dynamic>? responseData = result.data?['addDishToRatedRecipe']['ratedRecipe'];
    //     print('Dish added to rated recipe.');
    //     // You can access fields from responseData, e.g., responseData['id']
    //   }
    // } catch (error) {
    //   print("An error occurred: $error");
    // }

    try {
      final QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(addDishToRatedRecipeMutation),
          variables: variables,
        ),
      );

      if (result.hasException) {
        // Handle error here
        print("Mutation error: ${result.exception}");

        // Check if it's an HttpException
        if (result.exception is HttpLinkServerException) {
          final HttpLinkServerException httpException =
              result.exception as HttpLinkServerException;
          final response = httpException.response;
          print("Response Status Code: ${response?.statusCode}");
          print("Response Body: ${response?.body}");
        }
      } else {
        // Mutation was successful, you can access data here if needed
        final Map<String, dynamic>? responseData =
            result.data?['addDishToRatedRecipe']['ratingRecipe'];
        print('Dish added to rated recipe.');
        // You can access fields from responseData, e.g., responseData['id']
      }
    } catch (error) {
      print("An error occurred: $error");
    }
  }

  void _showSnackbarAdd(BuildContext context, String ingredient) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$ingredient has been added to your pantry',
          style: const TextStyle(
              fontFamily: 'Georgia', fontSize: 15, color: Colors.lime),
        ),
        duration: const Duration(seconds: 3), // Adjust the duration as needed
      ),
    );
  }

  void _showSnackbarClear(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'All your ingredients have been removed from the pantry',
          style: TextStyle(
              fontFamily: 'Georgia', fontSize: 15, color: Colors.lime),
        ),
        duration: Duration(seconds: 3), // Adjust the duration as needed
      ),
    );
  }
}
