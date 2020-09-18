import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Screens/ProductDetailScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrendingProductComponent extends StatefulWidget {
  var trendData;

  TrendingProductComponent(this.trendData);

  @override
  _TrendingProductComponentState createState() =>
      _TrendingProductComponentState();
}

class _TrendingProductComponentState extends State<TrendingProductComponent> {
  bool isWishList = false;
  bool isFavLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 6, right: 6),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => new ProductDetailScreen(
                        productDetail: widget.trendData["ProductId"],
                      )));
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 237,
                  child: Image.network(
                      Image_URL + "${widget.trendData["ProductImages"]}",
                      fit: BoxFit.fill)),
              Padding(
                padding: const EdgeInsets.only(
                  left: 4.0,
                  top: 2.0,
                ),
                child: Text("${widget.trendData["ProductName"]}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 1),
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                "₹",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "${widget.trendData["ProductSrp"]}",
                                style: TextStyle(
                                    // color: Colors.grey[600],
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              "₹" + "${widget.trendData["ProductMrp"]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          _addToWishlist();
                        },
                        child: Container(
                            child: isWishList == false
                                ? Icon(
                                    Icons.favorite_border,
                                    color: appPrimaryMaterialColor,
                                  )
                                : Icon(
                                    Icons.favorite,
                                    color: appPrimaryMaterialColor,
                                  )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _addToWishlist() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        FormData body = FormData.fromMap({
          "CustomerId": prefs.getString(Session.CustomerId),
          //"ProductId": trendingProductList[0]["ProductId"],
          "ProductId": "${widget.trendData["ProductId"]}",
        });
        setState(() {
          isFavLoading = true;
        });
        Services.postForSave(apiname: 'addRemoveWishlist', body: body).then(
            (responseList) async {
          setState(() {
            isFavLoading = false;
          });
          if (responseList.IsSuccess == true && responseList.Data == "1") {
            setState(() {
              isWishList = !isWishList;
            });
            if (isWishList == true) {
              Fluttertoast.showToast(msg: "Added to Wishlist");
            } else {
              Fluttertoast.showToast(msg: "Remove from Wishlist");
            }
          } else {
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isFavLoading = false;
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
