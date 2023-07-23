import 'package:animate_gradient/animate_gradient.dart';
import 'package:chefs_hat/constants/colors/customColors.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../controller/graphQL/graphQLClient.dart';
import '../../controller/registration/registration.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  static String dishId = "";


  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {


  final String getDishesQuery = r'''
    query{
      displayDish{
        id
        dishName
        dishImage
        dishCalories
        dishRating
        dishCourse
        dishTotalTime
      }
    }
  ''';

  final String getLastDishesQuery = r'''
    query {
      displayLastAddedDish {
          id
          dishName
          dishImage
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

  final String getDishTrending = r'''
    query{
      displayDishesTrending{
        id
        dishName
        dishImage
        dishVisits
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
                      // Navigator.pushNamed(context, '');
                      print(UserFormFields.userName);
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
                      color: Colors.white,
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

  Widget _buildDishListViewCommunity(double width) {
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
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3,
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
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3,
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
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3 - 60,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
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

          if (result.isLoading) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
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
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
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
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
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

          final List<dynamic> dishes = result.data?['displayDish'] ?? [];

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: dishes.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 10);
            },
            itemBuilder: (context, index) {
              final dish = dishes[index];
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    homePage.dishId = dish['id'];
                  });
                  Navigator.pushNamed(context, 'dishDescription');
                  // Navigator.pushNamed(context, 'test');
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
                              "http://192.168.68.105:8000/media/" + dish['dishImage'],
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
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3,
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
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3,
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
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3 - 60,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
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

          if (result.isLoading) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
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
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
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
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
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

          final List<dynamic> dishes = result.data?['displayDish'] ?? [];

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: dishes.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 10);
            },
            itemBuilder: (context, index) {
              final dish = dishes[index];
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    homePage.dishId = dish['id'];
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
                              "http://192.168.68.105:8000/media/" + dish['dishImage'],
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
      ),
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
            // Handle error state here
            return Container();
          }

          if (result.isLoading) {
            // Handle loading state here
            return Container();
          }

          final List<dynamic> dishes = result.data?['displayDishesTrending'] ?? [];

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
                builder: (RunMutation runMutation, QueryResult? mutationResult) {
                  return ElevatedButton(
                    onPressed: () {
                      runMutation({'id': dish['id']}); // Execute the mutation when button is clicked
                      setState(() {
                        homePage.dishId = dish['id'];
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
                                  "http://192.168.68.105:8000/media/" + dish['dishImage'],
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
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3,
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
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3,
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
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3 - 60,
                              width: width / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
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

          if (result.isLoading) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
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
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
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
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
                              height: width / 3 - 27,
                              width: width / 3 - 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: RotatedBox(
                        quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                            child: Container(
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

          final List<dynamic> dishes = result.data?['displayDishesAddedLastWeek'] ?? [];

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: dishes.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 10);
            },
            itemBuilder: (context, index) {
              final dish = dishes[index];
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    homePage.dishId = dish['id'];
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
                              "http://192.168.68.105:8000/media/" + dish['dishImage'],
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
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  child: RotatedBox(
                    quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                        child: Container(
                          height: width,
                          width: 337,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                ClipRRect(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                  child: RotatedBox(
                    quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                        child: Container(
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
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  child: RotatedBox(
                    quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                        child: Container(
                          height: width,
                          width: 337,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                ClipRRect(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                  child: RotatedBox(
                    quarterTurns: 1, // Rotate 90 degrees clockwise (left to right)
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
                        child: Container(
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

        final Map<String, dynamic> data =
            result.data?['displayLastAddedDish'];

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
                          "http://192.168.68.105:8000/media/" + data['dishImage'],
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
}
