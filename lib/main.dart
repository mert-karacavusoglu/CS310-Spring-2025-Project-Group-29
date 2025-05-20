import 'package:flutter/material.dart';
import 'package:shopping_app/routes/wishlist.dart';
import 'package:shopping_app/routes/cart.dart';
import 'package:shopping_app/routes/search.dart';
import 'package:shopping_app/routes/login.dart';
import 'package:shopping_app/routes/userprofile.dart';
import 'package:shopping_app/routes/settings.dart';
import 'package:shopping_app/routes/home.dart';
import 'package:shopping_app/routes/splash.dart';
import 'package:shopping_app/model/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ShoppingApp());
      

}



class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthInfoProvider(),
      child: MaterialApp(
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
      ),
    );
  }

}