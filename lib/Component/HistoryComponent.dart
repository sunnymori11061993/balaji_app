import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Screens/OrderHistoryScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';

class HistoryComponent extends StatefulWidget {
  var orderData;
  Function getOrderapi;
  HistoryComponent({this.orderData, this.getOrderapi});
  @override
  _HistoryComponentState createState() => _HistoryComponentState();
}

class _HistoryComponentState extends State<HistoryComponent> {
  bool isCancelOrderLoading = false;
  _showDialog(BuildContext context) {
    //show alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Cancel Order",
            style: TextStyle(
              fontSize: 22,
              color: appPrimaryMaterialColor,
              //fontWeight: FontWeight.bold
            ),
          ),
          content: new Text(
            "Are you sure want to cancel order!!!",
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text(
                "Cancel",
                style: TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: Text(
                "Ok",
                style: TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
              ),
              onPressed: () {
                if (widget.orderData["OrderStageDropDown"] != "Cancel") {
                  _cancelOrder();
                  Navigator.of(context).pop();
                }

                // else {
                //   Fluttertoast.showToast(
                //       msg: "Your order is already cancelled");
                //   Navigator.of(context).pop();
                // }
              },
            ),
          ],
        );
      },
    );
  }

  _showDialog1(BuildContext context) {
    //show alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Cannot Cancel Order",
            style: TextStyle(
              fontSize: 22,
              color: appPrimaryMaterialColor,
              //fontWeight: FontWeight.bold
            ),
          ),
          content: new Text(
            "${widget.orderData["OrderMessage"]}",
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog

            new FlatButton(
                child: Text(
                  "Ok",
                  style:
                      TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }

                // else {
                //   Fluttertoast.showToast(
                //       msg: "Your order is already cancelled");
                //   Navigator.of(context).pop();
                // }

                ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 8.0, left: 15, right: 15, bottom: 8),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Order_No'.tr().toString() + "         :",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "${widget.orderData["OrderId"]}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      //fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Row(
                children: [
                  Text(
                    'Status'.tr().toString() + "             :",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "${widget.orderData["OrderStageDropDown"]}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                        //fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Row(
                children: [
                  Text(
                    'GST'.tr().toString() + "                 :",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "${widget.orderData["OrderGST"]}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                        // fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Row(
                children: [
                  Text(
                    'Sub-Total'.tr().toString() + "       :",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "${widget.orderData["OrderSubTotal"]}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                        // fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Row(
                children: [
                  Text(
                    'Totals'.tr().toString() + "                :",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "${widget.orderData["OrderTotal"]}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                        // fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Row(
                children: [
                  Text(
                    'Order_date'.tr().toString() + "      :",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "${widget.orderData["OrderDate"]}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                        //fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Row(
                children: [
                  Text(
                    'Delivery_date'.tr().toString() + " :",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "${widget.orderData["OrderDeliveryDate"]}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                        //  fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.orderData["OrderKey"] == "0"
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: AssetImage("assets/backchange.png"),
                                fit: BoxFit.cover),
                            // border: Border.all(color: Colors.grey[300]),
                            //    color: appPrimaryMaterialColor
                          ),
                          height: 45,
                          width: 150,
                          child: FlatButton(
                            //  color: appPrimaryMaterialColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(color: Colors.grey[300])),
                            onPressed: () {
                              if (widget.orderData["OrderStageDropDown"] !=
                                  "Cancel") {
                                _showDialog(context);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
//                            Icon(Icons.delete_forever, color: Colors.white),
                                // color: Colors.grey[700],),
                                widget.orderData["OrderStageDropDown"] !=
                                        "Cancel"
                                    ? Text(
                                        'Cancel_Order'.tr().toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            // color: Colors.grey[700],
                                            fontWeight: FontWeight.w400),
                                      )
                                    : Text(
                                        'Cancelled'.tr().toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            // color: Colors.grey[700],
                                            fontWeight: FontWeight.w400),
                                      ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: AssetImage("assets/backchange.png"),
                                fit: BoxFit.cover),
                            // border: Border.all(color: Colors.grey[300]),
                            //    color: appPrimaryMaterialColor
                          ),
                          height: 45,
                          width: 150,
                          child: FlatButton(
                            //  color: appPrimaryMaterialColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(color: Colors.grey[300])),
                            onPressed: () {
                              _showDialog1(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
//                            Icon(Icons.delete_forever, color: Colors.white),
                                // color: Colors.grey[700],),
                                Text(
                                  'CannotCancel'.tr().toString(),
                                  //'Cannot Cancel',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      // color: Colors.grey[700],
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.grey[300],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: AssetImage("assets/backchange.png"),
                            fit: BoxFit.cover),
                        // border: Border.all(color: Colors.grey[300]),
                        //    color: appPrimaryMaterialColor
                      ),
                      width: 150,
                      height: 45,
                      child: FlatButton(
                        //color: appPrimaryMaterialColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: Colors.grey[300])),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new OrderHistoryScreen(
                                        OrderData: widget.orderData,
                                      )));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
//                            Icon(
//                              Icons.details,
//                              color: Colors.white,
//                            ),
                            Text(
                              'View_Details'.tr().toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  //  color: Colors.grey[700],
                                  fontWeight: FontWeight.w400),
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
      ),
    );
  }

  _cancelOrder() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        FormData body = FormData.fromMap({
          "OrderId": "${widget.orderData["OrderId"]}",
        });
        setState(() {
          isCancelOrderLoading = true;
        });
        Services.postForSave(apiname: 'cancelOrder', body: body).then(
            (responseList) async {
          setState(() {
            isCancelOrderLoading = false;
          });
          if (responseList.IsSuccess == true && responseList.Data == "1") {
            // widget.onRemove();
            // widget.orderData;
            widget.getOrderapi();
            Fluttertoast.showToast(msg: "Order Cancel Successfully!!!");
          } else {
            Fluttertoast.showToast(msg: "Problem in Order Cancellation");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isCancelOrderLoading = false;
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
