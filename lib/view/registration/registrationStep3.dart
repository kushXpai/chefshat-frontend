import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/colors/customColors.dart';
import '../../controller/graphQL/graphQLClient.dart';
import '../../controller/registration/registration.dart';

class registrationStep3 extends StatefulWidget {
  const registrationStep3({Key? key}) : super(key: key);

  @override
  State<registrationStep3> createState() => _registrationStep3State();
}

class _registrationStep3State extends State<registrationStep3> {
  String profilePhoto = "";

  File? file;
  ImagePicker image = ImagePicker();

  getImageFromGallery() async {
    // ignore: deprecated_member_use
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }

  getImageFromCamera() async {
    // ignore: deprecated_member_use
    var img = await image.pickImage(source: ImageSource.camera);
    setState(() {
      file = File(img!.path);
    });
  }

  Future<void> _createUser() async {
    final String createUserMutation = '''
      mutation{
        createUser(
          username: "${UserFormFields.userName}", 
          sex: "${UserFormFields.userSex}", 
          mobileNumber: "${UserFormFields.userMobileNumber}", 
          emailAddress: "${UserFormFields.userEmail}", 
          dateOfBirth: "${UserFormFields.userDateOfBirth}", 
          address: "${UserFormFields.userAddress}", 
          profilePhoto: "${file?.path ?? ''}"
        ) {
          user {
            id
            username
            sex
            mobileNumber
            emailAddress
            dateOfBirth
            address
            profilePhoto
          }
        }
      }
    ''';

    final GraphQLClient _client = client.value;

    final MutationOptions options = MutationOptions(
      document: gql(createUserMutation),
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
      print('Error creating user: ${result.exception.toString()}');
    } else {
      print('User created successfully!');
      // Clear form fields after successful user creation
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    if (UserFormFields.userSex == "MALE") {
      setState(() {
        profilePhoto = "assets/registrationPagePhotos/profileMale1.png";
      });
    } else if (UserFormFields.userSex == "FEMALE") {
      setState(() {
        profilePhoto = "assets/registrationPagePhotos/profileFemale1.png";
      });
    }

    return Scaffold(
      backgroundColor: CustomColors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            padding: const EdgeInsets.all(0),
          ),
          child: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 90, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 0, top: 0, bottom: 10),
                child: RichText(
                  text: const TextSpan(
                    text: 'Step ',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    children: [
                      TextSpan(
                        text: '3 of 3 ',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 0, bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 10, top: 0, bottom: 0),
                        child: Container(
                          height: 4,
                          width: width / 3 - 20,
                          decoration: BoxDecoration(
                            color: Colors.lime,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 10, top: 0, bottom: 0),
                        child: Container(
                          height: 4,
                          width: width / 3 - 20,
                          decoration: BoxDecoration(
                            color: Colors.lime,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, top: 0, bottom: 0),
                        child: Container(
                          height: 4,
                          width: width / 3 - 20,
                          decoration: BoxDecoration(
                            color: Colors.lime,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  )),
              const Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 30),
                child: Text(
                  "Create a Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: "Georgia",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 0, bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, top: 0, bottom: 0),
                        child: Container(
                            width: width / 1.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    _showBottomSheet(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: const BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: file == null
                                        ? Image(
                                            image: AssetImage(
                                              profilePhoto,
                                            ),
                                            fit: BoxFit.fill,
                                            width: width / 1.5,
                                            height: width / 1.5,
                                          )
                                        : Image.file(
                                            file!,
                                            fit: BoxFit.fill,
                                            width: width / 1.5,
                                            height: width / 1.5,
                                          ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 0, top: 10, bottom: 0),
                                  child: Text(
                                    UserFormFields.userName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: "Georgia",
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  )),
              const Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 30),
                child: Text(
                  "Click the above image to upload your profile photo to complete your registration",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontFamily: "Georgia",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                height: 45,
                width: width,
                child: ElevatedButton(
                  onPressed: () {
                    _createUser();
                    print(UserFormFields.userName);
                    print(UserFormFields.userDateOfBirth);
                    print(UserFormFields.userMobileNumber);
                    print(UserFormFields.userAddress);
                    print(UserFormFields.userEmail);
                    print(UserFormFields.userSex);
                    Navigator.pushNamed(context, 'test');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lime,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(
                        color: Colors.lime,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Finish',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
                getImageFromCamera();
                // Handle take photo option
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                getImageFromGallery();
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