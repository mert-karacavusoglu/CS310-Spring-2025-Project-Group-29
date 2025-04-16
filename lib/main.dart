import 'package:flutter/material.dart';
import 'package:shopping_app/routes/wishlist.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: '/wishlist',
      routes: {
        '/wishlist': (context) => Wishlist()
      },
      theme: ThemeData(fontFamily: 'serif') // text font from asset
  ));
}
