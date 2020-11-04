import 'dart:developer';
import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Providers/CartProvider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

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
  int _m;
  int res = 0;
  var isLoading = false;
  bool isCartLoading = false;
  double percentResult;
  int value;

  percent() {
    setState(() {
      percentResult = value * 100 / int.parse(widget.getCartData["ProductMrp"]);
    });
    print(percentResult);
  }

  discount() {
    setState(() {
      value = int.parse(widget.getCartData["ProductMrp"]) -
          int.parse(widget.getCartData["ProductSrp"]);
    });
  }

  void add() {
    setState(() {
      _m++;
    });
    _updateCart("Add");
    widget.onAdd(int.parse(widget.getCartData["ProductSrp"]));
  }

  void minus() {
    if (_m != 1) {
      setState(() {
        _m--;
      });
      widget.onMinus(int.parse(widget.getCartData["ProductSrp"]));
      _updateCart("Remove");
    }
  }

  void total() {
    setState(() {
      res = int.parse("${widget.getCartData["ProductSrp"]}") * _m;
    });
  }

  _showDialog(BuildContext context) {
    //show alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            'Remove'.tr().toString(),
            style: TextStyle(
                fontSize: 22,
                color: appPrimaryMaterialColor,
                fontWeight: FontWeight.w400),
          ),
          content: new Text(
            'Are_you_sure_cart'.tr().toString(),
            style: TextStyle(
              fontSize: 14, color: Colors.black,
              //fontWeight: FontWeight.w600
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text(
                'Cancel'.tr().toString(),
                style: TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(
                'Ok'.tr().toString(),
                style: TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
              ),
              onPressed: () {
                _removeFromCart();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _m = int.parse("${widget.getCartData["CartQuantity"]}");
    total();
    discount();
    percent();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Container(
                      width: 95,
                      color: Colors.black,
                      child: Image.network(
                          Image_URL + "${widget.getCartData["ProductImages"]}",
                          fit: BoxFit.fill)),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 7.0, left: 35, right: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${widget.getCartData["ProductName"]}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 8.0, right: 4),
                        //   child: Text(
                        //     "${widget.getCartData["ProductDescription"]}",
                        //     overflow: TextOverflow.ellipsis,
                        //     style: TextStyle(
                        //         fontSize: 13,
                        //         color: Colors.grey,
                        //         fontWeight: FontWeight.w400),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(" ₹ ",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15)),
                                  Text("${widget.getCartData["ProductSrp"]}",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15)),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 6.0),
                                child: Text(
                                    "₹" + "${widget.getCartData["ProductMrp"]}",

                                    //  "${widget.productDetail["ProductMrp"]}",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        decoration:
                                            TextDecoration.lineThrough)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  // "${widget.relatedProductData["ProductSrp"]}",
                                  "(${percentResult.toStringAsFixed(0)}% OFF)",
                                  style: TextStyle(
                                      // color: Colors.grey[600],
                                      color: appPrimaryMaterialColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Container(
                            height: 40,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Sets  :",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                                /*IconButton(
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
                                ),*/
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      minus();
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18, right: 11),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[300],
                                              blurRadius: 2.0,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          border: Border.all(
                                              width: 1.4,
                                              color: appPrimaryMaterialColor)),
                                      width: 25,
                                      height: 25,
                                      child: Center(
                                        child: Icon(Icons.remove,
                                            color: appPrimaryMaterialColor,
                                            size: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5),
                                  //child: Text("${widget.getCartData["CartQuantity"]}"),
                                  child: Text(
                                    '$_m',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                // IconButton(
                                //   icon: Icon(
                                //     Icons.add_circle,
                                //     size: 20,
                                //   ),
                                //   onPressed: () {
                                //     add();
                                //   },
                                //   color: appPrimaryMaterialColor,
                                // ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      add();
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 11, right: 12),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[300],
                                              blurRadius: 2.0,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          border: Border.all(
                                              width: 1.4,
                                              color: appPrimaryMaterialColor)),
                                      width: 25,
                                      height: 25,
                                      child: Center(
                                        child: Icon(Icons.add,
                                            color: appPrimaryMaterialColor,
                                            size: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left:20.0,right: 20),
            //   child: Divider(),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: SizedBox(
                      height: 45,
                      width: 150,
                      child: FlatButton(
                        // color: appPrimaryMaterialColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: Colors.grey[300])),

                        onPressed: () {
                          _showDialog(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
//                          Icon(
//                            Icons.delete_forever,
//                            //color: Colors.white),
//                            color: Colors.grey[700],
//                          ),
                            Text(
                              'Remove'.tr().toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  // color: Colors.white,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.grey[300],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: SizedBox(
                      width: 150,
                      height: 45,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey[300])),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                'Amount'.tr().toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    //color: Colors.white,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                ": " + "${res}",
                                style: TextStyle(
                                    fontSize: 16,
                                    // color: Colors.white,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
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
            Provider.of<CartProvider>(context, listen: false).decrementCart(_m);
            log("donee");
            widget.onRemove(res);
            total();
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

  _updateCart(String updateType) async {
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
            if (updateType == "Add")
              Provider.of<CartProvider>(context, listen: false).increaseCart(1);
            else
              Provider.of<CartProvider>(context, listen: false).decrementCart();
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
