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
        errorText = 'No user found for that email.';
      } else if (error.code == 'wrong-password') {
        errorText = 'Wrong password provided for that user.';
      } else if (error.code == 'invalid-email') {
        errorText = 'The email address is not valid.';
      }
      else if (error.code == 'invalid-credential') {
        errorText = 'Invalid email or password.';
      }
      else {
        errorText = 'An error occurred during sign in: ${error.message}';
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
        errorText = 'The password provided is too weak.';
      } else if (error.code == 'email-already-in-use') {
        errorText = 'An account already exists for that email.';
      } else if (error.code == 'invalid-email') {
        errorText = 'The email address is not valid.';
      }
      else {
        print('Uncaught FirebaseAuthException code during Sign In: ${error.code}');
        errorText = 'An error occurred during sign up: ${error.message}';
      }
      setState(() {
        errorMessage = errorText;
      });
    }
  }

  @override
  void dispose() {
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
            decoration: const InputDecoration(hintText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Your Email';
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


