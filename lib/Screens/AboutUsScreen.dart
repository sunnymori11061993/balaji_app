import 'dart:async';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Providers/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class AboutUsScreen extends StatefulWidget {
  var aboutData;

  AboutUsScreen({this.aboutData});

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  Completer<WebViewController> _webView = Completer<WebViewController>();
  bool isLoading = true;

  String isShowcase = "false";

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    CartProvider provider = Provider.of<CartProvider>(context);
    Widget appBarTitle = Text(
      'About_Us'.tr().toString(),
      //"About Us",
      style: TextStyle(
          color: appPrimaryMaterialColor,
          //fontFamily: 'RobotoSlab',
          // coor: Colors.black,
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
          GestureDetector(
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
          GestureDetector(
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
        ],
      ),
      body: Column(
        children: [Image.asset("assets/")],
      ),
    );
  }
}

/*Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: WebView(
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
            ),
            isLoading
                ? Center(
                    child: LoadingComponent(),
                  )
                : Stack(),
          ],
        ));*/
