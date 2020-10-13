import 'dart:async';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Providers/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

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
    CartProvider provider = Provider.of<CartProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 5, bottom: 8),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
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
          title: Text('drw_Terms'.tr().toString(),
              style: TextStyle(color: appPrimaryMaterialColor, fontSize: 17)),
          actions: [
            // Stack(
            //   alignment: Alignment.topCenter,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(right: 15.0, left: 8, top: 18),
            //       child: GestureDetector(
            //         onTap: () {
            //           Navigator.of(context).pushNamed('/CartScreen');
            //         },
            //         child: Container(
            //             height: 20,
            //             width: 20,
            //             child: Image.asset(
            //               "assets/shopping-cart.png",
            //               color: appPrimaryMaterialColor,
            //             )),
            //       ),
            //     ),
            //     provider.cartCount > 0
            //         ? Padding(
            //             padding: const EdgeInsets.only(
            //                 left: 1.0, top: 13, right: 10),
            //             child: CircleAvatar(
            //               radius: 7.0,
            //               backgroundColor: Colors.red,
            //               foregroundColor: Colors.white,
            //               child: Text(
            //                 provider.cartCount.toString(),
            //                 style: TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 9.0,
            //                 ),
            //               ),
            //             ),
            //           )
            //         : Container()
            //   ],
            // )
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
