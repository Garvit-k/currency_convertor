import 'package:currency_convertor/ConversionUtil.dart';
import 'package:currency_convertor/CurrencyList.dart';
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
  String baseCurrency="USD";
  String targetCurrency="INR";
  String convertedResult="Convert to";
  TextEditingController baseController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // DONE: implement build
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold (
      appBar: AppBar(title: Text("Currency Converter", style: TextStyle(color: Colors.white),),),
      backgroundColor: Colors.black,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child:
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: baseController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(),
                      labelText: "Number",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: "1.00",
                    ),
                  ),
                ),
                baseCurrencyList(),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 80,),
                Expanded(
                  child:
                  Text(convertedResult,style: TextStyle(color: Colors.white,fontSize: 15),),
                ),
                targetCurrencyList(),
              ],
            ),
            RaisedButton(
              child: Text("Convert"),
              onPressed: () {
                convertValues();
              },
            ),
          ],
        )
    )
    );
  }
  Widget baseCurrencyList() {
    return DropdownButton<String>(
      value: baseCurrency,
      dropdownColor: Colors.black,
      items: CurrencyList.currencies.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,style: TextStyle(color: Colors.white),),
        );
      }).toList(),
      onChanged: (String value) {
        setState(() {
          baseCurrency = value;
        });
        },
    );
  }
  Widget targetCurrencyList() {
    return DropdownButton<String>(
      value: targetCurrency,
      dropdownColor: Colors.black,
      items: CurrencyList.currencies.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,style: TextStyle(color: Colors.white),),
        );
      }).toList(),
      onChanged: (String value) {
        setState(() {
          targetCurrency = value;
        });
      },
    );
  }

  convertValues() async{
    convertedResult = await ConversionUtil().converter(baseController.text, baseCurrency, targetCurrency);
    setState(() {

    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?',style: TextStyle(fontSize: 25),),
        content: new Text('Do you want Logout ?',style: TextStyle(fontSize: 20)),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO",style: TextStyle(fontSize: 15)),
          ),
          SizedBox(height: 20),
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Text("YES",style: TextStyle(fontSize: 15)),
          ),
        ],
      ),
    ) ??
        false;
  }

}