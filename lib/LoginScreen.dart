/*
* @author : Garvit Kothari
*
*/


import 'package:currency_convertor/DatabaseHelper.dart';
import 'package:currency_convertor/LoginSuccess.dart';
import 'package:currency_convertor/PasswordOperation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:currency_convertor/SignupScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // DONE: implement createState
    return Login();
  }

}

class Login extends State<LoginScreen> {
  String status;
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    // DONE: implement build
    TextEditingController passController = new TextEditingController();
    TextEditingController usernameController = new TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text("Currency Converter"),),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 50,),
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset("Assets/logo.png"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            elevation: 5,
            margin: EdgeInsets.all(20),
          ),
         // Text("$status",style: TextStyle(color: Colors.red),),
          SizedBox(height: 50,),
          Text("Enter Username",style: TextStyle(color: Colors.lightBlueAccent,fontSize: 20),),
          SizedBox(height: 15,),
          TextField(
            controller: usernameController,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              labelText: "Username",
              hintText: 'Enter username',
              fillColor: Colors.white70,
              filled: true,
              hintStyle: TextStyle(color: Colors.white),
              border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 25,),
          Text("Enter A Password",style: TextStyle(color: Colors.lightBlueAccent,fontSize: 20),),
          SizedBox(height: 15,),
          TextField(
            controller: passController,
            style: TextStyle(color: Colors.black),
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              labelText: "Password",

              fillColor: Colors.white70,
              filled: true,
              hintStyle: TextStyle(color: Colors.white70),
              border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(child: Text("Login"),
                onPressed: () {
                  submit(usernameController.text,passController.text);
                },),
              RaisedButton(child: Text("Sign up"),
                onPressed: () {
                  navigateToSignupScreen(context);
                },),
            ],
          ),
        ],
      ),
    )
    );
  }
  Future<void> submit(username,pass) async {
     setState(() async{
       List<Map<String,dynamic>> data = await _databaseHelper.getData(username);
       String salt = data[0].values.toList()[3];
       String hash = PasswordOperation().getPasswordHash(pass,salt);
       if(data != null && hash == data[0].values.toList()[1]) {
         navigateToLoginSuccess(context);
       }
       else {
         setState(() {
           status = "Username or Password is wrong";
         });
       }
     });

  }

  Future navigateToSignupScreen(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
  }

  Future navigateToLoginSuccess(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginSuccess()));
  }

}