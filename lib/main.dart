import 'package:flutter/material.dart';
import 'package:shopping_app/routes/wishlist.dart';
import 'package:shopping_app/routes/cart.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: '/wishlist',
      routes: {
        '/wishlist': (context) => Wishlist(),
        '/cart': (context) => Cart()
      },
      theme: ThemeData(fontFamily: 'serif') // text font from asset
  ));
}
