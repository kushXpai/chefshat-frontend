// import 'package:chefs_hat/controller/graphQL/graphQLClient.dart';
// import 'package:chefs_hat/controller/registration/registration.dart';
// import 'package:chefs_hat/utils/sharedPreferences.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:graphql/client.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:pinput/pinput.dart';
//
// import '../../constants/colors/Colors.dart';
//
// class otpVerification extends StatefulWidget {
//   const otpVerification({Key? key}) : super(key: key);
//
//   static int userId = 0;
//
//   @override
//   State<otpVerification> createState() => _otpVerificationState();
// }
//
// class _otpVerificationState extends State<otpVerification> {
//
//   bool _isSelectedTextBox = false;
//
//   Future<void> _storeUserId(int userId) async {
//     try {
//       // Use your shared preferences utility to store the user ID
//       print("OTP ${userId}");
//       await SharedPreferencesUtil.setInt('userId', userId);
//     } catch (error) {
//       // Handle any errors that might occur during storage
//       print('Error storing user ID: $error');
//     }
//   }
//
//   static Future<int> getUsersCountByMobileNumber(String mobileNumber) async {
//     print("getUsersCountByMobileNumber");
//
//     final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
//       GraphQLClient(
//         cache: GraphQLCache(),
//         link: httpLink,
//       ),
//     );
//
//     final String getUsersCountQuery = '''
//     query GetUsersCount(\$mobileNumber: String!) {
//       displayUserByMobileNumber(mobileNumber: \$mobileNumber) {
//         id
//       }
//     }
//   ''';
//
//     final QueryOptions options = QueryOptions(
//       document: gql(getUsersCountQuery),
//       variables: {'mobileNumber': mobileNumber},
//     );
//
//     try {
//       final QueryResult result = await client.value.query(options);
//
//       if (result.hasException) {
//         throw result.exception!;
//       }
//
//       final dynamic user = result.data?['displayUserByMobileNumber'];
//       if (user == null) {
//         return 0; // User not found
//       } else if (user is List<dynamic>) {
//         return user.length; // Return the count of users
//       } else {
//         return 1; // Single user found
//       }
//     } catch (error) {
//       throw error;
//     }
//   }
//
//
//   var code = "";
//
//   final defaultPinTheme = PinTheme(
//     width: 56,
//     height: 56,
//     textStyle: const TextStyle(
//       fontSize: 20,
//       color: CustomColors.white,
//       fontWeight: FontWeight.w600,
//       fontFamily: "Georgia",
//     ),
//     decoration: BoxDecoration(
//       border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
//       borderRadius: BorderRadius.circular(20),
//     ),
//   );
//
//   // final focusedPinTheme = defaultPinTheme.copyDecorationWith(
//   //   border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
//   //   borderRadius: BorderRadius.circular(8),
//   // );
//   //
//   // final submittedPinTheme = defaultPinTheme.copyWith(
//   //   decoration: defaultPinTheme.decoration?.copyWith(
//   //     color: Color.fromRGBO(234, 239, 243, 1),
//   //   ),
//   // );
//
//   Future<int> _getUserId() async {
//
//     final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
//       GraphQLClient(
//         cache: GraphQLCache(),
//         link: httpLink,
//       ),
//     );
//
//     final String getUsersCountQuery = '''
//       query GetUsersCount(\$mobileNumber: String!) {
//         displayUserByMobileNumber(mobileNumber: \$mobileNumber) {
//           id
//         }
//       }
//     ''';
//
//     print('UserMobileNumber: ${UserFormFields.userMobileNumber.toString()}');
//     final QueryOptions options = QueryOptions(
//       document: gql(getUsersCountQuery),
//       variables: {'mobileNumber': UserFormFields.userMobileNumber.toString()},
//     );
//
//     try {
//       final QueryResult result = await client.value.query(options);
//
//       if (result.hasException) {
//         throw result.exception!;
//       }
//
//       final dynamic user = result.data?['displayUserByMobileNumber'];
//       if (user == null) {
//         return 0; // User not found
//       } else if (user is List<dynamic>) {
//         final int userId = user.isNotEmpty ? int.parse(user[0]['id']) : 0;
//         return userId; // Return the user ID
//       } else {
//         final int userId = int.parse(user['id']);
//         return userId; // Single user found
//       }
//     } catch (error) {
//       throw error;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: CustomColors.black,
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         leading: ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.transparent,
//             shadowColor: Colors.transparent,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30),
//               side: const BorderSide(
//                 color: Colors.transparent,
//               ),
//             ),
//             padding: const EdgeInsets.all(0),
//           ),
//           child: const Icon(Icons.arrow_back),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             SizedBox(
//               height: 30,
//               width: 70,
//               child: ElevatedButton(
//                 onPressed: () async {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.lime,
//                   shadowColor: Colors.transparent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     side: const BorderSide(
//                       color: Colors.lime,
//                     ),
//                   ),
//                   padding: const EdgeInsets.all(0),
//                 ),
//                 child: const Text(
//                   'Sign In',
//                   style: TextStyle(
//                     fontFamily: 'Georgia',
//                     fontWeight: FontWeight.bold,
//                     fontSize: 13,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           height: height,
//           width: width,
//           padding: const EdgeInsets.only(left: 20, right: 20, top: 90, bottom: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 10),
//                 child: Text(
//                   "Enter your password",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 30,
//                     fontFamily: "Georgia",
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               // Padding(
//               //   padding:
//               //       const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 50),
//               //   child: Text(
//               //     "Enter the code we sent you to your number ending XXXXXX${(UserFormFields.userMobileNumber % 10000).toString()}",
//               //     style: const TextStyle(
//               //       color: Colors.grey,
//               //       fontSize: 15,
//               //       fontFamily: "Georgia",
//               //     ),
//               //   ),
//               // ),
//               // Pinput(
//               //   onChanged: (value) {
//               //     setState(() {
//               //       code = value;
//               //     });
//               //   },
//               //   length: 6,
//               //   defaultPinTheme: defaultPinTheme,
//               //   // focusedPinTheme: focusedPinTheme,
//               //   // submittedPinTheme: submittedPinTheme,
//               //   validator: (s) {
//               //     return s == code ? null : 'Pin is incorrect';
//               //   },
//               //   pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
//               //   showCursor: true,
//               //   onCompleted: (pin) => print(pin),
//               // ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                     left: 0, right: 0, top: 0, bottom: 10),
//                 child: Container(
//                   height: 55,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color:
//                       _isSelectedTextBox ? Colors.transparent : Colors.grey,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: TextFormField(
//                     onTap: () {
//                       _isSelectedTextBox = true;
//                     },
//                     onChanged: (value) {
//                       setState(() {
//                         UserFormFields.userPassword = value;
//                       });
//                     },
//                     keyboardType: TextInputType.text,
//                     obscureText: true, // This makes it a password field
//                     style: const TextStyle(
//                       color: Colors.white, // Set text color to white
//                     ),
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       labelStyle: const TextStyle(
//                         color: Colors.white,
//                       ),
//                       border: OutlineInputBorder(
//                         borderSide: const BorderSide(
//                           color: Colors.white, // Set border color to grey
//                         ),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(
//                           color: Colors
//                               .grey, // Set border color to white when focused
//                         ),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 50),
//                 child: Text(
//                   "Must be at least eight characters",
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 15,
//                     fontFamily: "Georgia",
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const Expanded(child: SizedBox()),
//               SizedBox(
//                 height: 45,
//                 width: width,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     var len = await getUsersCountByMobileNumber(UserFormFields.userMobileNumber.toString());
//                     print(len);
//
//                     // Check if the password is not empty and has at least 8 characters
//                     if (UserFormFields.userPassword.isNotEmpty && UserFormFields.userPassword.length >= 8) {
//                       if (len == 1) {
//                         int userId = await _getUserId();
//
//                         // Store the user ID in shared preferences
//
//                         setState(() {
//                           otpVerification.userId = userId;
//                         });
//                         _storeUserId(otpVerification.userId);
//                         print(UserFormFields.userMobileNumber);
//                         print(otpVerification.userId);
//                         await SharedPreferencesUtil.setLoginState(true);
//                         Navigator.pushNamed(context, 'entryPoint');
//                       } else if (len == 0) {
//                         print("XXX");
//                         Navigator.pushNamed(context, 'registrationStep1');
//                       }
//                     } else if (UserFormFields.userPassword.isEmpty || UserFormFields.userPassword.length <= 8) {
//                       // Password is empty or less than 8 characters
//                       // Display an error message in an AlertDialog
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             title: Text("Invalid Password"),
//                             content: Text("Password must be at least eight characters."),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                                 child: Text("OK"),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     }
//                   },
//
//
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.lime,
//                     shadowColor: Colors.transparent,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       side: const BorderSide(
//                         color: Colors.lime,
//                       ),
//                     ),
//                   ),
//                   child: const Text(
//                     'Confirm',
//                     style: TextStyle(
//                       fontFamily: 'Georgia',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
