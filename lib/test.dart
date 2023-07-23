import 'package:chefs_hat/view/homePage/homePage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'controller/graphQL/graphQLClient.dart';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  final String getUsersQuery = r'''
    query {
      displayUser {
        id
        username
        mobileNumber
        emailAddress
        dateOfBirth
        address
        profilePhoto
      }
    }
  ''';

  final String getDishesQuery = r'''
    query{
      displayDish{
        id
        dishName
        dishImage
        dishCalories
        dishRating
        course
        dishTotalTime
      }
    }
  ''';

  final String getLastDishesQuery = r'''
    query {
      displayLastAddedDish {
          id
          dishName
      }
    }
  ''';

  final String getDishAddedLastWeek = r'''
    query {
      displayDishesAddedLastWeek {
        id
        dishName
        dishImage
      }
    }
  ''';

  final String getIngredients = r'''
    query{
      displayIngredient{
        id
        ingredientName
        ingredientImage
        ingredientCategory
      }
    }
  ''';

  final String getDishIngredients = r'''
    query($id: ID!) {
      displayDishById(id: $id) {
        id
        dishName
        
        ingredients(dishId: $id) {
          id
          dishIngredientQuantity
          dishIngredientQuantityUnit
          ingredientId {
            id
            ingredientName
            ingredientImage
          }
        }
      }
    }
  ''';


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
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
          SingleChildScrollView(
            child: Column(
              children: [
                // Users
                // Padding(
                //   padding: const EdgeInsets.only(
                //     left: 20,
                //     right: 20,
                //     top: 0,
                //     bottom: 0,
                //   ),
                //   child: _buildSectionHeader("What's our community cooking"),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //     left: 20,
                //     right: 20,
                //     top: 0,
                //     bottom: 10,
                //   ),
                //   child: GraphQLProvider(
                //     client: client,
                //     child: _buildUsers(width),
                //   ),
                // ),

                // Ingredients
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
                    child: _buildIngredients(width),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 0,
                    bottom: 0,
                  ),
                  child: _buildSectionHeader("Dish Dish Ingredients by ID"),
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
                    child: _buildDishIngredients(width),
                  ),
                ),
              ],
            ),
          ),
        ],
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

  Widget _buildUsers(double width) {
    return SizedBox(
      height: 255,
      child: Query(
        options: QueryOptions(
          document: gql(getUsersQuery),
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

          final List<dynamic> dishes = result.data?['displayUser'] ?? [];

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: dishes.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 10);
            },
            itemBuilder: (context, index) {
              final dish = dishes[index];
              return SizedBox(
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
                            "http://192.168.68.105:8000/media/" + dish['profilePhoto'],
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      dish['username'],
                      style: const TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildIngredients(double width) {
    return SizedBox(
      height: 255,
      child: Query(
        options: QueryOptions(
          document: gql(getIngredients),
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

          final List<dynamic> ingredients = result.data?['displayIngredient'] ?? [];

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: ingredients.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 10);
            },
            itemBuilder: (context, index) {
              final ingredient = ingredients[index];
              return SizedBox(
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
                            "http://192.168.68.105:8000/media/" + ingredient['ingredientImage'],
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      ingredient['ingredientName'],
                      style: const TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDishIngredients(double width) {
    return SizedBox(
      height: 255,
      child: Query(
        options: QueryOptions(
          document: gql(getDishIngredients),
          variables: {'id': '${homePage.dishId}', 'dishId': '${homePage.dishId}'},
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

          final String dishId = data['id'];
          final String dishName = data['dishName'];

          // Accessing the ingredients list
          final List<dynamic> ingredients = data['ingredients'];

          return ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: ingredients.length, // Use the length of the ingredients list
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              final ingredient = ingredients[index];

              // Accessing the details of the ingredient
              final String ingredientName = ingredient['ingredientId']['ingredientName'];
              final String ingredientImage = ingredient['ingredientId']['ingredientImage'];
              final int quantity = ingredient['dishIngredientQuantity'];
              final String unit = ingredient['dishIngredientQuantityUnit'];

              return SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0,
                              right: 10,
                              top: 0,
                              bottom: 0),
                          child: Container(
                              height: 50,
                              width: 50,
                              padding:
                              EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                                border: Border.all(
                                    color: Colors.white54,
                                    width: 1.0),
                              ),
                              child: Image.network(
                                "http://192.168.68.105:8000/media/" + ingredientImage,
                                fit: BoxFit.contain,
                              )),
                        ),
                        Text(
                          '$ingredientName',
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(child: SizedBox()),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '$quantity $unit',
                          style: const TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 15,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
