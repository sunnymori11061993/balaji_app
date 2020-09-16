import 'package:balaji/Common/Constants.dart';
import 'package:flutter/material.dart';

class PlaceOrderComponent extends StatefulWidget {
  @override
  _PlaceOrderComponentState createState() => _PlaceOrderComponentState();
}

class _PlaceOrderComponentState extends State<PlaceOrderComponent> {
  int _m = 0;

  void add() {
    setState(() {
      _m++;
    });
  }

  void minus() {
    setState(() {
      if (_m != 0) _m--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Container(
                height: 100,
                width: 70,
                child: Image.network(
                  "https://images.indulgexpress.com/uploads/user/ckeditor_images/article/2019/12/3/DF0374_(2).jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 7.0, left: 15, right: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            // Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: appPrimaryMaterialColor,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Pink Chanderi Women's Saree",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Qty :",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "10",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Total : ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "₹ 15,000",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, right: 9.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 24,
                            height: 24,
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    minus();
                                  });
                                },
                                child: Icon(Icons.remove,
                                    size: 18, color: Colors.white)),
                            decoration: BoxDecoration(
                                color: appPrimaryMaterialColor,
                                borderRadius: BorderRadius.circular(40.0)),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15),
                            child: Container(
                              child: Text(
                                '$_m',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Container(
                            width: 24,
                            height: 24,
                            child: GestureDetector(
                                onTap: () {
                                  add();
                                },
                                child: Icon(Icons.add,
                                    size: 16, color: Colors.white)),
                            decoration: BoxDecoration(
                                color: appPrimaryMaterialColor,
                                borderRadius: BorderRadius.circular(40.0)),
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
      ],
    );
  }
}
