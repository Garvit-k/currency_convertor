

import 'package:flutter/cupertino.dart';
import 'package:currency_convertor/PasswordOperation.dart';
import 'package:flutter/material.dart';
import 'package:currency_convertor/DatabaseHelper.dart';

class SignupScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // DONE: implement createState
    return Signup();
  }

}
class Signup extends State<SignupScreen> {
  String hash="";
  String da="";
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    // DONE: implement build
    TextEditingController passController = new TextEditingController();
    TextEditingController usernameController = new TextEditingController();
    TextEditingController emailController = new TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text("Sign up"),),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Enter A Username",style: TextStyle(color: Colors.white),),
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
          Text("Enter A Password",style: TextStyle(color: Colors.white),),
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
          Text("Enter An Email",style: TextStyle(color: Colors.white),),
          TextField(
            controller: emailController,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              labelText: "Email",
              hintText: 'Enter Email',
              fillColor: Colors.white70,
              filled: true,
              hintStyle: TextStyle(color: Colors.white),
              border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.white),
              ),
            ),
          ),
          RaisedButton(child: Text("Sign up"),
            onPressed: () {
              submit(usernameController.text,passController.text,emailController.text);
            },),
          Text("insert" + da),
        ],
      ),
    );
  }

  void submit(username, pass,email) {
    String salt = PasswordOperation().createCryptoRandomString();
    hash = PasswordOperation().getPasswordHash(pass, salt);
    setState(() {
      Map<String, dynamic> data = {
        _databaseHelper.columnUsername : username,
        _databaseHelper.columnPassword : hash,
        _databaseHelper.columnEmail : email,
        _databaseHelper.columnSalt : salt
      };

      da=data.toString();
      _databaseHelper.insertData(data);

    });

  }

}