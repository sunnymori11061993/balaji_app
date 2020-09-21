import 'package:balaji/Screens/Address%20Screen.dart';
import 'package:balaji/Screens/BottomCategory.dart';
import 'package:balaji/Screens/CartScreen.dart';
import 'package:balaji/Screens/ContactUs.dart';
import 'package:balaji/Screens/FAQScreen.dart';
import 'package:balaji/Screens/FilterScreen.dart';
import 'package:balaji/Screens/Home.dart';
import 'package:balaji/Screens/LoginScreen.dart';
import 'package:balaji/Screens/OrderHistoryScreen.dart';
import 'package:balaji/Screens/PlaceOrderScreen.dart';
import 'package:balaji/Screens/ProductDetailScreen.dart';
import 'package:balaji/Screens/ProfileScreen.dart';
import 'package:balaji/Screens/RegistrationScreen.dart';
import 'package:balaji/Screens/Splash.dart';
import 'package:balaji/Screens/SubCategory.dart';
import 'package:balaji/Screens/TermsAndCondition.dart';
import 'package:balaji/Screens/VerificationScreen.dart';
import 'package:balaji/Screens/Whishlist.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Balaji',
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/LoginScreen': (context) => LoginScreen(),
        '/VerificationScreen': (context) => VerificationScreen(),
        '/RegistrationScreen': (context) => RegistrationScreen(),
        '/Home': (context) => Home(),
        '/SubCategory': (context) => SubCategory(),
        '/ProductDetailScreen': (context) => ProductDetailScreen(),
        '/CartScreen': (context) => CartScreen(),
        '/PlaceOrderScreen': (context) => PlaceOrderScreen(),
        '/Whishlist': (context) => Whishlist(),
        '/OrderHistoryScreen': (context) => OrderHistoryScreen(),
        '/ProfileScreen': (context) => ProfileScreen(),
        '/FilterScreen': (context) => FilterScreen(),
        '/BottomCategory': (context) => BottomCategory(),
        '/TermsAndCondition': (context) => TermsAndCondition(),
        '/ContactUs': (context) => ContactUs(),
        '/FAQScreen': (context) => FAQScreen(),
        '/AddressScreen': (context) => AddressScreen(),
      },
      theme: ThemeData(
          //fontFamily: 'Montserrat',
          // primarySwatch: cnst.appPrimaryMaterialColor,
//        accentColor: Colors.black,
//        buttonColor: Colors.deepPurple,
          ),
    );
  }
}
