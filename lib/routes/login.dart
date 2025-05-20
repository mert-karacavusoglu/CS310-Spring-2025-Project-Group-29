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
  String errorMessage = '';
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _signIn() async {
    try {
      setState(() {
        errorMessage = '';
      });
      await _auth.signInWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on FirebaseAuthException catch (error) {
      // Handle specific Firebase Authentication errors
      String errorText;
      if (error.code == 'user-not-found') {
        errorText = 'User does not exist';
      } else if (error.code == 'wrong-password') {
        errorText = 'Wrong password';
      } else if (error.code == 'invalid-email') {
        errorText = 'email address is not valid.';
      }
      else if (error.code == 'invalid-credential') {
        errorText = 'Invalid email or password.';
      }
      else {
        errorText = 'error occurred: ${error.message}';
      }
      setState(() {
        errorMessage = errorText;
      });
    }
  }

  Future<void> _signUp() async {
    try {
      setState(() {
        errorMessage = ''; // Clear previous errors
      });
      await _auth.createUserWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on FirebaseAuthException catch (error) {
      String errorText;
      if (error.code == 'weak-password') {
        errorText = 'password is too weak.';
      } else if (error.code == 'email-already-in-use') {
        errorText = 'email already exists';
      } else if (error.code == 'invalid-email') {
        errorText = 'email is not valid';
      }
      else {
        errorText = 'error occurred: ${error.message}';
      }
      setState(() {
        errorMessage = errorText;
      });
    }
  }

  @override
  void dispose() {
    // this is for memory leaks dont mind it
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
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
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
              prefixIcon: Icon(Icons.email),
            ),

            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Your Email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
              prefixIcon: Icon(Icons.password),
            ),
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
                  _signIn();
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
                  _signUp();
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


