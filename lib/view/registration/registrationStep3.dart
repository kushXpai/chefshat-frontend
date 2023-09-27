import 'dart:io';

import 'package:chefs_hat/controller/entryPoint/entryPoint.dart';
import 'package:chefs_hat/view/authentication/otpVerification.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../constants/colors/Colors.dart';
import '../../controller/graphQL/graphQLClient.dart';
import '../../controller/registration/registration.dart';
import '../../utils/sharedPreferences.dart';

class registrationStep3 extends StatefulWidget {
  const registrationStep3({Key? key}) : super(key: key);

  static String img = "";

  @override
  State<registrationStep3> createState() => _registrationStep3State();
}

class _registrationStep3State extends State<registrationStep3> {

  String profilePhoto = "assets/registrationPagePhotos/profileMale1.png";

  File? file;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> getImageFromGallery() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        file = File(pickedFile.path);
        // registrationStep3.img = pickedFile.path; // Update the static variable
      });
    }
  }

  Future<void> getImageFromCamera() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        file = File(pickedFile.path);
        // registrationStep3.img = pickedFile.path; // Update the static variable
      });
    }
  }

  _createUser() async {
    var request = http.MultipartRequest('POST', Uri.parse('${httpLinkC}/user/'));
    print("before send");
    request.fields.addAll({
      'username': "${UserFormFields.userName}",
      'password': "${UserFormFields.userPassword}",
      'mobileNumber': "${UserFormFields.userMobileNumber}",
    });
    print(file!.path.toString());
    request.files.add(await http.MultipartFile.fromPath('profilePhoto', file!.path.toString()));
    print("after request send ");

    http.StreamedResponse response = await request.send();
    print("after awaitt");

    if (response.statusCode == 200) {
      print(response);
    }
    else {
      print("ERROR");
      print(response.reasonPhrase);
    }
  }

  Future<int> _getUserId() async {

    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      ),
    );

    final String getUsersCountQuery = '''
      query GetUsersCount(\$mobileNumber: String!) {
        displayUserByMobileNumber(mobileNumber: \$mobileNumber) {
          id
        }
      }
    ''';

    print('UserMobileNumber: ${UserFormFields.userMobileNumber.toString()}');
    final QueryOptions options = QueryOptions(
      document: gql(getUsersCountQuery),
      variables: {'mobileNumber': UserFormFields.userMobileNumber.toString()},
    );

    try {
      final QueryResult result = await client.value.query(options);

      if (result.hasException) {
        throw result.exception!;
      }

      final dynamic user = result.data?['displayUserByMobileNumber'];
      if (user == null) {
        return 0; // User not found
      } else if (user is List<dynamic>) {
        final int userId = user.isNotEmpty ? int.parse(user[0]['id']) : 0;
        return userId; // Return the user ID
      } else {
        final int userId = int.parse(user['id']);
        print("\n\nUser Id on call inde _getUserId " + userId.toString() + "\n\n");
        return userId; // Single user found
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> _storeUserId(int userId) async {
    try {
      // Use your shared preferences utility to store the user ID
      print("OTP ${userId}");
      await SharedPreferencesUtil.setInt('userId', userId);
    } catch (error) {
      // Handle any errors that might occur during storage
      print('Error storing user ID: $error');
    }
  }

  bool isUsernameValid = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    bool isButtonEnabled = isUsernameValid;

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
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 10,
                ),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        UserFormFields.userName = value;

                        isUsernameValid = value.length > 4;

                        isButtonEnabled = isUsernameValid;
                      });
                    },
                    onSubmitted: (value) {
// Check if the submitted value has exactly 10 digits.
                      if (value.length < 4) {
                        setState(() {
                          isUsernameValid = false;
                        });
                      }
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      color: Colors.white, // Set text color to white
                    ),
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color:
                          Colors.white, // Set border color to grey
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors
                              .grey, // Set border color to white when focused
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 0,
                  top: 0,
                  bottom: 50,
                ),
                child: Text(
                  isUsernameValid ? "" : "Enter correct username",
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
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
                  onPressed: () async {
                    _createUser();

                    print(UserFormFields.userName);
                    print(UserFormFields.userMobileNumber);

                    int userId = await _getUserId();
                    setState(() {
                      UserFormFields.userId = userId;
                    });
                    print("User ID ${UserFormFields.userId}\n\n\n\n\n\n\n\n");

                    await SharedPreferencesUtil.setLoginState(true);
                    await _storeUserId(UserFormFields.userId);

                    Navigator.pushReplacementNamed(context, 'signIn');
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