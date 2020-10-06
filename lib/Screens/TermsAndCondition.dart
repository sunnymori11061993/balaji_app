import 'dart:async';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Component/LoadingComponent.dart';
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
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset(
                "assets/backarrow.png",
                //color: appPrimaryMaterialColor,
              )),
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(
            color: appPrimaryMaterialColor,
          ),
          title: Text('Terms & Conditions',
              style: TextStyle(
                color: appPrimaryMaterialColor,
              )),
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
              initialUrl: "${widget.termsConData}",
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
