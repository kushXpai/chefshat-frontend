import 'package:chefs_hat/view/authentication/otpVerification.dart';
import 'package:chefs_hat/view/homePage/homePage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../constants/colors/Colors.dart';
import '../../../controller/graphQL/graphQLClient.dart';

class cookbooks extends StatefulWidget {
  const cookbooks({Key? key}) : super(key: key);

  static String savedRecipeCourse = "";

  @override
  State<cookbooks> createState() => _cookbooksState();
}

class _cookbooksState extends State<cookbooks> {
  final String getSavedRecipe = '''
    query {
      displayUserSavedRecipeById(userId: ${otpVerification.userId}) {
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
        recipeSaved
      }
    }
  ''';

  final String getSavedRecipeCourse = '''
    query displayUserSavedRecipeByCourse(\$userSavedRecipeCategory : String!) {
      displayUserSavedRecipeByCourse(userId: ${otpVerification.userId}, userSavedRecipeCategory: \$userSavedRecipeCategory) {
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
        recipeSaved
      }
    }
  ''';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: width,
      height: height * 0.62,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 10,
                top: 0,
                bottom: 0,
              ),
              child: _buildSectionHeader("Recently Saved Recipes"),
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
                child: _buildUserSavedRecipe(width),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 0,
                right: 0,
                top: 50,
                bottom: 0,
              ),
              child: GraphQLProvider(
                client: client,
                child: _buildUserSavedRecipeCourse1(width),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
              ),
              child: GraphQLProvider(
                client: client,
                child: _buildUserSavedRecipeCourse2(width),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 0, top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () {},
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
                    Container(
                        height: 90,
                        width: 150,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://i.pinimg.com/originals/f0/6b/c6/f06bc6fe8412a5abe9af28a808d1ede2.png',
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dessert",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "0 recipes",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 13,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 0, top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () {},
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
                    Container(
                        height: 90,
                        width: 150,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://i.pinimg.com/originals/f0/6b/c6/f06bc6fe8412a5abe9af28a808d1ede2.png',
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sides",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "0 recipes",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 13,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 0, top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () {},
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
                    Container(
                        height: 90,
                        width: 150,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://i.pinimg.com/originals/f0/6b/c6/f06bc6fe8412a5abe9af28a808d1ede2.png',
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Snacks",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "0 recipes",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 13,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
              color:
                  Colors.white,
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
          document: gql(getSavedRecipe),
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
              result.data?['displayUserSavedRecipeById'];

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
            int savedRecipesLength = 0;
            if (savedRecipes.length > 5) {
              savedRecipesLength = 5;
            } else {
              savedRecipesLength = savedRecipes.length;
            }
            print(savedRecipesLength);
            return Column(
              children: [
                SizedBox(
                  height: 210,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        savedRecipesLength, // Use the length of the saved recipes list
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10);
                    },
                    itemBuilder: (context, index) {
                      final savedRecipe = savedRecipes[index];

                      // Accessing the details of the dish
                      final String dishName = savedRecipe['dishId']['dishName'];
                      final String dishImage =
                          savedRecipe['dishId']['dishImage'];
                      final int dishRatings = 142;

                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 10, top: 0, bottom: 10),
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
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 10, bottom: 10),
                  child: Container(
                    width: width,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.lime,
                          width: 2), // Set the border color
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

  Widget _buildUserSavedRecipeCourse1(double width) {
    return SizedBox(
      child: Query(
        options: QueryOptions(
          document: gql(getSavedRecipeCourse),
          variables: {
            'userSavedRecipeCategory':
                'APPETIZERS', // Replace with your desired category
          },
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
              result.data?['displayUserSavedRecipeByCourse'];
          int savedRecipesLength = 0;
          savedRecipesLength = savedRecipes.length;

          if (savedRecipes.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 0, top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    cookbooks.savedRecipeCourse = "ENTREE";
                  });
                  Navigator.pushNamed(context, 'savedRecipeCourse');
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
                    Container(
                        height: 90,
                        width: 150,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://i.pinimg.com/originals/f0/6b/c6/f06bc6fe8412a5abe9af28a808d1ede2.png',
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Appetizers",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "0 recipes",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 13,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            final dish = savedRecipes[0];
            return Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 0, top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    cookbooks.savedRecipeCourse = "APPETIZERS";
                  });
                  print(cookbooks.savedRecipeCourse);
                  Navigator.pushNamed(context, 'savedRecipeCourse');
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
                    Container(
                        height: 90,
                        width: 150,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            httpLinkImage + dish['dishId']['dishImage'],
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Appetizers",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "$savedRecipesLength recipes",
                          style: const TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 13,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildUserSavedRecipeCourse2(double width) {
    return SizedBox(
      child: Query(
        options: QueryOptions(
          document: gql(getSavedRecipeCourse),
          variables: {
            'userSavedRecipeCategory':
                'ENTREE', // Replace with your desired category
          },
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
              result.data?['displayUserSavedRecipeByCourse'];
          int savedRecipesLength = 0;
          savedRecipesLength = savedRecipes.length;

          if (savedRecipes.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 0, top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    cookbooks.savedRecipeCourse = "ENTREE";
                  });
                  Navigator.pushNamed(context, 'savedRecipeCourse');
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
                    Container(
                        height: 90,
                        width: 150,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://i.pinimg.com/originals/f0/6b/c6/f06bc6fe8412a5abe9af28a808d1ede2.png',
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Entrée",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "0 recipes",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 13,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            final dish = savedRecipes[0];
            return Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 0, top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    cookbooks.savedRecipeCourse = "ENTREE";
                  });
                  Navigator.pushNamed(context, 'savedRecipeCourse');
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
                    Container(
                        height: 90,
                        width: 150,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            // 'https://i.pinimg.com/originals/f0/6b/c6/f06bc6fe8412a5abe9af28a808d1ede2.png',
                            httpLinkImage + dish['dishId']['dishImage'],
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Entrée",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "$savedRecipesLength recipes",
                          style: const TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 13,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildUserSavedRecipeCourse3(double width) {
    return SizedBox(
      child: Query(
        options: QueryOptions(
          document: gql(getSavedRecipeCourse),
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
              result.data?['displayUserSavedRecipeByCourse'];
          int savedRecipesLength = 0;
          savedRecipesLength = savedRecipes.length;

          if (savedRecipes.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 0, top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    cookbooks.savedRecipeCourse = "ENTREE";
                  });
                  Navigator.pushNamed(context, 'savedRecipeCourse');
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
                    Container(
                        height: 90,
                        width: 150,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://i.pinimg.com/originals/f0/6b/c6/f06bc6fe8412a5abe9af28a808d1ede2.png',
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dessert",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "0 recipes",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 13,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 0, top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    cookbooks.savedRecipeCourse = "DESSERTS";
                  });
                  Navigator.pushNamed(context, 'savedRecipeCourse');
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
                    Container(
                        height: 90,
                        width: 150,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://i.pinimg.com/originals/f0/6b/c6/f06bc6fe8412a5abe9af28a808d1ede2.png',
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Dessert",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "$savedRecipesLength recipes",
                          style: const TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 13,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildUserSavedRecipeCourse4(double width) {
    return SizedBox(
      child: Query(
        options: QueryOptions(
          document: gql(getSavedRecipeCourse),
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
              result.data?['displayUserSavedRecipeByCourse'];
          int savedRecipesLength = 0;
          savedRecipesLength = savedRecipes.length;

          if (savedRecipes.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 0, top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    cookbooks.savedRecipeCourse = "ENTREE";
                  });
                  Navigator.pushNamed(context, 'savedRecipeCourse');
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
                    Container(
                        height: 90,
                        width: 150,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://i.pinimg.com/originals/f0/6b/c6/f06bc6fe8412a5abe9af28a808d1ede2.png',
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sides",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "0 recipes",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 13,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 0, top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    cookbooks.savedRecipeCourse = "SIDES";
                  });
                  Navigator.pushNamed(context, 'savedRecipeCourse');
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
                    Container(
                        height: 90,
                        width: 150,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://i.pinimg.com/originals/f0/6b/c6/f06bc6fe8412a5abe9af28a808d1ede2.png',
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sides",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "$savedRecipesLength recipes",
                          style: const TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 13,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildUserSavedRecipeCourse5(double width) {
    return SizedBox(
      child: Query(
        options: QueryOptions(
          document: gql(getSavedRecipeCourse),
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
              result.data?['displayUserSavedRecipeByCourse'];
          int savedRecipesLength = 0;
          savedRecipesLength = savedRecipes.length;

          if (savedRecipes.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 0, top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    cookbooks.savedRecipeCourse = "ENTREE";
                  });
                  Navigator.pushNamed(context, 'savedRecipeCourse');
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
                    Container(
                        height: 90,
                        width: 150,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://i.pinimg.com/originals/f0/6b/c6/f06bc6fe8412a5abe9af28a808d1ede2.png',
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Snacks",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "0 recipes",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 13,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 0, top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    cookbooks.savedRecipeCourse = "SNACKS";
                  });
                  Navigator.pushNamed(context, 'savedRecipeCourse');
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
                    Container(
                        height: 90,
                        width: 150,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://i.pinimg.com/originals/f0/6b/c6/f06bc6fe8412a5abe9af28a808d1ede2.png',
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Snacks",
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "$savedRecipesLength recipes",
                          style: const TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 13,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}