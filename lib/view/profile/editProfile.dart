import 'package:chefs_hat/view/authentication/otpVerification.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../constants/colors/Colors.dart';
import '../../controller/graphQL/graphQLClient.dart';
import '../../controller/registration/registration.dart';
import 'package:http/http.dart' as http;

class editProfile extends StatefulWidget {
  const editProfile({Key? key}) : super(key: key);

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  bool _isSelectedTextBox1 = false;
  bool _isSelectedTextBox2 = false;
  bool _isSelectedTextBox3 = false;

  bool _isMaleSelected = false;
  bool _isFemaleSelected = false;

  bool _isSelectedTextBox = false;

  updateUserProfile() async {

    const String updateUserProfile = r'''
      mutation UpdateUser(
        $userId: Int!,
        $username: String,
        $sex: String,
        $address: String,
        $emailAddress: String,
        $dateOfBirth: String
      ) {
        updateUser(
          userId: $userId,
          username: $username,
          sex: $sex,
          address: $address,
          emailAddress: $emailAddress,
          dateOfBirth: $dateOfBirth
        ) {
          user {
            id
            username
            sex
            address
            emailAddress
            dateOfBirth
          }
        }
      }
  ''';

    // Your variables
    // final Map<String, dynamic> variables = {
    //   'userId': otpVerification.userId, // Replace with the user's ID
    //   'username': UserFormFields.userName,
    //   'sex': UserFormFields.userSex,
    //   'address': UserFormFields.userAddress,
    //   'email': UserFormFields.userEmail,
    //   'dateOfBirth': UserFormFields.userDateOfBirth,
    // };

    final Map<String, dynamic> variables = {
      'userId': 1, // Convert the String to an int
      'username': UserFormFields.userName,
      'sex': UserFormFields.userSex,
      'address': UserFormFields.userAddress,
      'emailAddress': UserFormFields.userEmail,
      'dateOfBirth': UserFormFields.userDateOfBirth,
    };

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink, // Replace with your GraphQL API endpoint
    );

