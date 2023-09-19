import 'package:chefs_hat/view/authentication/otpVerification.dart';

class Uploads {

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