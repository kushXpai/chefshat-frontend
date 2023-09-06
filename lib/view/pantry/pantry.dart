import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/colors/customColors.dart';
import '../../model/pantry/pantryCategory.dart';
import '../../model/pantry/pantryDishes.dart';

class pantry extends StatefulWidget {
  const pantry({Key? key}) : super(key: key);

  static int pantryIndex = 0;

  @override
  State<pantry> createState() => _pantryState();
}

class _pantryState extends State<pantry> {

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: CustomColors.black,

        body: Container(
          height: height,
          width: width,

          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 10),

                child: Column(
                  children: [
                    const SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Basket',
                          style:  TextStyle(
                              fontFamily: 'Georgia',
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.white
                          ),
                        ),
                        SizedBox(
                          width: 30,

                          child: ElevatedButton(
                            onPressed: (){},

                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.all(0),
                            ),

                            child: const Icon(Icons.more_vert_rounded, color: CustomColors.white, size: 30,),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),

              const Divider(
                color: CustomColors.grey,
                thickness: 1.5,
              ),
              const SizedBox(height: 10,),

              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),

                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(

                          child: ElevatedButton(
                            onPressed: (){},

                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.all(0),
                            ),

                            child: const Row(
                              children: [
                                Icon(Icons.add_circle_outline_rounded, color: Colors.amber, size: 27,),
                                SizedBox(width: 5,),
                                Text('Add to Shopping List',
                                  style:  TextStyle(
                                    fontFamily: 'Georgia',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: (){
                              setState(() {
                                pantry.pantryIndex = 0;
                              });
                            },

                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.all(0),
                            ),

                            child: Icon(Icons.menu_rounded, color: CustomColors.white, size: 30,),
                          ),
                        ),
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: (){
                              setState(() {
                                setState(() {
                                  pantry.pantryIndex = 1;
                                });
                              });
                            },

                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.all(0),
                            ),

                            child: Icon(Icons.view_list_outlined, color: CustomColors.white, size: 30,),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),

              const Divider(
                color: CustomColors.grey,
                thickness: 1.5,
              ),
              const SizedBox(height: 10,),

              Container(
                margin: const EdgeInsets.only(left: 20, right: 20,),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Last updated ${DateFormat('yyyy-MM-dd').format(DateTime.now())}",
                      style: const TextStyle(
                        fontFamily: "Georgia",
                        fontSize: 15,
                        color: CustomColors.white,
                      ),
                    ),
                    Icon(Icons.refresh_rounded, color: CustomColors.white,)
                  ],
                ),
              ),

              const SizedBox(height: 20,),

              Expanded(
                // height: height - 218,
                // width: width,

                child: SingleChildScrollView(
                  child: pantry.pantryIndex == 0
                      ? const pantryDishes(): const pantryCategory(),
                ),
              )
            ],
          ),
        )
    );
  }
}
