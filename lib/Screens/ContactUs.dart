import 'dart:async';

import 'package:balaji/Common/Constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactUs extends StatefulWidget {
  var contactData;

  ContactUs({this.contactData});

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
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
        title: const Text('Contact Us',
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
              icon: Icon(Icons.card_travel),
              onPressed: () {
                Navigator.of(context).pushNamed('/CartScreen');
              }),
        ],
      ),
      body: WebView(
        initialUrl: "https://blog.utsavfashion.com/ensembles/designer-sarees",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _webView.complete(webViewController);
        },
      ),
    );
  }
}
