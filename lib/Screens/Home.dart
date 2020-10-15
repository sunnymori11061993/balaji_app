import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/CategoriesComponent.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Component/TrendingProductComponent.dart';
import 'package:balaji/Providers/CartProvider.dart';
import 'package:balaji/Screens/AboutUsScreen.dart';
import 'package:balaji/Screens/Address%20Screen.dart';
import 'package:balaji/Screens/FAQScreen.dart';
import 'package:balaji/Screens/SearchingScreen.dart';
import 'package:balaji/Screens/TermsAndCondition.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_slider/image_slider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

//slider

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool isLoading = true;
  bool isTermLoading = false;
  List termsConList = [];

  List contactList = [];
  List imgList = [];
  List catList = [];
  List trendingProductList = [];

  List cartList = [];
  bool isGetCartLoading = true;
  bool isSearching = false;
  bool isFavLoading = false;
  String msg, whatsapp;

  bool isBannerLoading = true;
  bool searchImage = true;
  String txtName = "";

  TabController tabController;

  TextEditingController txtSearch = TextEditingController();

  @override
  void initState() {
    _bannerImage();
    _categoryImage();
    _trendingProduct();
    _settingApi();
    userName();
    // _getCart();
  }

  void launchwhatsapp({
    @required String whatsappNumber,
    @required String message,
  }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$whatsappNumber/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?phone=$whatsappNumber&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  userName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      txtName = prefs.getString(Session.CustomerName);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Widget appBarTitle = Text(
    //   'home1'.tr().toString(),
    //   style: TextStyle(
    //       color: appPrimaryMaterialColor,
    //       //fontFamily: 'RobotoSlab',
    //       // color: Colors.black,
    //       fontSize: 17),
    // );
    CartProvider provider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: Padding(
        //   padding: const EdgeInsets.only(left: 15.0),
        //   child: appBarTitle,
        // ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: new IconThemeData(color: appPrimaryMaterialColor),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 13.0, bottom: 13),
            child: Container(
              width: MediaQuery.of(context).size.width - 57,
              //height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey[100],
              ),
              child: TextFormField(
                controller: txtSearch,
                maxLines: 1,
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (aa) {
                  //  _getSearching();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new SearchingScreen(
                                searchData: txtSearch.text,
                              )));
                  txtSearch.clear();
                  //Navigator.pop(context, this.txtSearch.text);
                },
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    prefixIcon: Container(
                        height: 35,
                        width: 35,
                        padding: EdgeInsets.only(
                            left: 7, right: 0, top: 7, bottom: 7),
                        child: Image.asset(
                          "assets/search.png",
                          color: Colors.grey,
                        )),
                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                    contentPadding: EdgeInsets.only(
                        left: 10, bottom: 12, top: 7, right: 15),
                    hintText: 'Search'.tr().toString()),
              ),
            ),
          ),
          // if (searchImage == false)
          //   Row(
          //     children: [
          //       Container(
          //         height: 20,
          //         width: 20,
          //         child: Image.asset(
          //           "assets/search.png",
          //           color: appPrimaryMaterialColor,
          //         ),
          //       ),
          //       Container(
          //         width: MediaQuery.of(context).size.width - 80,
          //         height: 50,
          //         child: TextFormField(
          //           controller: txtSearch,
          //           textInputAction: TextInputAction.done,
          //           onFieldSubmitted: (aa) {
          //             //  _getSearching();
          //             Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: (BuildContext context) =>
          //                         new SearchingScreen(
          //                           searchData: txtSearch.text,
          //                         )));
          //             txtSearch.clear();
          //             //Navigator.pop(context, this.txtSearch.text);
          //           },
          //           style: TextStyle(
          //               //color: Colors.white,
          //               ),
          //           cursorColor: appPrimaryMaterialColor,
          //           decoration: InputDecoration(
          //               // prefixIcon: SizedBox(
          //               //   height: 20,
          //               //   width: 10,
          //               //   child: Image.asset(
          //               //     "assets/search.png",
          //               //     color: appPrimaryMaterialColor,
          //               //   ),
          //               // ),
          //
          //               hintText: "    Search...",
          //               hintStyle: TextStyle(color: Colors.grey),
          //               focusedBorder: UnderlineInputBorder(
          //                 borderSide: BorderSide(color: Colors.grey),
          //               )),
          //         ),
          //       ),
          //     ],
          //   ),
          // GestureDetector(
          //   onTap: () {
          //     setState(() {
          //       searchImage = !searchImage;
          //     });
          //   },
          //   child: searchImage
          //       ? Padding(
          //           padding: const EdgeInsets.only(right: 15.0),
          //           child: Container(
          //             height: 20,
          //             width: 20,
          //             child: Image.asset(
          //               "assets/search.png",
          //               color: appPrimaryMaterialColor,
          //             ),
          //           ),
          //         )
          //       : Padding(
          //           padding: const EdgeInsets.only(right: 15.0),
          //           child: Container(
          //             height: 20,
          //             width: 20,
          //             child: Image.asset(
          //               "assets/025-cancel.png",
          //               color: appPrimaryMaterialColor,
          //             ),
          //           ),
          //         ),
          // ),
          //
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/CartScreen');
            },
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 15.0, left: 13, top: 18),
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
                            left: 5.0, top: 13, right: 10),
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
//       drawer: Drawer(
//         child: ListView(
// //          padding: EdgeInsets.zero,
//           children: <Widget>[
// //            DrawerHeader(
// //                child:),
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pushNamed('/ProfileScreen');
//               },
//               child: Container(
//                 color: Colors.grey[200],
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 25.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20.0, bottom: 10),
//                         child: CircleAvatar(
//                             radius: 40.0,
//                             backgroundColor: appPrimaryMaterialColor,
//                             foregroundColor: Colors.white,
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 0.0),
//                               child: Image.asset(
//                                 "assets/051-user.png",
//                                 color: Colors.white,
//                                 height: 40,
//                               ),
//                             )),
//                       ),
//                       Text(
//                         "${txtName}",
//                         style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 5.0, bottom: 20),
//                         child: Row(
//                           children: <Widget>[
//                             Text(
//                               'drw_edit_profile'.tr().toString(),
//                               style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(right: 10.0, left: 5),
//                               child: Container(
//                                   height: 14,
//                                   width: 14,
//                                   child: Image.asset(
//                                     "assets/052-edit.png",
//                                     color: Colors.grey,
//                                   )),
//                             ),
//                             // Padding(
//                             //   padding: const EdgeInsets.only(left: 5.0),
//                             //   child: Icon(
//                             //     Icons.edit,
//                             //     color: Colors.grey,
//                             //     size: 14,
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pushNamed('/HomePage');
//               },
//               child: ListTile(
//                 leading: Padding(
//                   padding: const EdgeInsets.only(right: 10.0, left: 4),
//                   child: Container(
//                       height: 20,
//                       width: 20,
//                       child: Image.asset(
//                         "assets/home.png",
//                         color: appPrimaryMaterialColor,
//                       )),
//                 ),
//
//                 // Icon(
//                 //   Icons.home,
//                 //   color: appPrimaryMaterialColor,
//                 // ),
//                 title: Text(
//                   'drw_home'.tr().toString(),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pushNamed('/HistoryScreen');
//               },
//               child: ListTile(
//                 leading: Padding(
//                   padding: const EdgeInsets.only(right: 10.0, left: 4),
//                   child: Container(
//                       height: 20,
//                       width: 20,
//                       child: Image.asset(
//                         "assets/history.png",
//                         color: appPrimaryMaterialColor,
//                       )),
//                 ),
//                 title: Text(
//                   'drw_order_history'.tr().toString(),
//                 ),
//               ),
//             ),
//
// //
//             GestureDetector(
//               onTap: () {
//                 //  Navigator.of(context).pushNamed('/ContactUs');
//                 Navigator.of(context).pop();
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (BuildContext context) =>
//                             new AddressScreen()));
//               },
//               child: ListTile(
//                 leading: Padding(
//                   padding: const EdgeInsets.only(right: 10.0, left: 4),
//                   child: Container(
//                       height: 20,
//                       width: 20,
//                       child: Image.asset(
//                         "assets/location.png",
//                         color: appPrimaryMaterialColor,
//                       )),
//                 ),
//                 title: Text(
//                   'drw_manage_address'.tr().toString(),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pop();
//                 _showDialogLang(context);
//               },
//               child: ListTile(
//                 leading: Padding(
//                   padding: const EdgeInsets.only(right: 10.0, left: 4),
//                   child: Container(
//                       height: 20,
//                       width: 20,
//                       child: Image.asset(
//                         "assets/world-grid.png",
//                         color: appPrimaryMaterialColor,
//                       )),
//                 ),
//                 title: Text(
//                   'drw_change_Lang'.tr().toString(),
//                 ),
//               ),
//             ),
//             Divider(),
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pop();
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (BuildContext context) => new FAQScreen()));
//               },
//               child: ListTile(
//                 leading: Padding(
//                   padding: const EdgeInsets.only(right: 10.0, left: 4),
//                   child: Container(
//                       height: 20,
//                       width: 20,
//                       child: Image.asset(
//                         "assets/f.png",
//                         color: appPrimaryMaterialColor,
//                       )),
//                 ),
//                 title: Text(
//                   'drw_faq'.tr().toString(),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pop();
//                 Share.share('check out my website https://balaji.com',
//                     subject: 'Look what An Amazing Clothes!');
//               },
//               child: ListTile(
//                 leading: Padding(
//                   padding: const EdgeInsets.only(right: 10.0, left: 4),
//                   child: Container(
//                       height: 20,
//                       width: 20,
//                       child: Image.asset(
//                         "assets/share.png",
//                         color: appPrimaryMaterialColor,
//                       )),
//                 ),
//                 title: Text(
//                   'drw_share'.tr().toString(),
//                 ),
//               ),
//             ),
//
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pop();
//                 launchwhatsapp(whatsappNumber: whatsapp, message: msg);
//               },
//               child: ListTile(
//                 leading: Padding(
//                   padding: const EdgeInsets.only(right: 10.0, left: 4),
//                   child: Container(
//                       height: 20,
//                       width: 20,
//                       child: Image.asset(
//                         "assets/phone-call.png",
//                         color: appPrimaryMaterialColor,
//                       )),
//                 ),
//                 title: Text(
//                   'drw_Contact'.tr().toString(),
//                 ),
//               ),
//             ),
//
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pop();
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (BuildContext context) =>
//                             new TermsAndCondition(
//                               termsConData: termsConList[0]
//                                   ["SettingTermsConditionURL"],
//                             )));
//               },
//               child: ListTile(
//                 leading: Padding(
//                   padding: const EdgeInsets.only(right: 10.0, left: 4),
//                   child: Container(
//                       height: 20,
//                       width: 20,
//                       child: Image.asset(
//                         "assets/file.png",
//                         color: appPrimaryMaterialColor,
//                       )),
//                 ),
//                 title: Text(
//                   'drw_Terms'.tr().toString(),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pop();
//                 _showDialog(context);
//               },
//               child: ListTile(
//                 leading: Padding(
//                   padding: const EdgeInsets.only(right: 10.0, left: 4),
//                   child: Container(
//                       height: 20,
//                       width: 20,
//                       child: Image.asset(
//                         "assets/logout.png",
//                         color: appPrimaryMaterialColor,
//                       )),
//                 ),
//                 title: Text(
//                   'drw_logout'.tr().toString(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
      body: isLoading
          ? LoadingComponent()
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    isBannerLoading
                        ? LoadingComponent()
                        : Container(
                            //margin: EdgeInsets.all(10),
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(10),
                            //     border: Border.all(width: 2)),
                            child: ImageSlider(
                              /// Shows the tab indicating circles at the bottom
                              showTabIndicator: true,

                              /// Cutomize tab's colors
                              tabIndicatorColor: appPrimaryMaterialColor[200],

                              /// Customize selected tab's colors
                              tabIndicatorSelectedColor:
                                  appPrimaryMaterialColor,

                              /// Height of the indicators from the bottom
                              tabIndicatorHeight: 16,

                              /// Size of the tab indicator circles
                              tabIndicatorSize: 12,

                              /// tabController for walkthrough or other implementations
                              tabController: tabController,

                              /// Animation curves of sliding
                              curve: Curves.fastOutSlowIn,

                              /// Width of the slider
                              width: MediaQuery.of(context).size.width,

                              /// Height of the slider
                              height: 200,

                              /// If automatic sliding is required
                              autoSlide: true,

                              /// Time for automatic sliding
                              duration: new Duration(seconds: 3),

                              /// If manual sliding is required
                              allowManualSlide: true,

                              /// Children in slideView to slide
                              children: imgList.map((link) {
                                return new ClipRRect(
                                    // borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                  Image_URL + link["BannerImage"],
                                  width: MediaQuery.of(context).size.width,
                                  height: 220,
                                  fit: BoxFit.fill,
                                ));
                              }).toList(),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        color: Colors.grey[100],
                        height: 10,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 20.0),
                      child: Text(
                        'Categories'.tr().toString(),
                        style: TextStyle(
                            fontSize: 14,
                            // color: Colors.black54,
                            color: appPrimaryMaterialColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 10.0),
                      child: Container(
                        height: 120,
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: catList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CategoriesComponent(catList[index]);
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        color: Colors.grey[100],
                        height: 10,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 20.0),
                      child: Text(
                        'Trending_Products'.tr().toString(),
                        style: TextStyle(
                            fontSize: 14,
                            //fontFamily: 'RobotoSlab',
                            color: appPrimaryMaterialColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.60,
                            //widthScreen / heightScreen,
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 2.0),
                        itemBuilder: (BuildContext context, int index) {
                          return TrendingProductComponent(
                              trendingProductList[index]);
                        },
                        itemCount: trendingProductList.length,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0, top: 5),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.of(context).pushNamed('/AboutUsScreen');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new AboutUsScreen(
                                          aboutData: termsConList[0]
                                              ["SettingAboutUsURL"],
                                        )));
                          },
                          child: Container(
                            height: 25,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.grey[300],
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    'Know_more'.tr().toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  _bannerImage() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isBannerLoading = true;
        });
        var body = {};
        Services.PostForList(api_name: 'get_all_data_api/?tblName=tblbanner')
            .then((bannerresponselist) async {
          setState(() {
            isBannerLoading = false;
          });
          if (bannerresponselist.length > 0) {
            setState(() {
              imgList = bannerresponselist;
              tabController =
                  TabController(length: imgList.length, vsync: this);
              //set "data" here to your variable
            });
          } else {
            Fluttertoast.showToast(msg: "Banner Not Found");
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

  _categoryImage() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isLoading = true;
        SharedPreferences prefs = await SharedPreferences.getInstance();

        FormData body =
            FormData.fromMap({"Language": prefs.getString(Session.langauge)});
        Services.PostForList(api_name: 'getCategorAPI', body: body).then(
            (catResponseList) async {
          if (catResponseList.length > 0) {
            setState(() {
              isLoading = false;
              catList = catResponseList;
              //set "data" here to your variable
            });
          } else {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "Data Not Found");
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

  _trendingProduct() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isLoading = true;
        var body = {};
        Services.PostForList(api_name: 'get_trending_product_api').then(
            (trendProductResponseList) async {
          if (trendProductResponseList.length > 0) {
            setState(() {
              isLoading = false;
              trendingProductList = trendProductResponseList;
              //isWishList = trendProductResponseList[0]["isFav"];
              //set "data" here to your variable
            });
          } else {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "Data Not Found");
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

  _settingApi() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isTermLoading = true;
        SharedPreferences prefs = await SharedPreferences.getInstance();

        FormData body =
            FormData.fromMap({"Language": prefs.getString(Session.langauge)});
        Services.PostForList(api_name: 'getSetting', body: body).then(
            (responseList) async {
          if (responseList.length > 0) {
            setState(() {
              isTermLoading = false;
              termsConList = responseList;
              msg = responseList[0]["SettingWhatsAppMessage"];
              whatsapp = "+91" + responseList[0]["SettingWhatsAppNumber"];

              //set "data" here to your variable
            });
          } else {
            setState(() {
              isTermLoading = false;
            });
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isTermLoading = false;
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

class AlertboxLogout extends StatefulWidget {
  @override
  _AlertboxLogoutState createState() => _AlertboxLogoutState();
}

class _AlertboxLogoutState extends State<AlertboxLogout> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        'drw_logout'.tr().toString(),
        style: TextStyle(
          fontSize: 22,
          color: appPrimaryMaterialColor,
          // fontWeight: FontWeight.bold
        ),
      ),
      content: new Text(
        "Are you sure want to Logout!!!",
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
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            Navigator.pushNamedAndRemoveUntil(
                context, '/LoginScreen', (route) => false);
          },
        ),
      ],
    );
  }
}
