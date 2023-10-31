import 'package:chefs_hat/view/authentication/otpVerification.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
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
  bool _isSelectedTextBox2 = false;
  bool _isSelectedTextBox3 = false;

  bool _isMaleSelected = false;
  bool _isFemaleSelected = false;

  bool _isSelectedTextBox = false;

  Future<void> updateUserProfile({
    required int userId,
    String? username,
  }) async {
    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink, // Replace with your GraphQL API endpoint
    );

    final MutationOptions options = MutationOptions(
      document: gql('''
      mutation UpdateUser(
        \$userId: Int!,
        \$username: String,
      ) {
        updateUser(
          userId: \$userId,
          username: \$username,
        ) {
          user {
            id
            username
          }
        }
      }
    '''),
      variables: {
        'userId': userId,
        'username': username,
      },
    );

    try {
      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        print("Mutation error: ${result.exception}");
        // Handle the error as needed
      } else {
        // Mutation was successful, you can access data here if needed
        final Map<String, dynamic>? responseData =
        result.data?['updateUser']['user'];
        print('User profile updated.');
        // You can access fields from responseData, e.g., responseData['id']
      }
    } catch (error) {
      print("An error occurred: $error");
    }
  }



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

            const Padding(
              padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 30),
              child: Text(
                "Update your profile, come up with your nickname",
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
                  left: 0, right: 0, top: 0, bottom: 20),
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

            Expanded(child: SizedBox()),

            Padding(
              padding: const EdgeInsets.only(
                  left: 0, right: 0, top: 0, bottom: 30),
              child: SizedBox(
                height: 45,
                width: width,
                child: ElevatedButton(
                  onPressed: () async {
                    print(UserFormFields.userName);

                    await updateUserProfile(
                      userId: UserFormFields.userId, // Pass the userId here
                      username: UserFormFields.userName,
                    );

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
    );
  }
}
