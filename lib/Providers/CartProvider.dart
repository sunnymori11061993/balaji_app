import 'dart:developer';
import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  int cartCount = 0;

  CartProvider() {
    getCart();
  }

  void setCartCount(int count) {
    cartCount = count;
    notifyListeners();
  }

  void increaseCart() {
    cartCount++;
    notifyListeners();
  }

  void decrementCart() {
    cartCount--;
    notifyListeners();
  }

  Future<int> getCart() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences pref = await SharedPreferences.getInstance();

        FormData body = FormData.fromMap(
            {"customerId": pref.getString(Session.CustomerId)});
        Services.PostForList(api_name: 'get_data_where/tblcart', body: body)
            .then((responseList) async {
          if (responseList.length > 0) {
            log(responseList.length.toString());
            setCartCount(responseList.length);
          } else {
            return 0;
            //show "data not found" in dialog
          }
        }, onError: (e) {
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
          return 0;
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
      return 0;
    }
  }
}