    try {
      final QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(updateUserProfile),
          variables: variables,
        ),
      );

      if (result.hasException) {
        // Handle error here
        print("Mutation error: ${result.exception}");

        // Check if it's an HttpException
        if (result.exception is HttpLinkServerException) {
          final HttpLinkServerException httpException =
          result.exception as HttpLinkServerException;
          final response = httpException.response;
          print("Response Status Code: ${response?.statusCode}");
          print("Response Body: ${response?.body}");
        }
      } else {
        // Mutation was successful, you can access data here if needed
        final Map<String, dynamic>? responseData =
        result.data?['addDishToRatedRecipe']['ratingRecipe'];
        print('Dish added to rated recipe.');
        // You can access fields from responseData, e.g., responseData['id']
      }
    } catch (error) {
      print("An error occurred: $error");
    }
  }

  // Future<void> updateUserProfile1() async {
  //   const String updateUser = r'''
  //     mutation UpdateUser(
  //       $userId: ID!,
  //       $username: String,
  //       $sex: String,
  //       $address: String,
  //       $emailAddress: String,
  //       $dateOfBirth: String
  //     ) {
  //       updateUser(
  //         userId: $userId,
  //         username: $username,
  //         sex: $sex,
  //         address: $address,
  //         emailAddress: $emailAddress,
  //         dateOfBirth: $dateOfBirth
  //       ) {
  //         user {
  //           id
  //           username
  //           sex
  //           address
  //           emailAddress
  //           dateOfBirth
  //         }
  //       }
  //     }
  // ''';
  //
  //   final MutationOptions options = MutationOptions(
  //     document: gql(updateUser),
  //     variables: {
  //       'id': otpVerification.userId, // Replace with the user's ID
  //       'username': UserFormFields.userName,
  //       'sex': UserFormFields.userSex,
  //       'address': UserFormFields.userAddress,
  //       'email': UserFormFields.userEmail,
  //       'dateOfBirth': UserFormFields.userDateOfBirth,
  //     },
  //   );
  //
  //   final QueryResult result = await GraphQLProvider.of(context).value.mutate(options);
  //
  //   if (result.hasException) {
  //     print('Error updating user: ${result.exception.toString()}');
  //     // Handle error, e.g., show an error message to the user
  //   } else {
  //     print('User updated successfully.');
  //     // Optionally, you can show a success message or navigate to another screen
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 80, bottom: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 30),
                child: Text(
                  "Update Profile",
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
                            width: width / 2 - 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isMaleSelected = !_isMaleSelected;
                                      _isFemaleSelected = false;
                                    });
                                    if (_isMaleSelected = true) {
                                      setState(() {
                                        UserFormFields.userSex = "MALE";
                                      });
                                    } else if (_isMaleSelected = false) {
                                      setState(() {
                                        UserFormFields.userSex = "";
                                      });
                                    }
                                    if (UserFormFields.userSex != "" &&
                                        UserFormFields.userName != "") {
                                    } else if (UserFormFields.userSex != "" &&
                                        UserFormFields.userName != "") {}
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _isMaleSelected || UserFormFields.userSex == 'MALE'
                                        ? Colors.lime
                                        : Colors.transparent,
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
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/registrationPagePhotos/Male.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      left: 0, right: 0, top: 10, bottom: 0),
                                  child: Text(
                                    "Male",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: "Georgia",
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, top: 0, bottom: 0),
                        child: Container(
                            width: width / 2 - 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isFemaleSelected = !_isFemaleSelected;
                                      _isMaleSelected = false;
                                    });
                                    if (_isFemaleSelected = true) {
                                      setState(() {
                                        UserFormFields.userSex = "FEMALE";
                                      });
                                    } else if (_isFemaleSelected = false) {
                                      setState(() {
                                        UserFormFields.userSex = "";
                                      });
                                    }
                                    if (UserFormFields.userSex != "" &&
                                        UserFormFields.userName != "") {
                                    } else if (UserFormFields.userSex != "" &&
                                        UserFormFields.userName != "") {
                                      ;
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _isFemaleSelected || UserFormFields.userSex == 'FEMALE'
                                        ? Colors.lime
                                        : Colors.transparent,
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
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/registrationPagePhotos/Female.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      left: 0, right: 0, top: 10, bottom: 0),
                                  child: Text(
                                    "Female",
                                    style: TextStyle(
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
                  "Update your profile, first choose a gender and come up with your nickname",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontFamily: "Georgia",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 0, top: 0, bottom: 10),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          _isSelectedTextBox ? Colors.transparent : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    initialValue: UserFormFields.userName,
                    onTap: () {
                      _isSelectedTextBox = true;
                    },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        UserFormFields.userName = value;
                      });
                      if (UserFormFields.userSex != "" &&
                          UserFormFields.userName != "") {
                      } else if (UserFormFields.userSex != "" &&
                          UserFormFields.userName != "") {}
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
                          color: Colors.white, // Set border color to grey
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors
                              .grey, // Set border color to white when focused
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 50),
                child: Text(
                  "Must be at least four characters",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontFamily: "Georgia",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 30),
                child: Text(
                  "Enter your date of birth",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontFamily: "Georgia",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 0, top: 0, bottom: 30),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _isSelectedTextBox1
                          ? Colors.transparent
                          : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    initialValue: UserFormFields.userDateOfBirth,
                    onTap: () {
                      _isSelectedTextBox1 = true;
                    },
                    onChanged: (value) {
                      setState(() {
                        UserFormFields.userDateOfBirth = value;
                      });
                      if (UserFormFields.userDateOfBirth != "" &&
                          UserFormFields.userEmail != "" &&
                          UserFormFields.userAddress != "") {
                      } else if (UserFormFields.userDateOfBirth != "" &&
                          UserFormFields.userEmail != "" &&
                          UserFormFields.userAddress != "") {}
                    },
                    keyboardType: TextInputType.datetime,
                    style: const TextStyle(
                      color: Colors.white, // Set text color to white
                    ),
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      labelStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white, // Set border color to grey
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors
                              .grey, // Set border color to white when focused
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 30),
                child: Text(
                  "Enter your email address",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontFamily: "Georgia",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 0, top: 0, bottom: 30),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _isSelectedTextBox2
                          ? Colors.transparent
                          : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    initialValue: UserFormFields.userEmail,
                    onTap: () {
                      _isSelectedTextBox2 = true;
                    },
                    onChanged: (value) {
                      setState(() {
                        UserFormFields.userEmail = value;
                      });
                      if (UserFormFields.userDateOfBirth != "" &&
                          UserFormFields.userEmail != "" &&
                          UserFormFields.userAddress != "") {
                      } else if (UserFormFields.userDateOfBirth != "" &&
                          UserFormFields.userEmail != "" &&
                          UserFormFields.userAddress != "") {}
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      color: Colors.white, // Set text color to white
                    ),
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      labelStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white, // Set border color to grey
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors
                              .grey, // Set border color to white when focused
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 30),
                child: Text(
                  "Enter your home address",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontFamily: "Georgia",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 0, top: 0, bottom: 30),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _isSelectedTextBox3
                          ? Colors.transparent
                          : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    initialValue: UserFormFields.userAddress,
                    onTap: () {
                      _isSelectedTextBox3 = true;
                    },
                    onChanged: (value) {
                      setState(() {
                        UserFormFields.userAddress = value;
                      });
                      if (UserFormFields.userDateOfBirth != "" &&
                          UserFormFields.userEmail != "" &&
                          UserFormFields.userAddress != "") {
                      } else if (UserFormFields.userDateOfBirth != "" &&
                          UserFormFields.userEmail != "" &&
                          UserFormFields.userAddress != "") {}
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      color: Colors.white, // Set text color to white
                    ),
                    decoration: InputDecoration(
                      labelText: 'Home Address',
                      labelStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white, // Set border color to grey
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors
                              .grey, // Set border color to white when focused
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 0, top: 0, bottom: 30),
                child: SizedBox(
                  height: 45,
                  width: width,
                  child: ElevatedButton(
                    onPressed: () async {
                      print(UserFormFields.userName);
                      print(UserFormFields.userDateOfBirth);
                      print(UserFormFields.userAddress);
                      print(UserFormFields.userEmail);
                      print(UserFormFields.userSex);

                      await updateUserProfile();

                      Navigator.pushNamed(context, 'profile');
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
                      'Update',
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black,
                      ),
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
}
