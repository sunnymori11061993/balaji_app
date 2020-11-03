import 'dart:developer';
import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Component/WishlistComponent.dart';
import 'package:balaji/Providers/CartProvider.dart';
import 'package:balaji/Screens/SearchingScreen.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';

// class Whishlist extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ShowCaseWidget(
//         onStart: (index, key) {
//           log('onStart: $index, $key');
//         },
//         onComplete: (index, key) {
//           log('onComplete: $index, $key');
//         },
//         builder: Builder(builder: (context) => Whishlist()),
//         autoPlay: true,
//         autoPlayDelay: Duration(seconds: 3),
//       ),
//     );
//   }
// }

class Whishlist extends StatefulWidget {
  @override
  _WhishlistState createState() => _WhishlistState();
}

class _WhishlistState extends State<Whishlist> {
  bool isLoading = true;
  List wishList = [];
  String isShowcase = "false";
  TextEditingController txtSearch = TextEditingController();
  bool searchImage = true;

  // showShowCase() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   isShowcase = prefs.getString(showSession.showCaseWislist);
  //
  //   // if (isShowcase == null || isShowcase == "false") {
  //   //   WidgetsBinding.instance.addPostFrameCallback(
  //   //       (_) => ShowCaseWidget.of(context).startShowCase([_one]));
  //   //   prefs.setString(showSession.showCaseWislist, "true");
  //   // }
  //   // ;
  // }

  @override
  void initState() {
    _wishList();
    //showShowCase();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider provider = Provider.of<CartProvider>(context);
    Widget appBarTitle = Text(
      'Wishlist'.tr().toString(),
      style: TextStyle(
          color: appPrimaryMaterialColor,
          //fontFamily: 'RobotoSlab',
          // color: Colors.black,
          fontSize: 17),
    );
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop("pop");
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            // leading: Padding(
            //   padding: const EdgeInsets.only(top: 8.0, left: 5, bottom: 8),
            //   child: GestureDetector(
            //       onTap: () {
            //         Navigator.of(context).pop("pop");
            //       },
            //       child: Image.asset(
            //         "assets/backarrow.png",
            //         //color: appPrimaryMaterialColor,
            //       )),
            // ),
            elevation: 1,
            backgroundColor: Colors.white,
            iconTheme: new IconThemeData(
              color: appPrimaryMaterialColor,
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: appBarTitle,
            ),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/CartScreen');
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 15.0, left: 8, top: 18),
                      child: Container(
                          height: 20,
                          width: 20,
                          child: Image.asset(
                            "assets/shopping-cart.png",
                            color: appPrimaryMaterialColor,
                          )),
                    ),
                    provider.cartCount > 0
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 1.0, top: 13, right: 10),
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
                ),
              )
            ],
          ),
          body: isLoading
              ? LoadingComponent()
              : wishList.length > 0
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: wishList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return WishlistComponent(
                            wishListData: wishList[index],
                            onRemove: () {
                              setState(() {
                                wishList.removeAt(index);
                              });
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          thickness: 2,
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                      'Wishlist_Data_Not_Found'.tr().toString(),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600),
                    ))),
    );
  }

  _wishList() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });

        SharedPreferences pref = await SharedPreferences.getInstance();
        FormData body = FormData.fromMap(
            {"customerId": pref.getString(Session.CustomerId)});
        Services.PostForList(api_name: 'get_data_where/tblwishlist', body: body)
            .then((responseList) async {
          setState(() {
            isLoading = false;
          });
          if (responseList.length > 0) {
            setState(() {
              wishList = responseList;
              //set "data" here to your variable
            });
          } else {
            setState(() {
              isLoading = false;
            });
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
