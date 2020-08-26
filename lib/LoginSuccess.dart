import 'package:currency_convertor/CryptoConveter.dart';
import 'package:currency_convertor/FiatConveter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginSuccess extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginSuccessState();
  }

}
class LoginSuccessState extends State<LoginSuccess> {
  PageController pageController = new PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PageView(
      controller: pageController,
      children: <Widget>[
        FiatConveter(),
        CryptoConveter(),
      ],
    );
  }

}