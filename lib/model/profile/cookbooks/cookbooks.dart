import 'package:chefs_hat/controller/graphQL/queries/queries.dart';
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
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
              ),
              child: GraphQLProvider(
                client: client,
                child: _buildUserSavedRecipeCourse3(width),
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
                child: _buildUserSavedRecipeCourse4(width),
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
                child: _buildUserSavedRecipeCourse5(width),
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
    return Query(
      options: QueryOptions(
        document: gql(SavedRecipes.getSavedRecipe),
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
          int savedRecipesLength = savedRecipes.length.clamp(0, 3);
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
                  final savedRecipe = savedRecipes[index];

                  // Accessing the details of the dish
                  final String dishName = savedRecipe['dishId']['dishName'];
                  final String dishImage = savedRecipe['dishId']['dishImage'];
                  final String dishRecipeSaved = savedRecipe['recipeSaved'];

                  return ElevatedButton(
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
                                padding: EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
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
                                padding: EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
                                child: Text(
                                  '${formatTimeDifference(dishRecipeSaved)}',
                                  style:  TextStyle(
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
                  );
                  //   Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 0, right: 10, top: 0, bottom: 10),
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         homePage.dishId = savedRecipe['id'];
                  //       });
                  //       Navigator.pushNamed(context, 'dishDescription');
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       foregroundColor: Colors.transparent,
                  //       backgroundColor: Colors.transparent,
                  //       elevation: 0,
                  //       shadowColor: Colors.transparent,
                  //       minimumSize: Size.zero,
                  //       padding: const EdgeInsets.all(0),
                  //     ),
                  //     child: SizedBox(
                  //       width: width / 3 + 10,
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           SizedBox(
                  //             width: width / 3,
                  //             height: width / 3,
                  //             child: ClipRRect(
                  //               borderRadius: BorderRadius.circular(20),
                  //               child: Image(
                  //                 image: NetworkImage(
                  //                   httpLinkImage + dishImage,
                  //                 ),
                  //                 fit: BoxFit.fill,
                  //               ),
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.only(
                  //               left: 0,
                  //               right: 0,
                  //               top: 10,
                  //               bottom: 0,
                  //             ),
                  //             child: Text(
                  //               dishName,
                  //               style: const TextStyle(
                  //                 fontFamily: 'Georgia',
                  //                 fontSize: 14,
                  //                 color: Colors.white,
                  //               ),
                  //               maxLines: 3,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // );
                },
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
    );
  }

  Widget _buildUserSavedRecipeCourse1(double width) {
    return SizedBox(
      child: Query(
        options: QueryOptions(
          document: gql(SavedRecipes.getSavedRecipeCourse),
          variables: {
            'userSavedRecipeCategory': 'APPETIZERS',
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
          document: gql(SavedRecipes.getSavedRecipeCourse),
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
          document: gql(SavedRecipes.getSavedRecipeCourse),
          variables: {
            'userSavedRecipeCategory': 'DESSERTS', // Replace with your desired category
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
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Desserts",
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
                    cookbooks.savedRecipeCourse = "DESSERTS";
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
                          "Desserts",
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
          document: gql(SavedRecipes.getSavedRecipeCourse),
          variables: {
            'userSavedRecipeCategory': 'SIDES', // Replace with your desired category
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
            final dish = savedRecipes[0];
            return Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 0, top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    cookbooks.savedRecipeCourse = "SIDES";
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
          document: gql(SavedRecipes.getSavedRecipeCourse),
          variables: {
            'userSavedRecipeCategory': 'SNACKS', // Replace with your desired category
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
            final dish = savedRecipes[0];
            return Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 0, top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    cookbooks.savedRecipeCourse = "SNACKS";
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