import 'package:currency_convertor/LoginScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // DONE: implement build
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}