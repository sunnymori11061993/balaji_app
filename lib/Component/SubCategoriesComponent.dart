import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Screens/ProductDetailScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubCategoriesComponent extends StatefulWidget {
  var subCat;

  SubCategoriesComponent({this.subCat});

  @override
  _SubCategoriesComponentState createState() => _SubCategoriesComponentState();
}

class _SubCategoriesComponentState extends State<SubCategoriesComponent> {
  double percentResult;
  int value;
  bool isWishList = false;
  bool isFavLoading = false;

  percent() {
    setState(() {
      percentResult = value * 100 / int.parse(widget.subCat["ProductMrp"]);
    });
    print(percentResult);
  }

  discount() {
    setState(() {
      value = int.parse(widget.subCat["ProductMrp"]) -
          int.parse(widget.subCat["ProductSrp"]);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // isWishList=widget.trendData["isFav"];
    discount();
    percent();
    isWishList = widget.subCat["isFav"];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 6, right: 6),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new ProductDetailScreen(
                            productDetail: widget.subCat["ProductId"],
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
                      height: 130,
                      child: Image.network(
                          Image_URL + "${widget.subCat["ProductImages"]}",
                          fit: BoxFit.contain)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 4.0,
                            top: 2.0,
                          ),
                          child: Text("${widget.subCat["ProductName"]}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _addToWishlist();
                        },
                        child: Container(
                          child: isWishList == false
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(right: 8.0, top: 5),
                                  child: Container(
                                      height: 20,
                                      width: 20,
                                      child: Image.asset(
                                        "assets/heart.png",
                                        color: appPrimaryMaterialColor,
                                      )),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.only(right: 8.0, top: 5),
                                  child: Container(
                                      height: 20,
                                      width: 20,
                                      child: Image.asset(
                                        "assets/020-heart.png",
                                        color: appPrimaryMaterialColor,
                                      )),
                                ),
                        ),
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     left: 4.0,
                  //     top: 6.0,
                  //   ),
                  //   child: Text("${widget.subCat["ProductDescription"]}",
                  //       overflow: TextOverflow.ellipsis,
                  //       maxLines: 1,
                  //       style: TextStyle(
                  //         color: Colors.grey[600],
                  //         fontSize: 12,
                  //         //  fontWeight: FontWeight.w500,
                  //       )),
                  // ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 1),
                      child: Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              // Text(
                              //  ,
                              //   style: TextStyle(
                              //       color: Colors.grey,
                              //       fontSize: 14,
                              //       fontWeight: FontWeight.w600),
                              // ),
                              Text(
                                "???" + "${widget.subCat["ProductSrp"]}",
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
                              "???" + "${widget.subCat["ProductMrp"]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              // "${widget.relatedProductData["ProductSrp"]}",
                              "(${percentResult.toStringAsFixed(0)}% OFF)",
                              style: TextStyle(
                                  // color: Colors.grey[600],
                                  color: appPrimaryMaterialColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        isFavLoading == true ? LoadingComponent() : Container()
      ],
    );
  }

  _addToWishlist() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        FormData body = FormData.fromMap({
          "CustomerId": prefs.getString(Session.CustomerId),
          "ProductId": "${widget.subCat["ProductId"]}",
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
