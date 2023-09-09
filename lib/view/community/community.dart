import 'package:flutter/material.dart';

import '../../constants/colors/Colors.dart';

class community extends StatefulWidget {
  const community({Key? key}) : super(key: key);

  @override
  State<community> createState() => _communityState();
}

class _communityState extends State<community> {
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,


      body: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: SizedBox(
              height: height,
              width: width,
              child: const Image(
                image: AssetImage(
                  'assets/backgroundPhotos/woodenBackgroundBlack.jpg',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),

          const SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 10),
                  child: Center(
                    child: Text('Our Community',
                      style:  TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 25,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
