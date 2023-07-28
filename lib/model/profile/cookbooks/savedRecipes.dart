import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../constants/colors/customColors.dart';
import '../../../controller/graphQL/graphQLClient.dart';

class savedRecipes extends StatefulWidget {
  const savedRecipes({Key? key}) : super(key: key);

  @override
  State<savedRecipes> createState() => _savedRecipesState();
}

class _savedRecipesState extends State<savedRecipes> {
  final String getSavedRecipes = r'''
    query {
      displayUserSavedRecipesById(userId: 1) {
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

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: _buildSectionHeader("Recently Saved Recipes"),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          GraphQLProvider(
            client: client,
            child: _buildUserSavedRecipes(width),
          ),
        ],
      )),
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

  Widget _buildUserSavedRecipes(double width) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      child: Query(
        options: QueryOptions(
          document: gql(getSavedRecipes),
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            print(result.exception.toString());
            return Column(
              children: [
                SizedBox(
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
          }

          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<dynamic> savedRecipes =
              result.data?['displayUserSavedRecipesById'];

          return SizedBox(
            height: 795,
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: savedRecipes
                  .length, // Use the length of the saved recipes list
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                final savedRecipe = savedRecipes[index];

                // Accessing the details of the dish
                final String dishName = savedRecipe['dishId']['dishName'];
                final String dishImage = savedRecipe['dishId']['dishImage'];
                final int dishRatings = 142;

                return Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 0, bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {});
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
                          height: 100,
                          width: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              "http://192.168.68.105:8000/media/" +
                                  dishImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 0, top: 5, bottom: 5),
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
                                    left: 0, right: 0, top: 5, bottom: 5),
                                child: Text(
                                  '$dishRatings ratings',
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
                );
              },
            ),
          );
        },
      ),
    );
  }
}
