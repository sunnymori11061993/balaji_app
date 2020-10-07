import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/CategoriesComponent.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Component/TrendingProductComponent.dart';
import 'package:balaji/Screens/Address%20Screen.dart';
import 'package:balaji/Screens/FAQScreen.dart';
import 'package:balaji/Screens/SearchingScreen.dart';
import 'package:balaji/Screens/TermsAndCondition.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_slider/image_slider.dart';
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

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertboxLogout();
      },
    );
  }

  _showDialogLang(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return ALertLang();
      },
    );
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
    Widget appBarTitle = Text(
      'home1'.tr().toString(),
      style: TextStyle(
          color: appPrimaryMaterialColor,
          //fontFamily: 'RobotoSlab',
          // color: Colors.black,
          fontSize: 17),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: appPrimaryMaterialColor),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(

              icon:Container(
                height: 20,
                width: 20,
                child: Image.asset(
                  "assets/012-house.png",
                  color: appPrimaryMaterialColor,
                ),
              ),
              title: Text("Home")),
          BottomNavigationBarItem(
              icon: Container(
                height: 20,
                width: 20,
                child: Image.asset(
                  "assets/020-heart.png",
                  color: appPrimaryMaterialColor,
                ),
              ),
              title: Text("Wishlist")),
          BottomNavigationBarItem(
              icon: Container(
                height: 20,
                width: 20,
                child: Image.asset(
                  "assets/051-user.png",
                  color: appPrimaryMaterialColor,
                ),
              ),
              title: Text("Profile")),
          BottomNavigationBarItem(
              icon: Container(
                height: 20,
                width: 20,
                child: Image.asset(
                  "assets/018-settings.png",
                  color: appPrimaryMaterialColor,
                ),
              ),
              title: Text("Setting")),
        ],
        //currentIndex: _selectedIndex,
        selectedItemColor: appPrimaryMaterialColor,
       // onTap: _onItemTapped,
      ),
      appBar: AppBar(
        title: appBarTitle,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: new IconThemeData(color: appPrimaryMaterialColor),
        actions: <Widget>[
          if (searchImage == false)
            Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    "assets/search.png",
                    color: appPrimaryMaterialColor,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 120,
                  height: 50,
                  child: TextFormField(
                    controller: txtSearch,
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
                    style: TextStyle(
                        //color: Colors.white,
                        ),
                    cursorColor: appPrimaryMaterialColor,
                    decoration: InputDecoration(
                        // prefixIcon: SizedBox(
                        //   height: 20,
                        //   width: 10,
                        //   child: Image.asset(
                        //     "assets/search.png",
                        //     color: appPrimaryMaterialColor,
                        //   ),
                        // ),

                        hintText: "    Search...",
                        hintStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        )),
                  ),
                ),
              ],
            ),
          GestureDetector(
            onTap: () {
              setState(() {
                searchImage = !searchImage;
              });
            },
            child: searchImage
                ? Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/search.png",
                        color: appPrimaryMaterialColor,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/025-cancel.png",
                        color: appPrimaryMaterialColor,
                      ),
                    ),
                  ),
          ),
          searchImage
              ? Padding(
                  padding: const EdgeInsets.only(
                    right: 10.0,
                    left: 8,
                  ),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/Whishlist');
                          },
                          child: Image.asset(
                            "assets/heart.png",
                            color: appPrimaryMaterialColor,
                          ))),
                )
              : Container(),
          searchImage
              ? Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 15.0, left: 8, top: 18),
                      child: Container(
                          height: 20,
                          width: 20,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/CartScreen');
                              },
                              child: Image.asset(
                                "assets/shopping-cart.png",
                                color: appPrimaryMaterialColor,
                              ))),
                    ),
                    // if (cartList.length > 0)
                    //   Padding(
                    //     padding: const EdgeInsets.only(
                    //         left: 0.0, top: 13, right: 10),
                    //     child: CircleAvatar(
                    //       radius: 6.0,
                    //       backgroundColor: Colors.red,
                    //       foregroundColor: Colors.white,
                    //       child: Text(
                    //         cartList.length.toString(),
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 10.0,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                  ],
                )
              : Container(),
        ],
      ),
      drawer: Drawer(
        child: ListView(
//          padding: EdgeInsets.zero,
          children: <Widget>[
//            DrawerHeader(
//                child:),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/ProfileScreen');
              },
              child: Container(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                        child: CircleAvatar(
                            radius: 40.0,
                            backgroundColor: appPrimaryMaterialColor,
                            foregroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: Image.asset(
                                "assets/051-user.png",
                                color: Colors.white,
                                height: 40,
                              ),
                            )),
                      ),
                      Text(
                        "${txtName}",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 20),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'drw_edit_profile'.tr().toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10.0, left: 5),
                              child: Container(
                                  height: 14,
                                  width: 14,
                                  child: Image.asset(
                                    "assets/052-edit.png",
                                    color: Colors.grey,
                                  )),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 5.0),
                            //   child: Icon(
                            //     Icons.edit,
                            //     color: Colors.grey,
                            //     size: 14,
                            //   ),
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/Home');
              },
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 4),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/home.png",
                        color: appPrimaryMaterialColor,
                      )),
                ),

                // Icon(
                //   Icons.home,
                //   color: appPrimaryMaterialColor,
                // ),
                title: Text(
                  'drw_home'.tr().toString(),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/HistoryScreen');
              },
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 4),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/history.png",
                        color: appPrimaryMaterialColor,
                      )),
                ),
                title: Text(
                  'drw_order_history'.tr().toString(),
                ),
              ),
            ),

