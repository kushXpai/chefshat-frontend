import 'package:chefs_hat/constants/colors/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/landingPagePhotos.dart';
import '../../model/landingPage/dishTile.dart';

class landingPage extends StatefulWidget {
  const landingPage({Key? key}) : super(key: key);

  @override
  State<landingPage> createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      double minScrollExtent1 = _scrollController1.position.minScrollExtent;
      double maxScrollExtent1 = _scrollController1.position.maxScrollExtent;
      double minScrollExtent2 = _scrollController2.position.minScrollExtent;
      double maxScrollExtent2 = _scrollController2.position.maxScrollExtent;

      animateToMaxMin(maxScrollExtent1, minScrollExtent1, maxScrollExtent1, 25,
          _scrollController1);
      animateToMaxMin(maxScrollExtent2, minScrollExtent2, minScrollExtent2, 15,
          _scrollController2); // Change the direction for the second MoviesListView
    });
  }

  animateToMaxMin(double max, double min, double direction, int seconds, ScrollController scrollController) {
    scrollController
        .animateTo(
      direction,
      duration: Duration(seconds: seconds),
      curve: Curves.linear,
    )
        .then((value) {
      direction = direction == max ? min : max;
      animateToMaxMin(max, min, direction, seconds, scrollController);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: CustomColors.black,
      body: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              dishTile(
                scrollController: _scrollController1,
                images: row1,
              ),
              dishTile(
                scrollController: _scrollController2,
                images: row2,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 40, bottom: 20),
                child: RichText(
                  text: const TextSpan(
                    text: 'Find the perfect recipes ',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 39,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: 'everyday ',
                        style: TextStyle(
                          color: Colors.lime,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 100),
                child: Text(
                  'Elevate your home cooking with our expertly curated recipes!',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 20),
                child: SizedBox(
                  width: width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'signIn');
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
                      'Get Started',
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
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
