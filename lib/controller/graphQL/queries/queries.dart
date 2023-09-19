import 'package:chefs_hat/view/authentication/otpVerification.dart';

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

class Dishes {
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
