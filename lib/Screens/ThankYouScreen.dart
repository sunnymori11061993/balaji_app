import 'package:balaji/Common/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThankYouScreen extends StatefulWidget {
  @override
  _ThankYouScreenState createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 5, bottom: 8),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/HomePage");
              },
              child: Image.asset(
                "assets/backarrow.png",
                //color: appPrimaryMaterialColor,
              )),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(
          color: appPrimaryMaterialColor,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 10),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top + 80,
                ),
                Center(
                  child: Text(
                    "Thank you for choosing",
                    style: TextStyle(
                      fontSize: 18,
                      //color: Colors.white,
                      color: Colors.black,
                      //fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                Text(
                  "BALAJI WHOLESALE BAZAAR",
                  style: TextStyle(
                      fontSize: 18,
                      //color: Colors.white,
                      color: appPrimaryMaterialColor,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: appPrimaryMaterialColor),
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Center(
                  child: Text(
                    "Order Placed Successfully",
                    style: TextStyle(
                      fontSize: 20,
                      //color: Colors.white,
                      color: Colors.black,
                      //fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "we will deliver your order soon",
                    style: TextStyle(
                      fontSize: 15,
                      //color: Colors.white,
                      color: Colors.black,
                      //fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Center(
                  child: Text(
                    "In case of any query related to your order please",
                    style: TextStyle(
                      fontSize: 15,
                      //color: Colors.white,
                      color: Colors.grey[700],
                      //fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "feel free to Contact Us...",
                    style: TextStyle(
                      fontSize: 15,
                      //color: Colors.white,
                      color: Colors.grey[700],
                      //fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.top + 30,
                ),
                SizedBox(
                  height: 45,
                  width: 150,
                  child: FlatButton(
                    color: appPrimaryMaterialColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: Colors.grey[300])),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/HomePage");
                    },
                    child: Text(
                      "Got it...",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
