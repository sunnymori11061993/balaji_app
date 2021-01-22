import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        'Add_Rating_&_Review'.trim().toString(),
        style: TextStyle(
          fontSize: 22,
          color: appPrimaryMaterialColor,
          //fontWeight: FontWeight.bold
        ),
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
                physics: BouncingScrollPhysics(),
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
                    hintText: 'Write_Review'.trim().toString(),
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
            'Not_Now'.trim().toString(),
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
      // itemBuilder: (context, _) => Icon(
      //   _selectedIcon ?? Icons.star,
      //   color: appPrimaryMaterialColor,
      // ),
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating;
        });
      },
    );
  }
}
