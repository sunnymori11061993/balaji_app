import 'dart:async';

import 'package:balaji/Common/Constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndCondition extends StatefulWidget {
  var termsConData;

  TermsAndCondition({this.termsConData});
  @override
  _TermsAndConditionState createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  Completer<WebViewController> _webView = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: appPrimaryMaterialColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(
          color: appPrimaryMaterialColor,
        ),
        title: const Text('Terms&Conditions',
            style: TextStyle(
              color: Colors.black,
            )),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {
                Navigator.of(context).pushNamed('/Whishlist');
              }),
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed('/CartScreen');
              }),
        ],
      ),
      body: WebView(
        initialUrl: widget.termsConData["SettingTermsConditionURL"],
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _webView.complete(webViewController);
        },
      ),
    );
  }
}
