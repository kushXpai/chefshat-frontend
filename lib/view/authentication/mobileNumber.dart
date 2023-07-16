import 'package:chefs_hat/controller/registration/registration.dart';
import 'package:flutter/material.dart';

import '../../constants/colors/customColors.dart';
import '../../controller/authentication/mobileNumber.dart';

class mobileNumber extends StatefulWidget {
  const mobileNumber({Key? key}) : super(key: key);

  @override
  State<mobileNumber> createState() => _mobileNumberState();
}

class _mobileNumberState extends State<mobileNumber> {
  var userMobileNumber = "";
  bool _isSelectedTextBox = false;

  @override
  void initState() {
    // TODO: implement initState
    countryCode.text = "+91";
    super.initState();
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
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 90, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 10),
                child: Text(
                  "Enter your mobile number",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: "Georgia",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 50),
                child: Text(
                  "We will send an OTP for verification",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontFamily: "Georgia",
                  ),
                ),
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _isSelectedTextBox ? Colors.transparent : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  onTap: () {
                    _isSelectedTextBox = true;
                  },
                  onChanged: (value) {
                    setState(() {
                      userMobileNumber = value;
                      UserFormFields.userMobileNumber = int.parse(value);
                    });
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
                        color:
                            Colors.grey, // Set border color to white when focused
                      ),
                      borderRadius: BorderRadius.circular(30),
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
                    Navigator.pushNamed(context, 'otpVerification');
                  },
                  // onPressed: () async {
                  //   Navigator.pushNamed(context, 'otp');
                  //   await FirebaseAuth.instance.verifyPhoneNumber(
                  //     phoneNumber: '${countrycode.text+phone}',
                  //     verificationCompleted: (PhoneAuthCredential credential) {},
                  //     verificationFailed: (FirebaseAuthException e) {},
                  //     codeSent: (String verificationId, int? resendToken) {
                  //       MyPhone.verify = verificationId;
                  //       Navigator.pushNamed(context, "otp");
                  //     },
                  //     codeAutoRetrievalTimeout: (String verificationId) {},
                  //   );
                  // },
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
