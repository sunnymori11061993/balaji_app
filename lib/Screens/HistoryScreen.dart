import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/HistoryComponent.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List historyList = [];
  bool isHistoryLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    _orderHistory();
  }

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
          title: const Text("Order History",
              style: TextStyle(
                color: Colors.black,
              )),
        ),
        body: isHistoryLoading
            ? LoadingComponent()
            : historyList.length > 0
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ListView.separated(
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
