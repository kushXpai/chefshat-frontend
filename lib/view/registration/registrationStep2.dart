// import 'package:flutter/material.dart';
//
// import '../../constants/colors/Colors.dart';
// import '../../controller/registration/registration.dart';
//
// class registrationStep2 extends StatefulWidget {
//   const registrationStep2({Key? key}) : super(key: key);
//
//   @override
//   State<registrationStep2> createState() => _registrationStep2State();
// }
//
// class _registrationStep2State extends State<registrationStep2> {
//   bool _isSelectedTextBox1 = false;
//   bool _isSelectedTextBox2 = false;
//   bool _isSelectedTextBox3 = false;
//
//   bool _canProceedToNextPage = false;
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
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           height: height,
//           width: width,
//           padding:
//               const EdgeInsets.only(left: 20, right: 20, top: 90, bottom: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                     left: 0, right: 0, top: 0, bottom: 10),
//                 child: RichText(
//                   text: const TextSpan(
//                     text: 'Step ',
//                     style: TextStyle(
//                       fontFamily: 'Georgia',
//                       fontSize: 12,
//                       color: Colors.grey,
//                     ),
//                     children: [
//                       TextSpan(
//                         text: '2 of 3 ',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   textAlign: TextAlign.center,
//                   maxLines: 3,
//                 ),
//               ),
//               Padding(
//                   padding: const EdgeInsets.only(
//                       left: 0, right: 0, top: 0, bottom: 30),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             left: 0, right: 10, top: 0, bottom: 0),
//                         child: Container(
//                           height: 4,
//                           width: width / 3 - 20,
//                           decoration: BoxDecoration(
//                             color: Colors.lime,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             left: 0, right: 10, top: 0, bottom: 0),
//                         child: Container(
//                           height: 4,
//                           width: width / 3 - 20,
//                           decoration: BoxDecoration(
//                             color: Colors.lime,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             left: 0, right: 0, top: 0, bottom: 0),
//                         child: Container(
//                           height: 2,
//                           width: width / 3 - 20,
//                           decoration: BoxDecoration(
//                             color: Colors.grey,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )),
//               const Padding(
//                 padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 30),
//                 child: Text(
//                   "Create a Profile",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 30,
//                     fontFamily: "Georgia",
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 30),
//                 child: Text(
//                   "Enter your date of birth",
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 15,
//                     fontFamily: "Georgia",
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                     left: 0, right: 0, top: 0, bottom: 30),
//                 child: Container(
//                   height: 55,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: _isSelectedTextBox1
//                           ? Colors.transparent
//                           : Colors.grey,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: TextField(
//                     onTap: () {
//                       _isSelectedTextBox1 = true;
//                     },
//                     onChanged: (value) {
//                       setState(() {
//                         UserFormFields.userDateOfBirth = value;
//                       });
//                       if (UserFormFields.userDateOfBirth != "" &&
//                           UserFormFields.userEmail != "" &&
//                           UserFormFields.userAddress != "") {
//                         setState(() {
//                           _canProceedToNextPage = true;
//                         });
//                       } else if (UserFormFields.userDateOfBirth != "" &&
//                           UserFormFields.userEmail != "" &&
//                           UserFormFields.userAddress != "") {
//                         setState(() {
//                           _canProceedToNextPage = false;
//                         });
//                       }
//                     },
//                     keyboardType: TextInputType.datetime,
//                     style: const TextStyle(
//                       color: Colors.white, // Set text color to white
//                     ),
//                     decoration: InputDecoration(
//                       labelText: 'Date of Birth',
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
//                 padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 30),
//                 child: Text(
//                   "Enter your email address",
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 15,
//                     fontFamily: "Georgia",
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                     left: 0, right: 0, top: 0, bottom: 30),
//                 child: Container(
//                   height: 55,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: _isSelectedTextBox2
//                           ? Colors.transparent
//                           : Colors.grey,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: TextField(
//                     onTap: () {
//                       _isSelectedTextBox2 = true;
//                     },
//                     onChanged: (value) {
//                       setState(() {
//                         UserFormFields.userEmail = value;
//                       });
//                       if (UserFormFields.userDateOfBirth != "" &&
//                           UserFormFields.userEmail != "" &&
//                           UserFormFields.userAddress != "") {
//                         setState(() {
//                           _canProceedToNextPage = true;
//                         });
//                       } else if (UserFormFields.userDateOfBirth != "" &&
//                           UserFormFields.userEmail != "" &&
//                           UserFormFields.userAddress != "") {
//                         setState(() {
//                           _canProceedToNextPage = false;
//                         });
//                       }
//                     },
//                     keyboardType: TextInputType.emailAddress,
//                     style: const TextStyle(
//                       color: Colors.white, // Set text color to white
//                     ),
//                     decoration: InputDecoration(
//                       labelText: 'Email Address',
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
//                 padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 30),
//                 child: Text(
//                   "Enter your home address",
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 15,
//                     fontFamily: "Georgia",
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                     left: 0, right: 0, top: 0, bottom: 30),
//                 child: Container(
//                   height: 55,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: _isSelectedTextBox3
//                           ? Colors.transparent
//                           : Colors.grey,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: TextField(
//                     onTap: () {
//                       _isSelectedTextBox3 = true;
//                     },
//                     onChanged: (value) {
//                       setState(() {
//                         UserFormFields.userAddress = value;
//                       });
//                       if (UserFormFields.userDateOfBirth != "" &&
//                           UserFormFields.userEmail != "" &&
//                           UserFormFields.userAddress != "") {
//                         setState(() {
//                           _canProceedToNextPage = true;
//                         });
//                       } else if (UserFormFields.userDateOfBirth != "" &&
//                           UserFormFields.userEmail != "" &&
//                           UserFormFields.userAddress != "") {
//                         setState(() {
//                           _canProceedToNextPage = false;
//                         });
//                       }
//                     },
//                     keyboardType: TextInputType.emailAddress,
//                     style: const TextStyle(
//                       color: Colors.white, // Set text color to white
//                     ),
//                     decoration: InputDecoration(
//                       labelText: 'Home Address',
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
//               const Expanded(child: SizedBox()),
//               SizedBox(
//                 height: 45,
//                 width: width,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (UserFormFields.userDateOfBirth != "" &&
//                         UserFormFields.userEmail != "" &&
//                         UserFormFields.userAddress != "") {
//                       Navigator.pushNamed(context, 'registrationStep3');
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor:
//                         _canProceedToNextPage ? Colors.lime : Colors.grey,
//                     shadowColor: Colors.transparent,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       side: BorderSide(
//                         color:
//                             _canProceedToNextPage ? Colors.lime : Colors.grey,
//                       ),
//                     ),
//                   ),
//                   child: Text(
//                     'Next Step',
//                     style: TextStyle(
//                       fontFamily: 'Georgia',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17,
//                       color:
//                           _canProceedToNextPage ? Colors.black : Colors.white,
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

