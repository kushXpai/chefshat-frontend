import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:chefs_hat/view/authentication/otpVerification.dart';
import 'package:chefs_hat/view/homePage/homePage.dart';
import '../../../constants/colors/Colors.dart';
import '../../../controller/graphQL/graphQLClient.dart';

class savedRecipes extends StatefulWidget {
  const savedRecipes({Key? key}) : super(key: key);

  @override
  State<savedRecipes> createState() => _savedRecipesState();
}

class _savedRecipesState extends State<savedRecipes> {
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
          dishCategoryDietary
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
          Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 0),
            child: GraphQLProvider(
              client: client,
              child: _buildUserSavedRecipe(width),
            ),
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
          } else {
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
                  final String dishCategoryDietary = savedRecipe['dishId']['dishCategoryDietary'] ?? "";
                  final int dishRatings = 142;


                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
                    child: ElevatedButton(
                      onPressed: (){
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 5),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        width: 30,

                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: dishCategoryDietary == "VEGETARIAN"
                                              ? const AssetImage('assets/general/Veg.png') : const AssetImage('assets/general/NonVeg.png'),
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Container(
                                        height: 30,
                                        width: 70,

                                        decoration: BoxDecoration(
                                          color: Colors.amber[600],
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        ),

                                        child: const Center(
                                          child: Text('Trending',
                                            style:  TextStyle(
                                              fontFamily: 'Georgia',
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: CustomColors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
                                  child: Text(
                                    dishName,
                                    style:  const TextStyle(
                                      fontFamily: 'Georgia',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.white,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
                                  child: Text('142 ratings',
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
                          const SizedBox(width: 10,),
                          SizedBox(
                            height: 140,
                            width: 140,

                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                httpLinkImage + dishImage,
                                fit: BoxFit.cover, // Adjust the image's fit as needed
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
        },
      ),
    );
  }
}
