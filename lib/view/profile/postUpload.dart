import 'dart:io';
import 'package:chefs_hat/view/authentication/otpVerification.dart';
import 'package:http/http.dart' as http;
import 'package:chefs_hat/controller/registration/registration.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/colors/Colors.dart';
import '../../controller/graphQL/graphQLClient.dart';

class postUpload extends StatefulWidget {
  const postUpload({Key? key}) : super(key: key);

  @override
  State<postUpload> createState() => _postUploadState();
}

class _postUploadState extends State<postUpload> {

  final TextEditingController _controller = TextEditingController();
  bool _isFocused = false;

  String profilePhoto = "";

  File? file;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> getImageFromGallery() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        file = File(pickedFile.path);
        // registrationStep3.img = pickedFile.path; // Update the static variable
      });
    }
  }

  Future<void> getImageFromCamera() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        file = File(pickedFile.path);
        // registrationStep3.img = pickedFile.path; // Update the static variable
      });
    }
  }

  bool validate_uploadName = false;
  String uploadName = "";

  bool validate_uploadDescription = false;
  String uploadDescription = "";

  _createUserUpload() async {
    print('${httpLinkC}/userUpload/');
    var request = http.MultipartRequest('POST', Uri.parse('${httpLinkC}/userUpload/'));
    print("before send");
    request.fields.addAll({
      'userId': "1",
      'uploadLikes': "0",
      'uploadName': "a",
      'uploadDescription': "a",
    });
    print(file!.path.toString());
    request.files.add(await http.MultipartFile.fromPath('uploadImage', file!.path.toString()));
    print("after request send ");

    http.StreamedResponse response = await request.send();
    print("after awaitt");

    if (response.statusCode == 200) {
      print(response);
    }
    else {
      print(response.reasonPhrase);
    }
  }



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        title: _buildSectionHeader("Upload Photos"),
        backgroundColor: Colors.black,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 10),
              child: Center(
                child: Text('Upload Post',
                  style:  TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 25,
                      color: Colors.white
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      width: width / 10 * 8,
                      height: width / 10 * 8,
                      child: ElevatedButton(
                        onPressed: () {
                          _showBottomSheet(context);
                        },
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
                          child: file == null
                              ? Image(
                            image: const NetworkImage(
                                'https://i.pinimg.com/originals/f0/6b/c6/f06bc6fe8412a5abe9af28a808d1ede2.png',
                            ),
                            fit: BoxFit.fill,
                            width: width / 10 * 8,
                            height: width / 10 * 8,
                          )
                              : Image.file(
                            file!,
                            fit: BoxFit.cover,
                            width: width / 10 * 8,
                            height: width / 10 * 8,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    uploadName = value;
                  });
                },
                cursorColor: const Color(0xFF4EDB86),
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  labelText: 'Dish Name',
                  errorText: validate_uploadName ? 'Dish name is Required' : null,
                  border: const UnderlineInputBorder(),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    UserFormFields.userEmail = value;
                  });
                },
                cursorColor: const Color(0xFF4EDB86),
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  labelText: 'Description',
                  errorText: validate_uploadDescription ? 'Description is Required' : null,
                  border: const UnderlineInputBorder(),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 45,
                width: width,
                child: ElevatedButton(
                  onPressed: () async {
                    _createUserUpload();

                    Navigator.pushNamed(context, 'entryPoint');
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
                    'Upload',
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Take a Photo'),
              onTap: () {
                getImageFromCamera();
                // Handle take photo option
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                getImageFromGallery();
                // Handle choose from gallery option
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
