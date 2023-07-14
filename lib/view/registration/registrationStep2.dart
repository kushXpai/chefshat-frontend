import 'package:flutter/material.dart';

import '../../constants/colors/customColors.dart';
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

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: CustomColors.black,
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 30,
              width: 70,
              child: ElevatedButton(
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lime,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(
                      color: Colors.lime,
                    ),
                  ),
                  padding: const EdgeInsets.all(0),
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 10),
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
              padding:
                  const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 30),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        _isSelectedTextBox1 ? Colors.transparent : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onTap: () {
                    _isSelectedTextBox1 = true;
                  },
                  onChanged: (value) {
                    setState(() {
                      UserFormFields.userDateOfBirth = value;
                    });
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
              padding:
                  const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 30),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        _isSelectedTextBox2 ? Colors.transparent : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onTap: () {
                    _isSelectedTextBox2 = true;
                  },
                  onChanged: (value) {
                    setState(() {
                      UserFormFields.userEmail = value;
                    });
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
              padding:
                  const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 30),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        _isSelectedTextBox3 ? Colors.transparent : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onTap: () {
                    _isSelectedTextBox3 = true;
                  },
                  onChanged: (value) {
                    setState(() {
                      UserFormFields.userAddress = value;
                    });
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
            const Expanded(child: SizedBox()),
            SizedBox(
              height: 45,
              width: width,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'registrationStep3');
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
                  'Next Step',
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
    );
  }
}
