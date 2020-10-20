import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Providers/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  var notiData;
  NotificationScreen({this.notiData});
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
            GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/HomePage', (route) => false);
              },
              child: Container(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    "assets/home.png",
                    color: appPrimaryMaterialColor,
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/CartScreen');
              },
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 15.0, left: 10, top: 18),
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
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: Colors.grey),
          title: Text(
            'Notification'.tr().toString(),
            //"Edit Profile",
            style: TextStyle(color: appPrimaryMaterialColor, fontSize: 17),
          ),
        ),
        body: widget.notiData.length > 0
            ? ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: widget.notiData.length,
                //itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Container(
                              height: 120,
                              width: 95,
                              child: Image.network(
                                  Image_URL +
                                      "${widget.notiData[index]["NotificationhistoryImage"]}",
                                  fit: BoxFit.fill)),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.notiData[index]["NotificationhistoryTitle"]}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8.0, right: 4),
                                  child: Text(
                                    "${widget.notiData[index]["NotificationhistoryDesc"]}",
                                    //overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
              )
            : Center(
                child: Text(
                'Notification_Data_Not_Found'.tr().toString(),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600),
              )));
  }
}
