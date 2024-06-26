import 'package:chefs_hat/view/homePage/homePage.dart';
import 'package:chefs_hat/view/recipeGenerator/displayDishList.dart';
import 'package:chefs_hat/view/recipeGenerator/recipeGenerator.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'constants/colors/Colors.dart';
import 'controller/graphQL/graphQLClient.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'controller/graphQL/queries/queries.dart';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  List<String> ingredientsList = recipeGenerator.selectedIngredients;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: CustomColors.black,
      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        child: Column(
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
                          topRight: Radius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 0, bottom: 0),
                  child: GraphQLProvider(
                    client: client,
                    child: _buildRecipe(width, height),
                  ),
                ),
              ],
            ),
          ],
        ),
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

  // Widget _buildRecipe(double width, double height) {
  //   return Query(
  //     options: QueryOptions(
  //       document: gql(RecipeGenerator.searchDishesByIngredientsQuery),
  //       variables: {'ingredients': ingredientsList},
  //     ),
  //     builder: (QueryResult result, {fetchMore, refetch}) {
  //       if (result.hasException) {
  //         print(result.exception.toString());
  //         return Center(
  //           child: Text(
  //             'Error fetching dishes: ${result.exception.toString()}',
  //           ),
  //         );
  //       }
  //
  //       if (result.isLoading) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //
  //       final List<dynamic>? dishes = result.data?['searchDishesByIngredients'];
  //
  //       if (dishes == null || dishes.isEmpty) {
  //         return const Text('No dishes found');
  //       }
  //
  //       displayDishList.recipesGenerated = dishes.length;
  //
  //       return StaggeredGridView.builder(
  //         itemCount: displayDishList.recipesGenerated,
  //         shrinkWrap: true,
  //         physics: const NeverScrollableScrollPhysics(),
  //         gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: 2,
  //           staggeredTileBuilder: (int index) {
  //             return StaggeredTile.fit(1);
  //           },
  //           mainAxisSpacing: 30.0, // Adjust this value to control the vertical gap
  //           crossAxisSpacing: 0.0,
  //         ),
  //         itemBuilder: (BuildContext context, int index) {
  //           final dish = dishes[index];
  //
  //           final String dishName = dish['dishName'];
  //           final String dishImage = dish['dishImage'];
  //           final String dishTotalTime = dish['dishTotalTime'];
  //
  //           return ElevatedButton(
  //             onPressed: () {
  //               setState(() {
  //                 homePage.dishId = dish['id'];
  //               });
  //               Navigator.pushNamed(context, 'dishDescription');
  //             },
  //             style: ElevatedButton.styleFrom(
  //               primary: Colors.transparent,
  //               onPrimary: Colors.transparent,
  //               onSurface: Colors.transparent,
  //               elevation: 0,
  //               shadowColor: Colors.transparent,
  //               minimumSize: Size.zero,
  //               padding: const EdgeInsets.all(0),
  //             ),
  //             child: Container(
  //               padding: const EdgeInsets.all(12),
  //               child: Stack(
  //                 children: [
  //                   Column(
  //                     children: [
  //                       const SizedBox(
  //                         height: 50,
  //                       ),
  //                       Container(
  //                         height: 190,
  //                         padding: const EdgeInsets.all(15),
  //                         decoration: const BoxDecoration(
  //                             borderRadius: BorderRadius.all(Radius.circular(20)),
  //                             color: Colors.white12),
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.end,
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 SizedBox(
  //                                   width: (width / 2) - 54,
  //                                   child: Text(
  //                                     dishName,
  //                                     style: const TextStyle(
  //                                         color: Colors.white,
  //                                         fontSize: 15,
  //                                         fontFamily: 'Georgia'),
  //                                     maxLines: 2,
  //                                     overflow: TextOverflow.ellipsis,
  //                                     textAlign: TextAlign.center,
  //                                   ),
  //                                 )
  //                               ],
  //                             ),
  //                             const SizedBox(
  //                               height: 10,
  //                             ),
  //                             Row(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 const Icon(
  //                                   Icons.timelapse_rounded,
  //                                   color: Colors.lime,
  //                                 ),
  //                                 const SizedBox(
  //                                   width: 5,
  //                                 ),
  //                                 Text(
  //                                   dishTotalTime,
  //                                   style: const TextStyle(
  //                                       color: Colors.lime,
  //                                       fontSize: 15,
  //                                       fontFamily: 'Georgia'),
  //                                 )
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   Center(
  //                     child: Column(
  //                       children: [
  //                         Container(
  //                           height: 140,
  //                           width: 140,
  //                           decoration: BoxDecoration(
  //                             shape: BoxShape.circle,
  //                             color: Colors.white,
  //                           ),
  //                           child: ClipOval(
  //                             child: Image(
  //                               image: NetworkImage(
  //                                 httpLinkImage + dishImage,
  //                               ),
  //                               fit: BoxFit.cover,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }


  Widget _buildRecipe(double width, double height) {
    return Query(
      options: QueryOptions(
        document: gql(RecipeGenerator.searchDishesByIngredientsQuery),
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

        return GridView.builder(
          itemCount: displayDishList.recipesGenerated,
          shrinkWrap: true, // Added this
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.74, // Adjust this value
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
                          height: 190,
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                              color: Colors.white12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
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
