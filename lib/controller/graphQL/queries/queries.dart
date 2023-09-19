import 'package:chefs_hat/view/authentication/otpVerification.dart';
import 'package:chefs_hat/view/homePage/homePage.dart';

class Uploads {
  static String getAllUserUploads = '''
    query {
      displayUserUpload{
        userId{
          username
          profilePhoto
        }
        uploadName
        uploadImage
        uploadDescription
        uploadLikes
        creationTime
      }
    }
  ''';

  static String getUserUploadsById = '''
    query {
      displayUserUploadById(userId: ${otpVerification.userId}){
        id
        userId{
          username
          profilePhoto
        }
        uploadName
        uploadImage
        uploadDescription
        uploadLikes
        creationTime
      }
    }
  ''';
}

class Homepage {
  static String getDishesQuery = r'''
    query{
      displayDish{
        id
        dishName
        dishImage
        dishCalories
        dishRating
        dishCategoryCourse
        dishTotalTime
      }
    }
  ''';

  static String getLastDishesQuery = r'''
    query {
      displayLastAddedDish {
          id
          dishName
          dishImage
          dishCategoryCourse
      }
    }
  ''';

  static String getDishAddedLastWeek = r'''
    query {
      displayDishesAddedLastWeek {
        id
        dishName
        dishImage
        dishCategoryCourse
      }
    }
  ''';

  static String getDishTrending = r'''
    query{
      displayDishesTrending{
        id
        dishName
        dishImage
        dishVisits
        dishCategoryCourse
      }
    }
  ''';
}

class DishDescription {
  static String getDishById = r'''
    query ($id: ID!) {
      displayDishById(id: $id) {
        dishName
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

  static String getDishIngredients = r'''
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

  static String getDishSteps = r'''
    query GetDishSteps($dishId: ID!) {
      displayDishStepById(dishId: $dishId) {
        id
        dishStepDescription
      }
    }
  ''';

  static String addRecipeToSavedRecipesMutation = r'''
    mutation AddRecipeToSavedRecipes($userId: ID!, $dishId: ID!, $userSavedRecipeCategory: String!) {
      addRecipeToSavedRecipes(userId: $userId, dishId: $dishId, userSavedRecipeCategory: $userSavedRecipeCategory) {
        savedRecipe {
          id
          userId {
            id
            username
          }
          dishId {
            id
            dishName
            dishCategoryCourse
          }
          recipeSaved
        }
      }
    }
  ''';

  static String removeRecipeFromSavedRecipesMutation = r'''
    mutation RemoveRecipeFromSavedRecipes($userId: ID!, $dishId: ID!) {
      remove_recipe_from_saved_recipes(userId: $userId, dishId: $dishId) {
        deletedCount
      }
    }
  ''';
}

class RecipeGenerator {
  static String searchDishesByIngredientsQuery = r'''
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
}

class Profile {
  static String getUserById = r'''
    query($id: ID!) {
      displayUserById(id: $id) {
        username
        profilePhoto
      }
    }
  ''';

  static String getRatedRecipeById = '''
    query {
      displayUserRatedRecipeById(userId: ${otpVerification.userId}) {
        id
        userId{
          username
        }
        dishId{
          dishName
        }
        rating
        recipeRated
      }
    }
  ''';

  static String getSavedRecipeById = '''
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

  static String getAllUserUploadsById = '''
    query {
      displayUserUploadById(userId: ${otpVerification.userId}){
        userId{
          username
          profilePhoto
        }
        uploadName
        uploadImage
        uploadDescription
        uploadLikes
        creationTime
      }
    }
  ''';
}

class SavedRecipes {
  static String getSavedRecipe = '''
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

  static String getSavedRecipeCourse = '''
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
}

class RatedRecipes {
  static String getRatedRecipes = '''
    query {
      displayUserRatedRecipeById(userId: ${otpVerification.userId}) {
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
        rating
        recipeRated
      }
    }
  ''';
}

class Tips {
  static String getTips = '''
    query {
      displayUserTipById(userId: ${otpVerification.userId}) {
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
        tipDescription
        userTipImage
        recipeTiped
      }
    }
  ''';
}

class RecentlyViewedRecipes {
  static String getRecentlyViewedRecipes = '''
    query {
      displayUserRecentlyViewed(userId: ${otpVerification.userId}){
        id
        userId{
          id
          username
        }
        dishId{
          id
          dishName
          dishImage
        }
        recipeViewedTime
      }
    }
  ''';
}
