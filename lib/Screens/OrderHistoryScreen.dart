import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Screens/ProductDetailScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:easy_localization/easy_localization.dart';

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
        title: Text("View Details",
            //'drw_order_history'.tr().toString(),
            style: TextStyle(
              color: Colors.black,
            )),
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
                                              fontSize: 14,
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
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              " ${viewOrderDetailList[index]["ProductQty"]}",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
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
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "₹",
                                            style: TextStyle(
                                                fontSize: 16,
                                                //color: Colors.white,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${widget.OrderData["OrderTotal"]}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                // color: Colors.white,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
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
                                          Icon(
                                            Icons.star,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 3.0),
                                            child: Text(
                                              "Rating",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  //  color: Colors.grey[700],
                                                  fontWeight: FontWeight.bold),
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

class RatingDialog extends StatefulWidget {
  var viewDetailProductId;

  RatingDialog({this.viewDetailProductId});

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  TextEditingController edtReviewController = new TextEditingController();
  var _ratingController = TextEditingController();
  double _rating;

  bool isLoading = false;

  //double _userRating = 3.0;
  int _ratingBarMode = 1;
  bool _isRTLMode = false;
  bool _isVertical = false;
  IconData _selectedIcon;
  bool isAddRatingLoading = false;

  @override
  void initState() {
    //_ratingController.text;
    _ratingController.text = "3.0";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        "Add Rating & Review",
        style: TextStyle(
            fontSize: 22,
            color: appPrimaryMaterialColor,
            fontWeight: FontWeight.bold),
      ),
      content: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Directionality(
              textDirection: _isRTLMode ? TextDirection.rtl : TextDirection.ltr,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      _ratingBar(_ratingBarMode),
                      SizedBox(
                        height: 20.0,
                      ),
                      _rating != null
                          ? Text(
                              "Rating: $_rating",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width - 140,
//
              child: TextFormField(
                controller: edtReviewController,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: 10, top: 18, right: 10),
                    hintText: "Write Review",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ))),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        FlatButton(
          child: new Text(
            "Not Now",
            style: TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new FlatButton(
          child: isAddRatingLoading
              ? LoadingComponent()
              : Text(
                  "Submit",
                  style:
                      TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
                ),
          onPressed: () {
            _addRating();
          },
        ),
      ],
    );
  }

  _addRating() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        FormData body = FormData.fromMap({
          "CustomerId": prefs.getString(Session.CustomerId),
          "ProductId": widget.viewDetailProductId,
          "RatingStar": _rating,
          "RatingReview": edtReviewController.text,
        });

        setState(() {
          isAddRatingLoading = true;
        });
        Services.postForSave(apiname: 'addRating', body: body).then(
            (responseList) async {
          setState(() {
            isAddRatingLoading = false;
          });
          if (responseList.IsSuccess == true && responseList.Data == "1") {
            Navigator.of(context).pop();
            Fluttertoast.showToast(
                msg: "Thank you for Rating Us!!!",
                gravity: ToastGravity.BOTTOM);
          } else {
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isAddRatingLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  Widget _ratingBar(int mode) {
    return RatingBar(
      initialRating: 0,
      minRating: 1,
      direction: _isVertical ? Axis.vertical : Axis.horizontal,
      allowHalfRating: true,
      unratedColor: appPrimaryMaterialColor.withAlpha(50),
      itemCount: 5,
      itemSize: 30.0,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        _selectedIcon ?? Icons.star,
        color: appPrimaryMaterialColor,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating;
        });
      },
    );
  }

  Widget _heading(String text) => Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 24.0,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      );
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
