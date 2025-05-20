import 'package:flutter/material.dart';
import 'package:shopping_app/util/colors.dart';
import 'package:shopping_app/util/pads.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool submitted = false;
  String errorMessage = '';
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool checkChar(String s, int idx) {
    if(s.codeUnitAt(idx) >= 48 && s.codeUnitAt(idx) <= 57) {
      return true;
    }

    if(s.codeUnitAt(idx) >= 65 && s.codeUnitAt(idx) <= 90) {
      return true;
    }

    if(s.codeUnitAt(idx) >= 97 && s.codeUnitAt(idx) <= 122) {
      return true;
    }


    return false;
  }

  bool checkInput() {
    String uname = usernameController.text;
    String upass = passwordController.text;

    for (int i = 0; i < uname.length; i++) {
      if (!checkChar(uname, i)) {
        return false;
      }
    }

    for (int i = 0; i < upass.length; i++) {
      if (!checkChar(upass, i)) {
        return false;
      }
    }

    return true;
  }

  void processInput() {
    if (checkInput()) {
      setState(() {
        errorMessage = "";
      });
      Navigator.pushNamed(context, '/home'); //Make this the route equal to home screen
    }

    else {
      setState(() {
        errorMessage = "Username and Password must be Ascii or Digits";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }
        ),
        backgroundColor: appcolor.backgroundColor,
        title: Text('Login',
        style: TextStyle(fontSize: 24,
        fontWeight: FontWeight.bold, color: appcolor.primary),),
        centerTitle: true,
      ),
      body: Column(
        children: [
        Padding(
          padding: apppad.extraPadding,
          child:Text('Welcome!', style:TextStyle(fontSize:24, fontWeight: FontWeight.bold))),
        Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
            controller: usernameController,
            decoration: const InputDecoration(hintText: 'Username'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Your Username';
              }
              return null;
            },
          ),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(hintText: 'Password'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Your Password';
              }
              return null;
            }
          ),
          Padding(
            padding: apppad.regularPadding,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  processInput();
                }
              },
              child: const Text('Login')
            )
          ),
          Padding(
            padding: apppad.regularPadding,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  processInput();
                }
              },
              child: const Text('Sign Up')
            )
          ),
          Text(errorMessage)
          ],
          )
      ) 
      ])
    );
  }
}


