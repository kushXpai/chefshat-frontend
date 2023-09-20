import 'package:flutter/material.dart';
import '../../constants/colors/Colors.dart';
import '../../controller/registration/registration.dart';

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

                      Navigator.pushNamed(context, '');
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
