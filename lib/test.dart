import 'package:chefs_hat/view/recipeGenerator/recipeGenerator.dart';
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

  // List<String> ingredientsList = ["Salt N Pepper", "Pork Ribs"];
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

                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 0,
                    bottom: 0,
                  ),
                  child: _buildSectionHeader("Recipe Generator"),
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
                    child: _buildRecipe(width),
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

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: dishes.length,
          itemBuilder: (context, index) {
            final dish = dishes[index];
            return ListTile(
              leading: SizedBox(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: NetworkImage(
                      "http://192.168.68.105:8000/media/" + dish['dishImage'],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                dish['dishName'],
                style: const TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
