import 'dart:ui';

import 'package:chefs_hat/controller/graphQL/queries/queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../constants/colors/Colors.dart';
import '../../../controller/graphQL/graphQLClient.dart';

class uploadsGrid extends StatefulWidget {
  const uploadsGrid({Key? key}) : super(key: key);

  @override
  State<uploadsGrid> createState() => _uploadsGridState();
}

class _uploadsGridState extends State<uploadsGrid> {

  final String getUserUploadsById = Uploads.getUserUploadsById;
  // final String getUserUploadsById = '''
  //   query {
  //     displayUserUploadById(userId: ${otpVerification.userId}){
  //       id
  //       userId{
  //         username
  //         profilePhoto
  //       }
  //       uploadName
  //       uploadImage
  //       uploadDescription
  //       uploadLikes
  //       creationTime
  //     }
  //   }
  // ''';


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    return GraphQLProvider(
      client: client,
      child: _buildUserUploadsById(width, height),
    );
  }

  Widget _buildUserUploadsById(double width, double height) {
    return SizedBox(
      width: width,
      height: height - 322,

      child: Query(
        options: QueryOptions(
          document: gql(getUserUploadsById),
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

          final List<dynamic> savedRecipes = result.data?['displayUserUploadById'];

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
            return GridView.builder(
              itemCount: savedRecipes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {

                final savedRecipe = savedRecipes[index];

                // Accessing the details of the dish
                final String postId = savedRecipe['id'] ?? "";
                final String username = savedRecipe['userId']['username'];
                final String userImage = savedRecipe['userId']['profilePhoto'];
                final String uploadName = savedRecipe['uploadName'];
                final String uploadLikes = savedRecipe['uploadLikes'].toString();
                final String uploadImage = savedRecipe['uploadImage'];
                final String uploadDescription = savedRecipe['uploadDescription'];

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'photosList');
                  },
                  // onLongPress: () {
                  //   setState(() {
                  //     _showPreview = true;
                  //     _image = "assets/demoassets/${images[index]}";
                  //     _name = "${names[index]}";
                  //     print(_name);
                  //   });
                  // },
                  // onLongPressEnd: (details) {
                  //   setState(() {
                  //     _showPreview = false;
                  //   });
                  // },
                  child: Card(
                    elevation: 4,
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      httpLinkImage + uploadImage,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
