import 'package:flutter/material.dart';

import '../../constants/colors/customColors.dart';
import '../../controller/registration/registration.dart';

class registrationStep3 extends StatefulWidget {
  const registrationStep3({Key? key}) : super(key: key);

  @override
  State<registrationStep3> createState() => _registrationStep3State();
}

class _registrationStep3State extends State<registrationStep3> {
  String profilePhoto = "";

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    if (UserFormFields.userSex == "Male") {
      setState(() {
        profilePhoto = "assets/registrationPagePhotos/profileMale.png";
      });
    } else if (UserFormFields.userSex == "Female") {
      setState(() {
        profilePhoto = "assets/registrationPagePhotos/profileFemale.png";
      });
    }

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
                                onPressed: () {},
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
                                  child: Image(
                                    image: AssetImage(
                                      profilePhoto,
                                    ),
                                    fit: BoxFit.fill,
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
                "Upload your profile photo to complete your registration",
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
                  print(UserFormFields.userName);
                  print(UserFormFields.userDateOfBirth);
                  print(UserFormFields.userMobileNumber);
                  print(UserFormFields.userAddress);
                  print(UserFormFields.userEmail);
                  print(UserFormFields.userSex);
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
    );
  }
}
