import 'package:flutter/material.dart';
import 'package:shopping_app/routes/wishlist.dart';
import 'package:shopping_app/routes/cart.dart';
import 'package:shopping_app/routes/search.dart';
import 'package:shopping_app/routes/login.dart';
import 'package:shopping_app/routes/userprofile.dart';
import 'package:shopping_app/routes/settings.dart';
import 'package:shopping_app/routes/home.dart';
import 'package:shopping_app/routes/splash.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: '/splash',
      routes: {
        '/splash' : (context) => SplashScreen(),
        '/home' : (context) => HomeScreen(),
        '/wishlist': (context) => Wishlist(),
        '/cart': (context) => Cart(),
        '/search': (context) => SearchScreen(),
        '/userProfile':(context) => UserProfile(),
        '/settings':(context) => SettingsPage(),
        '/login': (context) => Login()
      },
      theme: ThemeData(fontFamily: 'serif') // text font from asset
  ));
}
