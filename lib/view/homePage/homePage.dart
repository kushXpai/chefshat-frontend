import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../controller/graphQL/graphQLClient.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

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
                    child: SizedBox(
                      child: Row(
                        children: [
                          Text(
                            "See more Community ",
                            style: TextStyle(
                              fontFamily: 'Georgia',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade200,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.red.shade200,
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
                  padding:
                  EdgeInsets.only(left: 20, right: 20, top: 100, bottom: 20),
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
      height: 200,
      child: Query(
        options: QueryOptions(
          document: gql(getDishesQuery),
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

          final List<dynamic> dishes = result.data?['displayDish'] ?? [];

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
                        child: const Image(
                          image: NetworkImage(
                            'https://i.pinimg.com/originals/84/46/e9/8446e90a87bc558e143f9cb0324f246a.jpg',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      dish['dishName'],
                      style: const TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 10),
                  ],
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
      height: 200,
      child: Query(
        options: QueryOptions(
          document: gql(getDishesQuery),
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

          final List<dynamic> dishes = result.data?['displayDish'] ?? [];

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
                        child: const Image(
                          image: NetworkImage(
                            'https://i.pinimg.com/originals/84/46/e9/8446e90a87bc558e143f9cb0324f246a.jpg',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      dish['dishName'],
                      style: const TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 10),
                  ],
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
      height: 200,
      child: Query(
        options: QueryOptions(
          document: gql(getDishesQuery),
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

          final List<dynamic> dishes = result.data?['displayDish'] ?? [];

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
                        child: const Image(
                          image: NetworkImage(
                            'https://i.pinimg.com/originals/84/46/e9/8446e90a87bc558e143f9cb0324f246a.jpg',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      dish['dishName'],
                      style: const TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 10),
                  ],
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
      height: 200,
      child: Query(
        options: QueryOptions(
          document: gql(getDishAddedLastWeek),
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

          final List<dynamic> dishes = result.data?['displayDishesAddedLastWeek'] ?? [];

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
                        child: const Image(
                          image: NetworkImage(
                            'https://i.pinimg.com/originals/84/46/e9/8446e90a87bc558e143f9cb0324f246a.jpg',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      dish['dishName'],
                      style: const TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLastDishView(double width) {
    return SizedBox(
      child: Query(
        options: QueryOptions(
          document: gql(getLastDishesQuery),
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
          result.data?['displayLastAddedDish'];

          if (data == null) {
            return const Text('No dishes found');
          }

          // final String id = data['id'];
          final String dishName = data['dishName'];

          return ElevatedButton(
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
            child: SizedBox(
              child: Container(
                width: width - 40,
                decoration: BoxDecoration(
                  color: Colors.lime,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: width - 40,
                      height: width - 40,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        child: Image.network(
                          'https://i.pinimg.com/originals/84/46/e9/8446e90a87bc558e143f9cb0324f246a.jpg',
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
                          color: Colors.black,
                        ),
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
}
