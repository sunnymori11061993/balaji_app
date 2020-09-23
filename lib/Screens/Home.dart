import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/CategoriesComponent.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Component/TrendingProductComponent.dart';
import 'package:balaji/Screens/Address%20Screen.dart';
import 'package:balaji/Screens/LanguageChangeScreen.dart';
import 'package:balaji/Screens/TermsAndCondition.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

//slider

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  bool isTermLoading = false;
  List termsConList = [];
  List contactList = [];
  List imgList = [];
  List catList = [];

  List trendingProductList = [];
  bool isSearching = false;
  bool isFavLoading = false;

  Icon actionIcon = Icon(
    Icons.search,
    //color: Colors.white,
  );
  Widget appBarTitle = Text(
    "HOME",
    style: TextStyle(
        // color: appPrimaryMaterialColor,
        color: Colors.black,
        fontSize: 17),
  );
  TextEditingController txtSearch = TextEditingController();

  @override
  void initState() {
    _bannerImage();
    _categoryImage();
    _trendingProduct();
    _termsCon();
    _contactUs();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: appBarTitle,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: new IconThemeData(color: appPrimaryMaterialColor),
        actions: <Widget>[
          IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = Icon(
                      Icons.close,
                      //color: Colors.white,
                    );
                    this.appBarTitle = Container(
                      child: TextField(
                        controller: txtSearch,
                        style: TextStyle(
                            //color: Colors.white,
                            ),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            prefixIcon: new Icon(
                              Icons.search,
                              color: appPrimaryMaterialColor,

                              //    color: Colors.white
                            ),
                            hintText: "Search...",
                            hintStyle: TextStyle(color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            )),
                      ),
                    );
                  } else {
                    this.actionIcon = Icon(
                      Icons.search,
                      //color: Colors.white,
                    );

                    this.appBarTitle = Text(
                      "HOME",
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    );
                    // txtSearch.clear();
                  }
                });
              }),
          actionIcon.icon == Icons.close
              ? Container()
              : IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/Whishlist');
                  },
                ),
          actionIcon.icon == Icons.close
              ? Container()
              : IconButton(
                  icon: Icon(Icons.card_travel),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/CartScreen');
                  },
                ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
//          padding: EdgeInsets.zero,
          children: <Widget>[
//            DrawerHeader(
//                child:),
            Container(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(55),
                            border: Border.all(color: Colors.grey[300]),
                            color: appPrimaryMaterialColor),
                        child: Center(
                          child: Text(
                            "M",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "MahaLaxmi Textile",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/ProfileScreen');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 20),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Edit Profile",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Icon(
                                Icons.edit,
                                color: Colors.grey,
                                size: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/Home');
              },
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  color: appPrimaryMaterialColor,
                ),
                title: Text(
                  "Home",
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/WalkThroughScreen');
              },
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  color: appPrimaryMaterialColor,
                ),
                title: Text(
                  "WalkThrough",
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/OrderHistoryScreen');
              },
              child: ListTile(
                leading: Icon(
                  Icons.history,
                  color: appPrimaryMaterialColor,
                ),
                title: Text(
                  "Order History",
                ),
              ),
            ),
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
                leading: Icon(
                  Icons.add_location,
                  color: appPrimaryMaterialColor,
                ),
                title: Text(
                  "Add Addresses",
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
                            new LanguageChangeScreen()));
              },
              child: ListTile(
                leading: Icon(
                  Icons.language,
                  color: appPrimaryMaterialColor,
                ),
                title: Text(
                  "Change Language",
                ),
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (BuildContext context) => new FAQScreen(
//                            //  termsConData: termsConList[0],
//                            )));
              },
              child: ListTile(
                leading: Icon(
                  Icons.question_answer,
                  color: appPrimaryMaterialColor,
                ),
                title: Text(
                  "FAQ",
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
                leading: Icon(
                  Icons.share,
                  color: appPrimaryMaterialColor,
                ),
                title: Text(
                  "Share",
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                //  Navigator.of(context).pushNamed('/ContactUs');

//                Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (BuildContext context) => new ContactUs(
//                      contactData: contactList[0],
//                    ),
//                  ),
//                );
              },
              child: ListTile(
                leading: Icon(
                  Icons.contact_phone,
                  color: appPrimaryMaterialColor,
                ),
                title: Text(
                  "Contact Us",
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
                              termsConData: termsConList[0],
                            )));
              },
              child: ListTile(
                leading: Icon(
                  Icons.filter_none,
                  color: appPrimaryMaterialColor,
                ),
                title: Text(
                  "Terms & Conditions",
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                _showDialog(context);
              },
              child: ListTile(
                leading: Icon(
                  Icons.power_settings_new,
                  color: appPrimaryMaterialColor,
                ),
                title: Text(
                  "Logout",
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
                    Container(
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width,
                      child: Carousel(
                        boxFit: BoxFit.cover,
                        autoplay: true,
                        animationCurve: Curves.fastOutSlowIn,
                        animationDuration: Duration(milliseconds: 1000),
                        dotSize: 4.0,
                        dotColor: Colors.grey,
                        dotIncreasedColor: appPrimaryMaterialColor,
                        dotBgColor: Colors.white,
                        dotPosition: DotPosition.bottomCenter,
                        dotVerticalPadding: 0.0,
                        showIndicator: true,
                        indicatorBgPadding: 7.0,
                        images: imgList
                            .map((item) => Image.network(
                                  Image_URL + item["BannerImage"],
                                  fit: BoxFit.fill,
                                  height: 150,
                                  loadingBuilder:
                                      (context, widget, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return widget;
                                    } else
                                      return LoadingComponent();
                                  },
                                ))
                            .toList(),
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
                        "Categories",
                        style: TextStyle(
                            fontSize: 14,
                            // color: Colors.black54,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold),
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
                        "Trending Products",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold),
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
          isLoading = true;
        });
        var body = {};
        Services.PostForList(api_name: 'get_all_data_api/?tblName=tblbanner')
            .then((bannerresponselist) async {
          if (bannerresponselist.length > 0) {
            setState(() {
              isLoading = false;
              imgList = bannerresponselist;
              //set "data" here to your variable
            });
          } else {
            setState(() {
              isLoading = false;
            });
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

  _contactUs() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isTermLoading = true;
        Services.PostForList(api_name: 'get_all_data_api/?tblName=tblsetting')
            .then((responseList) async {
          if (responseList.length > 0) {
            setState(() {
              isTermLoading = false;
              contactList = responseList;
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

  _termsCon() async {
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
        "Logout",
        style: TextStyle(
            fontSize: 22,
            color: appPrimaryMaterialColor,
            fontWeight: FontWeight.bold),
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
