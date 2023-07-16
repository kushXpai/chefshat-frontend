import 'package:flutter/material.dart';

import '../../constants/colors/customColors.dart';
import '../../controller/registration/registration.dart';

class registrationStep1 extends StatefulWidget {
  const registrationStep1({Key? key}) : super(key: key);

  @override
  State<registrationStep1> createState() => _registrationStep1State();
}

class _registrationStep1State extends State<registrationStep1> {
  bool _isMaleSelected = false;
  bool _isFemaleSelected = false;

  bool _isSelectedTextBox = false;

  bool _canProceedToNextPage = false;

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
                        text: '1 of 3 ',
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
                          height: 2,
                          width: width / 3 - 20,
                          decoration: BoxDecoration(
                            color: Colors.grey,
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
                                      setState(() {
                                        _canProceedToNextPage = true;
                                      });
                                    } else if (UserFormFields.userSex != "" &&
                                        UserFormFields.userName != "") {
                                      setState(() {
                                        _canProceedToNextPage = false;
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _isMaleSelected
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
                                      setState(() {
                                        _canProceedToNextPage = true;
                                      });
                                    } else if (UserFormFields.userSex != "" &&
                                        UserFormFields.userName != "") {
                                      setState(() {
                                        _canProceedToNextPage = false;
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _isFemaleSelected
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
                  "Create your perfect profile, first choose a gender and come up with your nickname",
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
                      color:
                          _isSelectedTextBox ? Colors.transparent : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    onTap: () {
                      _isSelectedTextBox = true;
                    },
                    onChanged: (value) {
                      setState(() {
                        UserFormFields.userName = value;
                      });
                      if (UserFormFields.userSex != "" &&
                          UserFormFields.userName != "") {
                        setState(() {
                          _canProceedToNextPage = true;
                        });
                      } else if (UserFormFields.userSex != "" &&
                          UserFormFields.userName != "") {
                        setState(() {
                          _canProceedToNextPage = false;
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
                  "Must be at least four characters",
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
                    if (UserFormFields.userSex != "" &&
                        UserFormFields.userName != "") {
                      Navigator.pushNamed(context, 'registrationStep2');
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
}
