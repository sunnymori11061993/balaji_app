import 'dart:async';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Providers/CartProvider.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_slider/image_slider.dart';
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
  TabController tabController;
  List imgList = [];
  List _bannerList = [
    "assets/Gallery_1.jpg",
    "assets/Gallery_2.jpg",
    "assets/Gallery_3.jpg",
    "assets/Gallery_4.jpg",
    "assets/Gallery_5.jpg",
  ];

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 5, right: 5),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/about_banner.png",
                  fit: BoxFit.fill,
                  height: 200,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17.0, left: 10, right: 10),
              child: Text(
                'AboutUs'.tr().toString(),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 250.0,
              width: MediaQuery.of(context).size.width,
              child: Carousel(
                boxFit: BoxFit.cover,
                autoplay: true,
                animationCurve: Curves.fastOutSlowIn,
                animationDuration: Duration(milliseconds: 1000),
                dotSize: 4.0,
                dotIncreasedColor: Colors.black54,
                dotBgColor: Colors.transparent,
                dotPosition: DotPosition.bottomCenter,
                dotVerticalPadding: 10.0,
                showIndicator: true,
                indicatorBgPadding: 7.0,
                images: _bannerList
                    .map((item) => Container(child: Image.asset(item)))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      /*  Stack(
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
        )*/
    );
  }
}
