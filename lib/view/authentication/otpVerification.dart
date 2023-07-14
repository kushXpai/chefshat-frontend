import 'package:chefs_hat/controller/registration/registration.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../constants/colors/customColors.dart';

class otpVerification extends StatefulWidget {
  const otpVerification({Key? key}) : super(key: key);

  @override
  State<otpVerification> createState() => _otpVerificationState();
}

class _otpVerificationState extends State<otpVerification> {
  var code = "";

  // final FirebaseAuth auth = FirebaseAuth.instance;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 20,
      color: CustomColors.white,
      fontWeight: FontWeight.w600,
      fontFamily: "Georgia",
    ),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  // final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  //   border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
  //   borderRadius: BorderRadius.circular(8),
  // );
  //
  // final submittedPinTheme = defaultPinTheme.copyWith(
  //   decoration: defaultPinTheme.decoration?.copyWith(
  //     color: Color.fromRGBO(234, 239, 243, 1),
  //   ),
  // );

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
            const Padding(
              padding: EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 10),
              child: Text(
                "Confirm your number",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: "Georgia",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 50),
              child: Text(
                "Enter the code we sent you to your number ending XXXXXX${(UserFormFields.userMobileNumber % 10000).toString()}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontFamily: "Georgia",
                ),
              ),
            ),
            Pinput(
              onChanged: (value) {
                setState(() {
                  code = value;
                });
              },
              length: 6,
              defaultPinTheme: defaultPinTheme,
              // focusedPinTheme: focusedPinTheme,
              // submittedPinTheme: submittedPinTheme,
              validator: (s) {
                return s == code ? null : 'Pin is incorrect';
              },
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              onCompleted: (pin) => print(pin),
            ),
            const Expanded(child: SizedBox()),
            SizedBox(
              height: 45,
              width: width,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'registrationStep1');
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
                  'Confirm',
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
