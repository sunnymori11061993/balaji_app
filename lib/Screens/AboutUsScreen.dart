import 'dart:async';
import 'dart:developer';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Providers/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class AboutUsScreen extends StatelessWidget {
  var aboutData;

  AboutUsScreen({this.aboutData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowCaseWidget(
        onStart: (index, key) {
          log('onStart: $index, $key');
        },
        onComplete: (index, key) {
          log('onComplete: $index, $key');
        },
        builder: Builder(
            builder: (context) => AboutUsScreen11(
                  aboutData: aboutData,
                )),
        autoPlay: true,
        autoPlayDelay: Duration(seconds: 3),
      ),
    );
  }
}

class AboutUsScreen11 extends StatefulWidget {
  var aboutData;

  AboutUsScreen11({this.aboutData});

  @override
  _AboutUsScreen11State createState() => _AboutUsScreen11State();
}

class _AboutUsScreen11State extends State<AboutUsScreen11> {
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  Completer<WebViewController> _webView = Completer<WebViewController>();
  bool isLoading = true;

  String isShowcase = "false";

  showShowCase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isShowcase = prefs.getString(showSession.showCaseABoutUs);

    if (isShowcase == null || isShowcase == "false") {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(context).startShowCase([_one, _two]));
      prefs.setString(showSession.showCaseABoutUs, "true");
    }
    ;
  }

  @override
  void initState() {
    showShowCase();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider provider = Provider.of<CartProvider>(context);
    Widget appBarTitle = Text(
      'About_Us'.tr().toString(),
      //"About Us",
      style: TextStyle(
          color: appPrimaryMaterialColor,
          //fontFamily: 'RobotoSlab',
          // color: Colors.black,
          fontSize: 17),
    );
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 5, bottom: 8),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop("pop");
                },
                child: Image.asset(
                  "assets/backarrow.png",
                  //color: appPrimaryMaterialColor,
                )),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(
            color: appPrimaryMaterialColor,
          ),
          title: appBarTitle,
          actions: <Widget>[
            Showcase(
              key: _one,
              description: 'Tap_to_move_towards_home'.tr().toString(),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/HomePage', (route) => false);
                },
                child: Container(
                    height: 20,
                    width: 20,
                    child: Image.asset(
                      "assets/home.png",
                      color: appPrimaryMaterialColor,
                    )),
              ),
            ),
            Showcase(
              key: _two,
              description: 'Tap_to_see_your_cart_products'.tr().toString(),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/CartScreen');
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 15.0, left: 10, top: 18),
                      child: Container(
                          height: 20,
                          width: 20,
                          child: Image.asset(
                            "assets/shopping-cart.png",
                            color: appPrimaryMaterialColor,
                          )),
                    ),
                    provider.cartCount > 0
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 2.0, top: 13, right: 10),
                            child: CircleAvatar(
                              radius: 7.0,
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              child: Text(
                                provider.cartCount.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.0,
                                ),
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            WebView(
              initialUrl: "${widget.aboutData}",
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
              onWebViewCreated: (WebViewController webViewController) {
                _webView.complete(webViewController);
              },
            ),
            isLoading
                ? Center(
                    child: LoadingComponent(),
                  )
                : Stack(),
          ],
        ));
  }
}
