import 'package:balaji/Common/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartComponent extends StatefulWidget {
  var getCartData;
  CartComponent({this.getCartData});
  @override
  _CartComponentState createState() => _CartComponentState();
}

class _CartComponentState extends State<CartComponent> {
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
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 10,
        ),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 110,
                  width: 80,
                  child: Image.network(
                    Image_URL + "${widget.getCartData["ProductImages"]}",
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${widget.getCartData["ProductName"]}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            "2018 (L) (HOME)",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          "NIKE",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Qty",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.remove_circle,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  minus();
                                });
                              },
                              color: appPrimaryMaterialColor,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5),
                              child: Text('$_m'),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.add_circle,
                                size: 20,
                              ),
                              onPressed: () {
                                add();
                              },
                              color: appPrimaryMaterialColor,
                            ),
                            Flexible(
                              child: Text(
                                "₹ 15,00000",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: appPrimaryMaterialColor,
                      size: 20,
                    ),
                    onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
