import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartComponent extends StatefulWidget {
  var getCartData;
  Function onRemove;
  Function onAdd;
  Function onMinus;

  CartComponent({this.getCartData, this.onAdd, this.onMinus, this.onRemove});

  @override
  _CartComponentState createState() => _CartComponentState();
}

class _CartComponentState extends State<CartComponent> {
  int _m = 1;
  int res = 0;
  var isLoading = false;
  bool isCartLoading = false;

  void add() {
    setState(() {
      _m++;
    });
    total();
    _updateCart();
    widget.onAdd(int.parse(widget.getCartData["ProductSrp"]));
  }

  void minus() {
    setState(() {
      if (_m != 1) _m--;
    });
    total();
    _updateCart();
    widget.onMinus(int.parse(widget.getCartData["ProductSrp"]));
  }

  void total() {
    setState(() {
      res = int.parse("${widget.getCartData["ProductSrp"]}") * _m;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _m = int.parse("${widget.getCartData["CartQuantity"]}");
    total();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Container(
                  width: 95,
                  child: Image.network(
                      Image_URL + "${widget.getCartData["ProductImages"]}",
                      fit: BoxFit.fill)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 7.0, left: 15, right: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "${widget.getCartData["ProductName"]}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () {
                            _removeFromCart();
                          },
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: appPrimaryMaterialColor,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 4),
                      child: Text(
                        "${widget.getCartData["ProductDescription"]}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          Text("₹" + "${widget.getCartData["ProductSrp"]}",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                                "₹" + "${widget.getCartData["ProductMrp"]}",

                                //  "${widget.productDetail["ProductMrp"]}",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    decoration: TextDecoration.lineThrough)),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Quantity :",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.remove_circle,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              minus();
                            });
                          },
                          color: appPrimaryMaterialColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5),
                          //child: Text("${widget.getCartData["CartQuantity"]}"),
                          child: Text('$_m'),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            size: 20,
                          ),
                          onPressed: () {
                            add();
                          },
                          color: appPrimaryMaterialColor,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 3, bottom: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 150,
                            height: 40,
                            // color: appPrimaryMaterialColor,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                // border: Border.all(color: Colors.grey[300]),
                                color: appPrimaryMaterialColor),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Total :",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "₹",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "${res}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        isLoading == true ? LoadingComponent() : Container(),
        isCartLoading ? LoadingComponent() : Container()
      ],
    );
  }

  _removeFromCart() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        FormData body = FormData.fromMap({
          "CartId": "${widget.getCartData["CartId"]}",
        });
        setState(() {
          isCartLoading = true;
        });
        Services.postForSave(apiname: 'removeCart', body: body).then(
            (responseList) async {
          setState(() {
            isCartLoading = false;
          });
          if (responseList.IsSuccess == true && responseList.Data == "1") {
            widget.onRemove();
          } else {
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isCartLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  _updateCart() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        FormData body = FormData.fromMap(
            {"CartId": "${widget.getCartData["CartId"]}", "CartQuantity": _m});
        Services.postForSave(apiname: 'updateCartQty', body: body).then(
            (responseList) async {
          if (responseList.IsSuccess == true && responseList.Data == "1") {
            setState(() {
              isLoading = false;
            });
            total();
          } else {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "Retry Again!!!!!");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isLoading = false;
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
