import 'dart:async';
import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Providers/CartProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class ContactUs extends StatefulWidget {
  var contactData;

  ContactUs({this.contactData});

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  Completer<WebViewController> _webView = Completer<WebViewController>();
  String msg, whatsapp;

  bool isTermLoading = false;
  List termsConList = [];

  void launchwhatsapp({
    @required String whatsappNumber,
    @required String message,
  }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$whatsappNumber/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?phone=$whatsappNumber&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  @override
  void initState() {
    _settingApi();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider provider = Provider.of<CartProvider>(context);
    Widget appBarTitle = Text(
      //'home1'.tr().toString(),
      'drw_Contact'.tr().toString(),
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
            //       padding: const EdgeInsets.only(
            //           left: 1.0, top: 13, right: 10),
            //       child: CircleAvatar(
            //         radius: 7.0,
            //         backgroundColor: Colors.red,
            //         foregroundColor: Colors.white,
            //         child: Text(
            //           provider.cartCount.toString(),
            //           style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 9.0,
            //           ),
            //         ),
            //       ),
            //     )
            //         : Container()
            //   ],
            // )
          ],
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(
            color: appPrimaryMaterialColor,
          ),
          title: appBarTitle,
        ),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: appPrimaryMaterialColor,
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Container(
                height: MediaQuery.of(context).size.height / 2.1,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Text(
                      "Contact Us",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        //fontWeight: FontWeight.w600
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30.0, left: 10, right: 10),
                      child: Text(
                        "Email us or Whatsapp us with any questions or inquiries or call us. We would be happy to answer your questions. Balaji Wholesale Bazaar can help set you apart from the flock!",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          //fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Align(
                alignment: AlignmentDirectional.center,
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height / 2.8,
                  width: MediaQuery.of(context).size.width - 55,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _launchURL('chiragtech9teen@gmail.com',
                                'Flutter Email Test', 'Hello Flutter');
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width - 80,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
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
                                      "assets/026-email.png",
                                      color: appPrimaryMaterialColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                        color: appPrimaryMaterialColor,
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
                          child: GestureDetector(
                            onTap: () {
                              launch(('tel:// 8690389909'));
                            },
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width - 80,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
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
                                        color: appPrimaryMaterialColor,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "Phone Call",
                                      style: TextStyle(
                                          color: appPrimaryMaterialColor,
                                          //fontFamily: 'RobotoSlab',
                                          // color: Colors.black,
                                          fontSize: 17),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: GestureDetector(
                            onTap: () {
                              launchwhatsapp(
                                  whatsappNumber: whatsapp, message: msg);
                            },
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width - 80,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
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
                                        color: appPrimaryMaterialColor,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "Whatsapp",
                                      style: TextStyle(
                                          color: appPrimaryMaterialColor,
                                          //fontFamily: 'RobotoSlab',
                                          // color: Colors.black,
                                          fontSize: 17),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  _settingApi() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isTermLoading = true;
        Services.PostForList(api_name: 'get_all_data_api/?tblName=tblsetting')
            .then((responseList) async {
          if (responseList.length > 0) {
            setState(() {
              isTermLoading = false;
              termsConList = responseList;
              msg = responseList[0]["SettingWhatsAppMessage"];
              whatsapp = "+91" + responseList[0]["SettingWhatsAppNumber"];

              //set "data" here to your variable
            });
          } else {
            setState(() {
              isTermLoading = false;
            });
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isTermLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