import 'package:flutter/material.dart';

import '../../constants/colors/Colors.dart';
import '../../controller/registration/registration.dart';

class registrationStep2 extends StatefulWidget {
  const registrationStep2({Key? key}) : super(key: key);

  @override
  State<registrationStep2> createState() => _registrationStep2State();
}

class _registrationStep2State extends State<registrationStep2> {
  bool _isSelectedTextBox1 = false;
  bool _isSelectedTextBox2 = false;
  bool _isSelectedTextBox3 = false;

  bool _canProceedToNextPage = false;

  bool _validateDateOfBirth(String input) {
    // Use a regular expression to validate the date of birth format 'YYYY-MM-DD'
    final RegExp dateOfBirthRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    return dateOfBirthRegex.hasMatch(input);
  }

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        UserFormFields.userDateOfBirth = picked.toLocal().toString().split(' ')[0];
      });
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
                        text: '2 of 3 ',
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
                        height: 2,
                        width: width / 3 - 20,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
              const Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 30),
                child: Text(
                  "Enter your date of birth (YYYY-MM-DD)",
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
                child: GestureDetector(
                  onTap: () {
                    _isSelectedTextBox1 = true;
                    _selectDate(context); // Show the date picker
                  },
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedDate != null
                                ? _selectedDate!.toLocal().toString().split(' ')[0]
                                : 'Date of Birth',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
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
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _isSelectedTextBox2
                          ? Colors.transparent
                          : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    // Wrap your TextField in a Column to display the error message
                    children: [
                      TextField(
                        onTap: () {
                          _isSelectedTextBox2 = true;
                        },
                        onChanged: (value) {
                          setState(() {
                            UserFormFields.userEmail = value;
                          });
                          if (_validateDateOfBirth(
                                  UserFormFields.userDateOfBirth) &&
                              _validateEmail(UserFormFields.userEmail) &&
                              UserFormFields.userAddress.isNotEmpty) {
                            setState(() {
                              _canProceedToNextPage = true;
                            });
                          } else {
                            setState(() {
                              _canProceedToNextPage = false;
                            });
                          }
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
                      if (!_validateEmail(UserFormFields.userEmail) &&
                          UserFormFields.userEmail.isNotEmpty)
                        Text(
                          'Invalid email address',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12, // Adjust the font size as needed
                          ),
                        ),
                    ],
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
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _isSelectedTextBox3
                          ? Colors.transparent
                          : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        onTap: () {
                          setState(() {
                            _isSelectedTextBox3 =
                                true; // Set the flag when the text field is tapped
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            UserFormFields.userAddress = value;
                          });
                          if (_isSelectedTextBox3 && // Check if the text field is selected
                              _validateDateOfBirth(
                                  UserFormFields.userDateOfBirth) &&
                              _validateEmail(UserFormFields.userEmail) &&
                              _validateHomeAddress(
                                  UserFormFields.userAddress)) {
                            setState(() {
                              _canProceedToNextPage = true;
                            });
                          } else {
                            setState(() {
                              _canProceedToNextPage = false;
                            });
                          }
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
                      if (_isSelectedTextBox3 && // Check if the text field is selected
                          !_validateHomeAddress(UserFormFields.userAddress) &&
                          UserFormFields.userAddress.isNotEmpty)
                        Text(
                          'Address must be at least 20 characters',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12, // Adjust the font size as needed
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                height: 45,
                width: width,
                child: ElevatedButton(
                  onPressed: () {
                    if (_canProceedToNextPage) {
                      Navigator.pushNamed(context, 'registrationStep3');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _canProceedToNextPage ? Colors.lime : Colors.grey,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                        color:
                            _canProceedToNextPage ? Colors.lime : Colors.grey,
                      ),
                    ),
                  ),
                  child: Text(
                    'Next Step',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color:
                          _canProceedToNextPage ? Colors.black : Colors.white,
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

  bool _validateEmail(String input) {
    final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(input);
  }

  bool _validateHomeAddress(String input) {
    return input.isNotEmpty && input.length >= 20;
  }
}
