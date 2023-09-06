import 'package:chefs_hat/constants/colors/customColors.dart';
import 'package:chefs_hat/view/recipeGenerator/recipeGenerator.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../controller/graphQL/graphQLClient.dart';

class displayDishList extends StatefulWidget {
  const displayDishList({Key? key}) : super(key: key);

  static int recipesGenerated = 0;

  @override
  State<displayDishList> createState() => _displayDishListState();
}

class _displayDishListState extends State<displayDishList> {
  List<String> ingredientsList = recipeGenerator.selectedIngredients;

  final String searchDishesByIngredientsQuery = r'''
  query SearchDishesByIngredients($ingredients: [String!]!) {
    searchDishesByIngredients(ingredients: $ingredients) {
      id
      dishName
      dishVisits
      dishCategoryCourse
      dishCategoryCuisine
      dishCategoryDietary
      dishCategoryAllergen
      dishCategorySpicenessLevel
      dishCategorySeason
      dishImage
      dishDescription
      dishRating
      dishTotalTime
      dishPreparationTime
      dishCookingTime
      dishCalories
      dishProteins
      dishFats
      dishCarbohydrates
      dishFibres
      dishSugar
      dishSodium
      dishLastUpdate
    }
  }
''';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: CustomColors.black,
        body: Column(
          children: [
            Stack(
              children: [
                Opacity(
                  opacity: 0.15,
                  child: SizedBox(
                    width: width,
                    height: 150,
                    child: const Image(
                      image: AssetImage(
                          'assets/recipeGeneratorPhotos/recipeGeneratotBackground.png'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                SizedBox(
                  width: width,
                  height: 150,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 50, bottom: 5),
                        child: Center(
                          child: Text(
                            'Recipes',
                            style: TextStyle(
                                fontFamily: 'Georgia',
                                fontSize: 25,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 30),
                        child: Center(
                          child: Text(
                            'You can make ${displayDishList.recipesGenerated} recipes',
                            style: const TextStyle(
                                fontFamily: 'Georgia',
                                fontSize: 14,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: width,
                      height: height - 150,
                      decoration: const BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GraphQLProvider(
                          client: client,
                          child: _buildRecipe(width),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
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

  Widget _buildRecipe(double width) {
    return Query(
      options: QueryOptions(
        document: gql(searchDishesByIngredientsQuery),
        variables: {'ingredients': ingredientsList},
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

        final List<dynamic>? dishes = result.data?['searchDishesByIngredients'];

        if (dishes == null || dishes.isEmpty) {
          return const Text('No dishes found');
        }

        displayDishList.recipesGenerated = dishes.length;

        return Column(
          children: [
            _buildSectionHeader("You can make ${displayDishList.recipesGenerated} recipes"),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dishes.length,
              itemBuilder: (context, index) {
                final dish = dishes[index];
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 0, bottom: 20),
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 0, top: 0, bottom: 5),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 0,
                                          right: 10,
                                          top: 0,
                                          bottom: 0),
                                      child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: dish[
                                                      'dishCategoryDietary'] ==
                                                  "vegetarian"
                                              ? AssetImage(
                                                  'assets/general/Veg.png')
                                              : AssetImage(
                                                  'assets/general/NonVeg.png'),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.amber[600],
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Trending',
                                          style: TextStyle(
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
                                padding: EdgeInsets.only(
                                    left: 0, right: 0, top: 5, bottom: 5),
                                child: Text(
                                  dish['dishName'],
                                  style: TextStyle(
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
                                padding: EdgeInsets.only(
                                    left: 0, right: 0, top: 5, bottom: 5),
                                child: Text(
                                  '142 ratings',
                                  style: TextStyle(
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
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 140,
                          width: 140,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              httpLinkImage + dish['dishImage'],
                              fit: BoxFit
                                  .cover, // Adjust the image's fit as needed
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
