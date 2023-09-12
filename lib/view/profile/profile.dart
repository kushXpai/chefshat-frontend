import 'dart:io';

import 'package:chefs_hat/model/profile/activity/activity.dart';
import 'package:chefs_hat/model/profile/cookbooks/cookbooks.dart';
import 'package:chefs_hat/model/profile/photos/photos.dart';
import 'package:chefs_hat/model/profile/profile.dart';
import 'package:chefs_hat/view/authentication/otpVerification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/colors/Colors.dart';
import '../../controller/graphQL/graphQLClient.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {

  XFile? _imageFile;

// Function to pick an image from the gallery.
  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);


    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

// Function to take a photo with the camera.
  Future<void> _takePhotoWithCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    File? img = File(pickedFile!.path);
    img = await _cropImage(imageFile: img);


    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }


  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
    await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }


// Widget to display the picked image.
  Widget _displayImage() {
    if (_imageFile == null) {
      return Text('No image selected.');
    } else {
      return Image.file(File(_imageFile!.path));
    }
  }


  final String getUserById = r'''
    query($id: ID!) {
      displayUserById(id: $id) {
        username
        profilePhoto
      }
    }
  ''';

  final String getRatedRecipeById = '''
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

  double conpad = 100;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;



    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'pantry');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 5, bottom: 5),
                ),
                child: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: 40,
              child: ElevatedButton(
                onPressed: () {
                  _showBottomSheet(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 5, bottom: 5),
                ),
                child: const Icon(
                  Icons.add_a_photo_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 0, bottom: 0),
                ),
                child: const Icon(
                  Icons.menu_sharp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(
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
            Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  height: height * 0.265,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 80, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GraphQLProvider(
                          client: client,
                          child: _buildUserProfileNameImage(width),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                GraphQLProvider(
                                  client: client,
                                  child: _buildUserRatings(width),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.transparent,
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    shadowColor: Colors.transparent,
                                    minimumSize: Size.zero,
                                    padding: const EdgeInsets.all(10),
                                  ),
                                  child: const Column(
                                    children: [
                                      Text(
                                        '0',
                                        style: TextStyle(
                                          fontFamily: 'Georgia',
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'comments',
                                        style: TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 15,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.transparent,
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    shadowColor: Colors.transparent,
                                    minimumSize: Size.zero,
                                    padding: const EdgeInsets.all(10),
                                  ),
                                  child: const Column(
                                    children: [
                                      Text(
                                        '0',
                                        style: TextStyle(
                                          fontFamily: 'Georgia',
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'photos',
                                        style: TextStyle(
                                          fontFamily: 'Georgia',
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Expanded(child: SizedBox())
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Stack(
                  children: [

                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: width / 3,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                profileStatics.profileIndexTabs = 0;
                                conpad = width / 3;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.all(10),
                            ),
                            child: const Column(
                              children: [
                                Text(
                                  'Photos',
                                  style: TextStyle(
                                    fontFamily: 'Georgia',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width / 3,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                profileStatics.profileIndexTabs = 1;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.all(10),
                            ),
                            child: const Column(
                              children: [
                                Text(
                                  'Cookbooks',
                                  style: TextStyle(
                                    fontFamily: 'Georgia',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width / 3,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                profileStatics.profileIndexTabs = 2;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.all(10),
                            ),
                            child: const Column(
                              children: [
                                Text(
                                  'Activity',
                                  style: TextStyle(
                                    fontFamily: 'Georgia',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    AnimatedAlign(
                      alignment: profileStatics.profileIndexTabs == 0
                          ? Alignment.centerLeft
                          : profileStatics.profileIndexTabs == 1
                          ? Alignment.center
                          : Alignment.centerRight,
                      duration: const Duration(milliseconds: 350),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Container(
                          width: conpad - 10,
                          height: 45,
                          decoration: const BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                  ],

                ),
                // const Divider(
                //   color: CustomColors.white,
                //   thickness: 1,
                // ),
                SizedBox(child: _displayImage(),),
                SizedBox(
                  height: height - 322,
                  width: width,
                  child: SingleChildScrollView(
                    child: profileStatics.profileIndexTabs == 0
                        ? const photos()
                        : profileStatics.profileIndexTabs == 1
                            ? const cookbooks()
                            : const activity(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfileNameImage(double width) {
    return SizedBox(
      child: Query(
        options: QueryOptions(
          document: gql(getUserById),
          variables: {'id': '${otpVerification.userId}'},
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

          final Map<String, dynamic>? data = result.data?['displayUserById'];

          if (data == null) {
            return const Text('No dishes found');
          }

          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                child: Center(
                  child: Container(
                    height: 95,
                    width: 95,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1)),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          NetworkImage(httpLinkImage + data['profilePhoto']),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 0, top: 10, bottom: 5),
                child: Text(
                  data['username'],
                  style: GoogleFonts.abrilFatface(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUserRatings(double width) {
    return SizedBox(
      child: Query(
        options: QueryOptions(
          document: gql(getRatedRecipeById),
          variables: {'id': '${otpVerification.userId}'},
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

          final List<dynamic> data = result.data?['displayUserRatedRecipeById'];
          int numberOfRatedRecipies = 0;
          numberOfRatedRecipies = data.length;

          if (data.isEmpty) {
            return ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: Colors.transparent,
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(10),
              ),
              child: const Column(
                children: [
                  Text(
                    '0',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'ratings',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'ratedRecipess');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: Colors.transparent,
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(10),
              ),
              child: Column(
                children: [
                  Text(
                    "$numberOfRatedRecipies",
                    style: const TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'ratings',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Take a Photo'),
              onTap: () {
                _takePhotoWithCamera();
                // Handle take photo option
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                _pickImageFromGallery();
                // Handle choose from gallery option
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
