import 'dart:math';

import 'package:chefs_hat/controller/entryPoint/entryPoint.dart';
import 'package:chefs_hat/view/homePage/homePage.dart';
import 'package:chefs_hat/view/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'model/entryPoint/model/btm_nav_item.dart';
import 'model/entryPoint/model/menu.dart';
import 'model/entryPoint/model/rive_utils.dart';


class entryPoint extends StatefulWidget {
  const entryPoint({Key? key}) : super(key: key);

  @override
  State<entryPoint> createState() => _entryPointState();
}

class _entryPointState extends State<entryPoint> with TickerProviderStateMixin {

  bool isSideBarOpen = false;

  Menu selectedBottonNav = bottomNavItems.first;

  late SMIBool isMenuOpenInput;

  void updateSelectedBtmNav(Menu menu) {
    if (selectedBottonNav != menu) {
      setState(() {
        selectedBottonNav = menu;
      });
    }
  }

  late AnimationController _animationController;
  late Animation<double> scalAnimation;
  late Animation<double> animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(
            () {
          setState(() {});
        },
      );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF242424),
      // backgroundColor: const Color(0xFF17203A),
      body: Stack(
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(
                  1 * animation.value - 30 * (animation.value) * pi / 180),
            child: Transform.translate(
              offset: Offset(animation.value * 265, 0),
              child: Transform.scale(
                scale: scalAnimation.value,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(24),
                  ),
                  child: Center(
                    child: entryPointStatics.indexBottomNavigationBar == 0
                        ? homePage(): entryPointStatics.indexBottomNavigationBar == 1
                        ? homePage(): entryPointStatics.indexBottomNavigationBar == 2
                        ? homePage() : profile(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Transform.translate(
        offset: Offset(0, 100 * animation.value),
        child: SafeArea(
          minimum: EdgeInsets.only(bottom: 18),
          child: Container(
            padding:
            const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 70),
            decoration: BoxDecoration(
              color: const Color(0xFF000000).withOpacity(0.8),
              // color: const Color(0xFF17203A).withOpacity(0.8),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF17203A).withOpacity(0.3),
                  offset: const Offset(0, 20),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...List.generate(
                  bottomNavItems.length,
                      (index) {
                    Menu navBar = bottomNavItems[index];
                    return BtmNavItem(
                      navBar: navBar,
                      press: () {
                        RiveUtils.chnageSMIBoolState(navBar.rive.status!);
                        updateSelectedBtmNav(navBar);
                        if(index == 0){
                          setState(() {
                            entryPointStatics.indexBottomNavigationBar = 0;
                          });
                        }
                        else if(index == 1){
                          setState(() {
                            entryPointStatics.indexBottomNavigationBar = 1;
                          });
                        }
                        else if(index == 2){
                          setState(() {
                            entryPointStatics.indexBottomNavigationBar = 2;
                          });
                        }
                        else if(index == 3){
                          setState(() {
                            entryPointStatics.indexBottomNavigationBar = 3;
                          });
                        }
                      },
                      riveOnInit: (artboard) {
                        navBar.rive.status = RiveUtils.getRiveInput(artboard,
                            stateMachineName: navBar.rive.stateMachineName);
                      },
                      selectedNav: selectedBottonNav,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