//
            GestureDetector(
              onTap: () {
                //  Navigator.of(context).pushNamed('/ContactUs');
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new AddressScreen()));
              },
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 4),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/location.png",
                        color: appPrimaryMaterialColor,
                      )),
                ),
                title: Text(
                  'drw_manage_address'.tr().toString(),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                _showDialogLang(context);
              },
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 4),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/world-grid.png",
                        color: appPrimaryMaterialColor,
                      )),
                ),
                title: Text(
                  'drw_change_Lang'.tr().toString(),
                ),
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => new FAQScreen()));
              },
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 4),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/f.png",
                        color: appPrimaryMaterialColor,
                      )),
                ),
                title: Text(
                  'drw_faq'.tr().toString(),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Share.share('check out my website https://balaji.com',
                    subject: 'Look what An Amazing Clothes!');
              },
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 4),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/share.png",
                        color: appPrimaryMaterialColor,
                      )),
                ),
                title: Text(
                  'drw_share'.tr().toString(),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                launchwhatsapp(whatsappNumber: whatsapp, message: msg);
              },
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 4),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/phone-call.png",
                        color: appPrimaryMaterialColor,
                      )),
                ),
                title: Text(
                  'drw_Contact'.tr().toString(),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new TermsAndCondition(
                              termsConData: termsConList[0]
                                  ["SettingTermsConditionURL"],
                            )));
              },
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 4),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/file.png",
                        color: appPrimaryMaterialColor,
                      )),
                ),
                title: Text(
                  'drw_Terms'.tr().toString(),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                _showDialog(context);
              },
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 4),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/logout.png",
                        color: appPrimaryMaterialColor,
                      )),
                ),
                title: Text(
                  'drw_logout'.tr().toString(),
                ),
              ),
            ),
          ],
        ),
      ),
      body: isLoading
          ? LoadingComponent()
          : SingleChildScrollView(
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
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 10.0),
                      child: Container(
                        height: 120,
                        child: ListView.builder(
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
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                        ))
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
        var body = {};
        Services.PostForList(api_name: 'get_all_data_api/?tblName=tblcategory')
            .then((catResponseList) async {
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

  _getCart() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isGetCartLoading = true;
        SharedPreferences pref = await SharedPreferences.getInstance();
        FormData body = FormData.fromMap(
            {"customerId": pref.getString(Session.CustomerId)});
        Services.PostForList(api_name: 'get_data_where/tblcart', body: body)
            .then((responseList) async {
          setState(() {
            isGetCartLoading = false;
          });
          if (responseList.length > 0) {
            setState(() {
              cartList = responseList; //set "data" here to your variable
            });
          } else {
            setState(() {
              isGetCartLoading = false;
            });
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isGetCartLoading = false;
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
            _getCart();
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
        Services.PostForList(api_name: 'get_all_data_api/?tblName=tblsetting')
            .then((responseList) async {
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

class ALertLang extends StatefulWidget {
  @override
  _ALertLangState createState() => _ALertLangState();
}

class _ALertLangState extends State<ALertLang> {
  String lang = 'p1';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        'Select_Language'.tr().toString(),
        style: TextStyle(
            fontSize: 22,
            color: appPrimaryMaterialColor,
            //fontWeight: FontWeight.bold
        ),
      ),
      content: new Wrap(
        children: [
          ListTile(
            title: Column(
              children: <Widget>[
                Container(
                  height: 40,
                  child: RadioListTile(
                    activeColor: appPrimaryMaterialColor,
                    groupValue: lang,
                    title: Text('English'.tr().toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                    value: 'p1',
                    onChanged: (val) {
                      setState(() {
                        lang = val;
                      });
                    },
                  ),
                ),
                Container(
                  height: 40,
                  child: RadioListTile(
                    activeColor: appPrimaryMaterialColor,
                    groupValue: lang,
                    title: Text('Hindi'.tr().toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                    value: 'p2',
                    onChanged: (val) {
                      setState(() {
                        lang = val;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
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
            Navigator.of(context).pop();
            if (lang == 'p1') {
              EasyLocalization.of(context).locale = Locale('en', 'US');
            } else {
              EasyLocalization.of(context).locale = Locale('hi', 'HI');
            }
          },
        ),
      ],
    );
  }

// Container buildSwitchListTileMenuItem(
//     {BuildContext context, String title, String subtitle, Locale locale}) {
//   return Container(
//     margin: EdgeInsets.only(
//       left: 10,
//       right: 10,
//       top: 5,
//     ),
//     child: ListTile(
//         dense: true,
//         // isThreeLine: true,
//         title: Text(
//           title,
//         ),
//         subtitle: Text(
//           subtitle,
//         ),
//         onTap: () {
//           log(locale.toString(), name: toString());
//           context.locale = locale; //BuildContext extension method
//           //EasyLocalization.of(context).locale = locale;
//           Navigator.pop(context);
//         }),
//   );
// }
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
