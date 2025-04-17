import 'package:flutter/material.dart';
import 'package:shopping_app/routes/wishlist.dart';
import 'package:shopping_app/routes/cart.dart';
import 'package:shopping_app/routes/search.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: '/wishlist',
      routes: {
        '/wishlist': (context) => Wishlist(),
        '/cart': (context) => Cart(),
        '/search': (context) => SearchScreen()  
      },
      theme: ThemeData(fontFamily: 'serif') // text font from asset
  ));
}
