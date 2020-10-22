import 'dart:developer';
import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/HistoryComponent.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Providers/CartProvider.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowCaseWidget(
        onStart: (index, key) {
          log('onStart: $index, $key');
        },
        onComplete: (index, key) {
          log('onComplete: $index, $key');
        },
        builder: Builder(builder: (context) => HistoryScreen11()),
        autoPlay: true,
        autoPlayDelay: Duration(seconds: 3),
      ),
    );
  }
}

class HistoryScreen11 extends StatefulWidget {
  @override
  _HistoryScreen11State createState() => _HistoryScreen11State();
}

class _HistoryScreen11State extends State<HistoryScreen11> {
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();

  List historyList = [];
  bool isHistoryLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    _orderHistory();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context).startShowCase([_one, _two]));
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
            Showcase(
              key: _one,
              description: 'Tap_to_move_towards_home'.tr().toString(),
              child: GestureDetector(
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
            ),
            Showcase(
              key: _two,
              description: 'Tap_to_see_your_cart_products'.tr().toString(),
              child: GestureDetector(
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
              ),
            )
          ],
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(
            color: appPrimaryMaterialColor,
          ),
          title: Text('drw_order_history'.tr().toString(),
              style: TextStyle(color: appPrimaryMaterialColor, fontSize: 17)),
        ),
        body: isHistoryLoading
            ? LoadingComponent()
            : historyList.length > 0
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: historyList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HistoryComponent(
                          getOrderapi: () {
                            _orderHistory();
                          },
                          orderData: historyList[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        thickness: 2,
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                    "Order Data Not Found!!!",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600),
                  )));
  }

  _orderHistory() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isHistoryLoading = true;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        FormData body = FormData.fromMap(
            {"CustomerId": prefs.getString(Session.CustomerId)});
        // var body = {"CustomerId": prefs.getString(Session.CustomerId)};
        print(prefs.getString(Session.CustomerId));
        Services.PostForList(api_name: 'orderHistory', body: body).then(
            (responseList) async {
          setState(() {
            isHistoryLoading = false;
          });
          if (responseList.length > 0) {
            setState(() {
              historyList = responseList;
              //set "data" here to your variable
            });
          } else {
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isHistoryLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }
}
