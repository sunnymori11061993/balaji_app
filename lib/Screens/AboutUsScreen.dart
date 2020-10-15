import 'dart:async';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
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
            // IconButton(
            //     icon: Icon(Icons.favorite_border),
            //     onPressed: () {
            //       Navigator.of(context).pushNamed('/Whishlist');
            //     }),
            // IconButton(
            //     icon: Icon(Icons.card_travel),
            //     onPressed: () {
            //       Navigator.of(context).pushNamed('/CartScreen');
            //     }),
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
