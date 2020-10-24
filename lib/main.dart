import 'package:balaji/Providers/CartProvider.dart';
import 'package:balaji/Screens/AboutUsScreen.dart';
import 'package:balaji/Screens/Address%20Screen.dart';
import 'package:balaji/Screens/BottomCategory.dart';
import 'package:balaji/Screens/CartScreen.dart';
import 'package:balaji/Screens/ChangeLanguage.dart';
import 'package:balaji/Screens/ContactUs.dart';
import 'package:balaji/Screens/FAQScreen.dart';
import 'package:balaji/Screens/FilterScreen.dart';
import 'package:balaji/Screens/HistoryScreen.dart';
import 'package:balaji/Screens/Home.dart';
import 'package:balaji/Screens/HomePage.dart';
import 'package:balaji/Screens/LanguageChangeScreen.dart';
import 'package:balaji/Screens/LoginScreen.dart';
import 'package:balaji/Screens/ManuHomePage.dart';
import 'package:balaji/Screens/ManuHomeScreen.dart';
import 'package:balaji/Screens/ManuProfile.dart';
import 'package:balaji/Screens/ManuProfileScreen.dart';
import 'package:balaji/Screens/ManuSetting.dart';
import 'package:balaji/Screens/NotificationScreen.dart';
import 'package:balaji/Screens/OrderHistoryScreen.dart';
import 'package:balaji/Screens/PlaceOrderScreen.dart';
import 'package:balaji/Screens/ProductDetailScreen.dart';
import 'package:balaji/Screens/ProfileScreen.dart';
import 'package:balaji/Screens/RegistrationScreen.dart';
import 'package:balaji/Screens/SearchingScreen.dart';
import 'package:balaji/Screens/SettingScreen.dart';
import 'package:balaji/Screens/Splash.dart';
import 'package:balaji/Screens/SubCategory.dart';
import 'package:balaji/Screens/TermsAndCondition.dart';
import 'package:balaji/Screens/ThankYouScreen.dart';
import 'package:balaji/Screens/UserProfileScreen.dart';
import 'package:balaji/Screens/VerificationScreen.dart';
import 'package:balaji/Screens/ViewAllScreen.dart';
import 'package:balaji/Screens/ViewCatalougeScreen.dart';
import 'package:balaji/Screens/WalkThroughScreen.dart';
import 'package:balaji/Screens/Whishlist.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';

const debug = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: debug);
  runApp(EasyLocalization(
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        )
      ],
      child: MyApp(),
    ),
    path: "assets/locale",
    saveLocale: true,
    supportedLocales: [Locale('hi', 'HI'), Locale('en', 'US')],
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _firebaseToken();
    _firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      print("onMessage");
      print(message);
    }, onResume: (Map<String, dynamic> message) {
      print("onResume");
      print(message);
    }, onLaunch: (Map<String, dynamic> message) {
      print("onLaunch");
      print(message);
    });

    //For Ios Notification
    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(sound: true, badge: true, alert: true));
    //
    //   _firebaseMessaging.onIosSettingsRegistered
    //       .listen((IosNotificationSettings settings) {
    //     print("Setting reqistered : $settings");
    //   });
  }

  void _firebaseToken() {
    _firebaseMessaging.getToken().then((token) {
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Balaji',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: '/',
      routes: {
        //'/': (context) => AddressScreen(),
        '/': (context) => Splash(),
        //'/': (context) => HomePage(),
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
        '/ManuHomeScreen': (context) => ManuHomeScreen(),
        '/ManuProfileScreen': (context) => ManuProfileScreen(),
        '/LanguageChangeScreen': (context) => LanguageChangeScreen(),
        '/WalkThroughScreen': (context) => WalkThroughScreen(),
        '/HistoryScreen': (context) => HistoryScreen(),
        '/SearchingScreen': (context) => SearchingScreen(),
        '/ViewCatalougeScreen': (context) => ViewCatalougeScreen(),
        '/HomePage': (context) => HomePage(),
        '/SettingScreen': (context) => SettingScreen(),
        '/UserProfileScreen': (context) => UserProfileScreen(),
        '/AboutUsScreen': (context) => AboutUsScreen(),
        '/ThankYouScreen': (context) => ThankYouScreen(),
        '/ChangeLanguage': (context) => ChangeLanguage(),
        '/ViewAllScreen': (context) => ViewAllScreen(),
        '/NotificationScreen': (context) => NotificationScreen(),
        '/ManuHomePage': (context) => ManuHomePage(),
        '/ManuSetting': (context) => ManuSetting(),
        '/ManuProfile': (context) => ManuProfile(),
      },
      theme: ThemeData(
        fontFamily: 'RobotoSlab',
        // primarySwatch: cnst.appPrimaryMaterialColor,
//        accentColor: Colors.black,
//        buttonColor: Colors.deepPurple,
      ),
    );
  }
}
