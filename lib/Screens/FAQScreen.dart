import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/FAQComponent.dart';
import 'package:balaji/Providers/CartProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  bool isLoading = false;
  List listfaq = [];

  @override
  void initState() {
    _getFAQ();
  }

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
          actions: [
            GestureDetector(
              onTap: () {
                // Navigator.of(context).pushReplacementNamed('/HomePage');
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
                              left: 1.0, top: 13, right: 10),
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
            )
          ],
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: Colors.grey),
          title: Text(
            'drw_faq'.tr().toString(),
            style: TextStyle(color: appPrimaryMaterialColor, fontSize: 17),
          ),
        ),
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(appPrimaryMaterialColor),
              ))
            : listfaq.length > 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemCount: listfaq.length,
                          itemBuilder: (BuildContext context, int index) {
                            return FAQComponent(faqdata: listfaq[index]);
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                    "No Data Found!!!",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600),
                  )));
  }

  _getFAQ() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        Services.PostForList(api_name: 'getFAQ', body: {}).then(
            (responselist) async {
          setState(() {
            isLoading = false;
          });
          if (responselist.length > 0) {
            setState(() {
              listfaq = responselist;
            });
          } else {
            Fluttertoast.showToast(msg: "No Data Found!");
          }
        }, onError: (e) {
          setState(() {
            isLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "something went wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection");
//      showMsg("No Internet Connection.");
    }
  }
}
