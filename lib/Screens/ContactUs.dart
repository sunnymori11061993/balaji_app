import 'dart:async';

import 'package:balaji/Common/Constants.dart';
import 'package:flutter/cupertino.dart';
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
    Widget appBarTitle = Text(
      //'home1'.tr().toString(),
      "Contact Us",
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/cubg.jpg",
                fit: BoxFit.fitHeight,
              ),
            ),
            Opacity(
              opacity: 0.7,
              child: Container(
                color: Colors.black45,
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Container(
                height: MediaQuery.of(context).size.height / 2.4,
                width: MediaQuery.of(context).size.width,
                //color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width - 80,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15.0, left: 15),
                              child: Container(
                                height: 20,
                                width: 20,
                                child: Image.asset(
                                  "assets/026-email.png",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Email",
                                style: TextStyle(
                                    color: Colors.white,
                                    //fontFamily: 'RobotoSlab',
                                    // color: Colors.black,
                                    fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width - 80,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15.0, left: 15),
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset(
                                    "assets/022-phone-call.png",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Phone Call",
                                  style: TextStyle(
                                      color: Colors.white,
                                      //fontFamily: 'RobotoSlab',
                                      // color: Colors.black,
                                      fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width - 80,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15.0, left: 15),
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset(
                                    "assets/034-chat.png",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Whatsapp",
                                  style: TextStyle(
                                      color: Colors.white,
                                      //fontFamily: 'RobotoSlab',
                                      // color: Colors.black,
                                      fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: ListTile(
                      //     leading: Padding(
                      //       padding:
                      //           const EdgeInsets.only(right: 10.0, left: 4),
                      //       child: Container(
                      //           height: 20,
                      //           width: 20,
                      //           child: Image.asset(
                      //             "assets/edit.png",
                      //             color: appPrimaryMaterialColor,
                      //           )),
                      //     ),
                      //     title: Text(
                      //       "Email",
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 15, right: 15),
                      //   child: Divider(),
                      // ),
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: ListTile(
                      //     leading: Padding(
                      //       padding:
                      //           const EdgeInsets.only(right: 10.0, left: 4),
                      //       child: Container(
                      //           height: 20,
                      //           width: 20,
                      //           child: Image.asset(
                      //             "assets/location.png",
                      //             color: appPrimaryMaterialColor,
                      //           )),
                      //     ),
                      //     title: Text(
                      //       "Phone",
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 15, right: 15),
                      //   child: Divider(),
                      // ),
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: ListTile(
                      //     leading: Padding(
                      //       padding:
                      //           const EdgeInsets.only(right: 10.0, left: 4),
                      //       child: Container(
                      //           height: 20,
                      //           width: 20,
                      //           child: Image.asset(
                      //             "assets/history.png",
                      //             color: appPrimaryMaterialColor,
                      //           )),
                      //     ),
                      //     title: Text(
                      //       "Whatsapp",
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
