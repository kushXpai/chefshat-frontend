import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../constants/colors/Colors.dart';
import '../../controller/graphQL/graphQLClient.dart';

class community extends StatefulWidget {
  const community({Key? key}) : super(key: key);

  @override
  State<community> createState() => _communityState();
}

class _communityState extends State<community> {
  final String getAllUserUploads = '''
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: SizedBox(
              height: height,
              width: width,
              child: const Image(
                image: AssetImage(
                  'assets/backgroundPhotos/woodenBackgroundBlack.jpg',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: height,
            width: width,
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 0, right: 0, top: 50, bottom: 10),
                    child: Center(
                      child: Text(
                        'Our Community',
                        style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 25,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                    ),
                    child: GraphQLProvider(
                      client: client,
                      child: _buildAllUserUploads(width),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllUserUploads(double width) {
    return SizedBox(
      height: 783,
      child: Query(
        options: QueryOptions(
          document: gql(getAllUserUploads),
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

          final List<dynamic> savedRecipes = result.data?['displayUserUpload'];

          if (savedRecipes.isEmpty) {
            return const CircularProgressIndicator();
          } else {
            return ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: savedRecipes
                  .length, // Use the length of the saved recipes list
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                print(savedRecipes.length);
                final savedRecipe = savedRecipes[index];

                // Accessing the details of the dish
                final String username = savedRecipe['userId']['username'];
                final String userImage =
                    savedRecipe['userId']['profilePhoto'] ?? "";
                final String uploadName = savedRecipe['uploadName'];
                final String uploadImage = savedRecipe['uploadImage'];
                final String uploadDescription =
                    savedRecipe['uploadDescription'];
                print(savedRecipe['userId']['profilePhoto']);

                return Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 0, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 0, top: 0, bottom: 10),
                        child: SizedBox(
                          width: width,
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 1)),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      NetworkImage(httpLinkImage + userImage),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 0, top: 0, bottom: 0),
                                  child: Text(
                                    "$username",
                                    style: TextStyle(
                                      fontFamily: 'Georgia',
                                      fontSize: 17,
                                      color: Colors.amber[600],
                                    ),
                                  )),
                              const Expanded(child: SizedBox()),
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 0, right: 10, top: 0, bottom: 0),
                                child: Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width,
                        height: width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: Image.network(
                            httpLinkImage + uploadImage,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 0, top: 20, bottom: 10),
                        child: SizedBox(
                          width: width,
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 0, right: 10, top: 0, bottom: 0),
                                child: Icon(
                                  Icons.favorite_border_sharp,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 0, right: 10, top: 0, bottom: 0),
                                child: Icon(
                                  Icons.messenger_outline,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 0, right: 10, top: 0, bottom: 0),
                                child: Icon(
                                  Icons.bookmark_add_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 30),
                        child: Text(
                          '$uploadDescription',
                          style: const TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.white,
                          ),
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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
