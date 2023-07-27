import 'package:flutter/material.dart';

class entryPointStatics extends StatefulWidget {
  const entryPointStatics({Key? key}) : super(key: key);

  // ENTRY POINT
  static int indexBottomNavigationBar = 0;

  @override
  State<entryPointStatics> createState() => _entryPointStaticsState();
}

class _entryPointStaticsState extends State<entryPointStatics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
