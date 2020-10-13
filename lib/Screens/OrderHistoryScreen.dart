import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Component/RatingDialogComponent.dart';
import 'package:balaji/Providers/CartProvider.dart';
import 'package:balaji/Screens/ProductDetailScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:easy_localization/easy_localization.dart';

class OrderHistoryScreen extends StatefulWidget {
  var OrderData;

  OrderHistoryScreen({this.OrderData});

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with TickerProviderStateMixin {
  List viewOrderDetailList = [];
  bool isViewDetailLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    _viewOrderDetail();
  }

//  TabController _tabController;
//
//  @override
//  void initState() {
//    super.initState();
//
//    _tabController = TabController(
//      vsync: this,
//      length: 2,
//      initialIndex: 0,
//    );
//
//    _tabController.addListener(() {
//      print(_tabController.index);
//    });
//  }
  _showDialogRate(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return RatingDialog(
          viewDetailProductId: viewOrderDetailList[index]["ProductId"],
        );
      },
    );
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
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 8, top: 18),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/CartScreen');
                  },
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/shopping-cart.png",
                        color: appPrimaryMaterialColor,
                      )),
                ),
              ),
              provider.cartCount > 0
                  ? Padding(
                      padding:
                          const EdgeInsets.only(left: 1.0, top: 13, right: 10),
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
          )
        ],
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(
          color: appPrimaryMaterialColor,
        ),
        title: Text(
            // "View Details",
            'View_Details'.tr().toString(),
            style: TextStyle(color: appPrimaryMaterialColor, fontSize: 17)),
      ),
      body: isViewDetailLoading
          ? LoadingComponent()
          : Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView.separated(
                itemCount: viewOrderDetailList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new ProductDetailScreen(
                            productDetail: viewOrderDetailList[index]
                                ["ProductId"],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Container(
                                    height: 120,
                                    width: 95,
                                    child: Image.network(
                                        Image_URL +
                                            "${viewOrderDetailList[index]["ProductImages"]}",
                                        fit: BoxFit.fill)),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 6.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "${viewOrderDetailList[index]["ProductName"]}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, right: 4),
                                        child: Text(
                                          "${viewOrderDetailList[index]["ProductDescription"]}",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "Qty :",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              " ${viewOrderDetailList[index]["ProductQty"]}",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: SizedBox(
                                    height: 45,
                                    width: 150,
                                    child: FlatButton(
                                      color: appPrimaryMaterialColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          side: BorderSide(
                                              color: Colors.grey[300])),
                                      onPressed: () {
                                        //_showDialog(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Total :",
                                            style: TextStyle(
                                                fontSize: 16,
                                                //color: Colors.white,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            "₹",
                                            style: TextStyle(
                                                fontSize: 16,
                                                //color: Colors.white,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            "${widget.OrderData["OrderTotal"]}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                // color: Colors.white,
                                                color: Colors.white,
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
                                    child: FlatButton(
                                      color: appPrimaryMaterialColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          side: BorderSide(
                                              color: Colors.grey[300])),
                                      onPressed: () {
                                        _showDialogRate(context, index);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
//                                          Icon(
//                                            Icons.star,
//                                            size: 20,
//                                            color: Colors.white,
//                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 3.0),
                                            child: Text(
                                              "Rating",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  //  color: Colors.grey[700],
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
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Divider(
                  thickness: 2,
                ),
              ),
            ),
    );
  }

  _viewOrderDetail() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isViewDetailLoading = true;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        FormData body =
            FormData.fromMap({"OrderId": widget.OrderData["OrderId"]});
        // var body = {"CustomerId": prefs.getString(Session.CustomerId)};
        //  print(prefs.getString(Session.CustomerId));
        Services.PostForList(api_name: 'orderHistoryDetail', body: body).then(
            (responseList) async {
          setState(() {
            isViewDetailLoading = false;
          });
          if (responseList.length > 0) {
            setState(() {
              viewOrderDetailList = responseList;
              //set "data" here to your variable
            });
          } else {
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isViewDetailLoading = false;
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

//Row(
//children: <Widget>[
//Expanded(
//child: Column(
//children: [
//Padding(
//padding: const EdgeInsets.only(top: 10.0),
//child: Container(
//height: 40,
//width: MediaQuery.of(context).size.width,
//child: TabBar(
////isScrollable: true,//do only when there is more tab
//controller: _tabController,
//unselectedLabelColor: Colors.grey,
//labelColor: appPrimaryMaterialColor,
//indicatorColor: appPrimaryMaterialColor,
////labelPadding: EdgeInsets.symmetric(horizontal: 30),
//tabs: [
//Tab(
//child: Text(
//"Active Order",
//style: TextStyle(fontWeight: FontWeight.bold),
//),
//),
//Tab(
//child: Text(
//"Completed Order",
//style: TextStyle(fontWeight: FontWeight.bold),
//),
//),
//],
//),
//),
//),
//Flexible(
//child: TabBarView(
////contents
//controller: _tabController,
//children: [
//Padding(
//padding: const EdgeInsets.only(top: 8.0),
//child: ListView.separated(
//itemCount: 3,
//itemBuilder: (BuildContext context, int index) {
//return ActiveOrderComponent();
//},
//separatorBuilder: (BuildContext context, int index) =>
//Divider(
//thickness: 2,
//),
//),
//),
//Padding(
//padding: const EdgeInsets.only(top: 8.0),
//child: ListView.separated(
//itemCount: 3,
//itemBuilder: (BuildContext context, int index) {
//return CompletedOrderComponent();
//},
//separatorBuilder: (BuildContext context, int index) =>
//Divider(
//thickness: 2,
//),
//),
//),
//],
//),
//),
//],
//),
//),
//],
//),
