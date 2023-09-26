import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import '../../constants/colors/Colors.dart';
import '../../controller/graphQL/graphQLClient.dart';
import '../../controller/registration/registration.dart';
import '../../utils/sharedPreferences.dart';

class signIn extends StatefulWidget {
  const signIn({Key? key}) : super(key: key);

  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
  String userMobileNumber = "";
  String userPassword = "";

  // Track if both conditions are met for enabling the button.
  bool isMobileValid = false;
  bool isPasswordValid = false;

  static Future<int> _getUsersCountByMobileNumberAndPassword(String mobileNumber, String password) async {
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      ),
    );

    final String getUsersCountQuery = '''
    query GetUsersCount(\$mobileNumber: String!, \$password: String!) {
      countUsersByMobileAndPassword(mobileNumber: \$mobileNumber, password: \$password)
    }
  ''';

    final QueryOptions options = QueryOptions(
      document: gql(getUsersCountQuery),
      variables: {'mobileNumber': mobileNumber, 'password': password},
    );

    try {
      final QueryResult result = await client.value.query(options);

      if (result.hasException) {
        throw result.exception!;
      }

      final int userCount = result.data?['countUsersByMobileAndPassword'] ?? 0;
      return userCount;
    } catch (error) {
      throw error;
    }
  }

  Future<int> _getUserId(String mobileNumber, String password) async {

    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      ),
    );

    final String getUsersCountQuery = '''
      query(\$mobileNumber: String!, \$password: String!) {
        displayUserByMobileNumberAndPassword(mobileNumber: \$mobileNumber, password: \$password) {
          id
          username
        }
      }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(getUsersCountQuery),
      variables: {'mobileNumber': mobileNumber, 'password': password},
    );

    try {
      final QueryResult result = await client.value.query(options);

      if (result.hasException) {
        throw result.exception!;
      }

      final dynamic user = result.data?['displayUserByMobileNumberAndPassword'];
      if (user == null) {
        return 0; // User not found
      } else if (user is List<dynamic>) {
        final int userId = user.isNotEmpty ? int.parse(user[0]['id']) : 0;
        return userId; // Return the user ID
      } else {
        final int userId = int.parse(user['id']);
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


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // Determine if the button should be enabled based on input validation.
    bool isButtonEnabled = isMobileValid && isPasswordValid;

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
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 90,
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 0,
                  right: 0,
                  top: 20,
                  bottom: 50,
                ),
                child: Text(
                  "Enter your details to signIn.",
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
                        userMobileNumber = value;
                        UserFormFields.userMobileNumber = int.parse(value);

                        isMobileValid = value.length == 10;

                        isButtonEnabled = isMobileValid && isPasswordValid;
                      });
                    },
                    onSubmitted: (value) {
                      // Check if the submitted value has exactly 10 digits.
                      if (value.length != 10) {
                        setState(() {
                          isMobileValid = false;
                        });
                      }
                    },
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.white, // Set text color to white
                    ),
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      labelStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white, // Set border color to grey
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
                padding: EdgeInsets.only(
                  left: 10,
                  right: 0,
                  top: 0,
                  bottom: 50,
                ),
                child: Text(
                  isMobileValid ? "" : "Enter correct mobile number",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontFamily: "Georgia",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
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
                        userPassword = value;
                        UserFormFields.userPassword = value;

                        // Add your password validation logic here
                        isPasswordValid = RegExp(
                                r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$')
                            .hasMatch(value);

                        isButtonEnabled = isMobileValid && isPasswordValid;
                      });
                    },
                    keyboardType: TextInputType.text,
                    obscureText:
                        true, // This makes the input text hidden as it's a password field
                    style: const TextStyle(
                      color: Colors.white, // Set text color to white
                    ),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white, // Set border color to grey
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
                      // errorText: isPasswordValid ? null : "Enter correct password",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 0,
                  right: 10,
                  top: 0,
                  bottom: 50,
                ),
                child: Text(
                  isPasswordValid
                      ? ""
                      : "Enter correct password", // Empty string for valid password
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontFamily: "Georgia",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                height: 45,
                width: width,
                child: ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () async {
                          print(UserFormFields.userMobileNumber);
                          print(UserFormFields.userPassword);

                          int userCount = await _getUsersCountByMobileNumberAndPassword(UserFormFields.userMobileNumber.toString(), UserFormFields.userPassword);
                          print("Number of users " + userCount.toString());

                          if (userCount == 1) {
                            int userId = await _getUserId(UserFormFields.userMobileNumber.toString(), UserFormFields.userPassword);
                            setState(() {
                              UserFormFields.userId = userId;
                            });
                            print("User ID " + UserFormFields.userId.toString() + "\n\n\n\n\n\n\n\n");

                            await SharedPreferencesUtil.setLoginState(true);
                            await _storeUserId(UserFormFields.userId);

                            Navigator.pushReplacementNamed(context, 'entryPoint');
                          } else {
                            Navigator.pushNamed(context, 'registrationStep1');
                          }

                    // Navigator.pushNamed(context, 'otpVerification');
                        }
                      : null, // Disable the button if conditions aren't met.
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isButtonEnabled ? Colors.lime : Colors.black,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                        color: isButtonEnabled ? Colors.lime : Colors.black,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Send me the code',
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
}