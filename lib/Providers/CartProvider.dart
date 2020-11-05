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

  void increaseCart(int qty) {
    cartCount = cartCount + qty;
    notifyListeners();
  }

  void decrementCart(int qty) {
    cartCount = cartCount - qty;
    log("count -> $cartCount");
    notifyListeners();
  }

  void removeCart() {
    cartCount = 0;
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
          int tempCount = 0;
          if (responseList.length > 0) {
            for (int i = 0; i < responseList.length; i++) {
              tempCount =
                  tempCount + int.parse(responseList[i]["CartQuantity"]);
              setCartCount(tempCount);
            }
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
