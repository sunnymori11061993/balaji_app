import 'package:balaji/Common/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HistoryComponent extends StatefulWidget {
  @override
  _HistoryComponentState createState() => _HistoryComponentState();
}

class _HistoryComponentState extends State<HistoryComponent> {
  _showDialog(BuildContext context) {
    //show alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Remove",
            style: TextStyle(
                fontSize: 22,
                color: appPrimaryMaterialColor,
                fontWeight: FontWeight.bold),
          ),
          content: new Text(
            "Are you sure want to remove!!!",
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
              child: new Text(
                "Ok",
                style: TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
              ),
              onPressed: () {
                // _removeFromWishlist();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _showDialogRate(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return RatingDialog(
            //id: '${widget.id}'
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Order No   :",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "1",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                  width: 98,
                  child: FlatButton(
                    // color: appPrimaryMaterialColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: Colors.grey[300])),
                    onPressed: () {
                      _showDialogRate(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          //color: Colors.white),
                          size: 12,
                          color: Colors.grey[700],
                        ),
                        Text(
                          "Give Rate",
                          style: TextStyle(
                              fontSize: 12,
                              //  color: Colors.white,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        ),
                      ],
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
                    "Status        :",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Processing",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w400),
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
                    "Total           :",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "₹12000",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w400),
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
                    "Order dt     :",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "02-09-20",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w400),
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
                    "Delivery dt :",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "12-09-20",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w400),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: SizedBox(
                      height: 45,
                      width: 150,
                      child: FlatButton(
                        color: appPrimaryMaterialColor,
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
                            Icon(Icons.delete_forever, color: Colors.white),
                            // color: Colors.grey[700],),
                            Text(
                              "Remove",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  // color: Colors.grey[700],
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
                    padding: const EdgeInsets.only(right: 0.0),
                    child: SizedBox(
                      width: 150,
                      height: 45,
                      child: FlatButton(
                        color: appPrimaryMaterialColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: Colors.grey[300])),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed('/OrderHistoryScreen');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.details,
                              color: Colors.white,
                            ),
                            Text(
                              "View Details",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  //  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold),
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
}

class RatingDialog extends StatefulWidget {
//  var title, author, id;

  // RatingDialog({this.title, this.author, this.id});

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

  DateTime _fromDateTime = DateTime.now();

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
        "Add Review & Rating",
        style: TextStyle(
            fontSize: 22,
            color: appPrimaryMaterialColor,
            fontWeight: FontWeight.bold),
      ),
      content: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width - 140,
//
            child: TextFormField(
              controller: edtReviewController,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, top: 18, right: 10),
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
//          Padding(
//            padding: const EdgeInsets.only(top: 8.0),
//            child: Text(
//              "Avg Rating",
//              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//            ),
//          ),
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
                      _heading('Rating Us'),
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
          child: new Text(
            "Submit",
            style: TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
          ),
          onPressed: () {
            // _bookReview();
            // _bookReview(widget.id);
          },
        ),
      ],
    );
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

//  _bookReview() async {
//    try {
//      //check Internet Connection
//      final result = await InternetAddress.lookup('google.com');
//      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//        setState(() {
//          isLoading = true;
//        });
//        //,edtReviewController.text
//        Future res = Services.SaveBookReview(
//            widget.id,
//            _fromDateTime.toString(),
//            edtReviewController.text,
//            _rating.toString());
//        res.then((data) async {
//          if (data.IsSuccess == true) {
//            setState(() {
//              isLoading = false;
//              edtReviewController.text = "";
//            });
//            Navigator.pop(context);
//            Fluttertoast.showToast(msg: "Thank you for Rating!!!");
//          } else {
//            setState(() {
//              isLoading = false;
//            });
//            //showMsg("Try Again.");
//          }
//        }, onError: (e) {
//          Fluttertoast.showToast(msg: "Something Went Wrong");
//          setState(() {
//            isLoading = false;
//          });
//        });
//      }
//    } on SocketException catch (_) {
//      setState(() {
//        isLoading = false;
//      });
//      Fluttertoast.showToast(msg: "No Internet Connection.");
//    }
//  }
}
