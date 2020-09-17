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
  int _m =1;
  int res = 0;
  // Text("${widget.getCartData["CartQuantity"]}");



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
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Container(

              width: 95,
              child: Image.network(
                  Image_URL + "${widget.getCartData["ProductImages"]}",
                  fit: BoxFit.fill)),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 7.0, left: 15, right: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "${widget.getCartData["ProductName"]}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      onTap: () {
                        //Navigator.of(context).pop();
                      },
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: appPrimaryMaterialColor,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0,right: 4),
                  child: Text(
                    "${widget.getCartData["ProductDescription"]}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(
                      top: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                          "₹" +"${widget.getCartData["ProductSrp"]}"
                          ,
                          style: TextStyle(
                              color:
                              Colors.black,
                              fontSize: 16)),
                      Padding(
                        padding:
                        const EdgeInsets
                            .only(
                            left: 4.0),
                        child: Text(
                            "₹" +"${widget.getCartData["ProductMrp"]}",

                            //  "${widget.productDetail["ProductMrp"]}",
                            style: TextStyle(
                                color:
                                Colors.grey,
                                fontSize: 16,
                                decoration:
                                TextDecoration
                                    .lineThrough)),
                      ),
                    ],
                  ),
                ),
                Row(

                  children: <Widget>[
                    Text(
                      "Quantity :",
                      style: TextStyle(
                          fontSize: 16,
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
                            child: Text("${widget.getCartData["CartQuantity"]}"),
                            //child: Text('$_m'),
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

                  ],
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(right: 3, bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 150,
                        height: 40,
                        // color: appPrimaryMaterialColor,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // border: Border.all(color: Colors.grey[300]),
                            color: appPrimaryMaterialColor),
                        child:  Center(

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Total :",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "₹",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              Flexible(
                                child: Text(
                                  "15,0000000",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
//                Padding(
//                  padding:
//                  const EdgeInsets.only(right: 3, bottom: 2),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.end,
//                    children: <Widget>[
////                      Container(
////                        width: 150,
////                        height: 40,
////                        // color: appPrimaryMaterialColor,
////                        decoration: BoxDecoration(
////                            borderRadius: BorderRadius.circular(5),
////                            // border: Border.all(color: Colors.grey[300]),
////                            color: appPrimaryMaterialColor),
////                        child:  Center(
////                          child: Text(
////                            "Total :",
////                            style: TextStyle(
////                                fontSize: 16,
////                                color: Colors.white,
////                                fontWeight: FontWeight.w600),
////                          ),
////                        ),
////                      ),
//                      Text(
//                        "Total :",
//                        style: TextStyle(
//                            fontSize: 16,
//                            color: Colors.black,
//                            fontWeight: FontWeight.w600),
//                      ),
//                      Text(
//                        "₹",
//                        style: TextStyle(
//                            color: Colors.grey,
//                            fontSize: 16,
//                            fontWeight: FontWeight.w600),
//                      ),
//                  Flexible(
//                              child: Text(
//                                "15,00000",
//                                style: TextStyle(
//                                    fontSize: 16,
//                                    color: Colors.black,
//                                    fontWeight: FontWeight.w600),
//                              ),
//                            ),
//                    ],
//                  ),
//                ),

              ],
            ),
          ),
        ),
      ],
    );



//      Container(
//      child: Padding(
//        padding: const EdgeInsets.only(
//          top: 10.0,
//          left: 10,
//        ),
//        child: Column(
//          children: <Widget>[
//            Row(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Container(
//                  height: 110,
//                  width: 80,
//                  child: Image.network(
//                    Image_URL + "${widget.getCartData["ProductImages"]}",
//                    fit: BoxFit.cover,
//                  ),
//                ),
//                Expanded(
//                  child: Padding(
//                    padding: const EdgeInsets.only(top: 25.0, left: 10),
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        Text(
//                          "${widget.getCartData["ProductName"]}",
//                          overflow: TextOverflow.ellipsis,
//                          style: TextStyle(
//                              fontSize: 15,
//                              color: Colors.black,
//                              fontWeight: FontWeight.w600),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(top: 5.0),
//                          child: Text(
//                            "2018 (L) (HOME)",
//                            style: TextStyle(
//                                fontSize: 14,
//                                color: Colors.black,
//                                fontWeight: FontWeight.w600),
//                          ),
//                        ),
//                        Text(
//                          "NIKE",
//                          style: TextStyle(
//                              fontSize: 13,
//                              color: Colors.grey,
//                              fontWeight: FontWeight.w600),
//                        ),
//                        Row(
//                          children: <Widget>[
//                            Text(
//                              "Qty",
//                              style: TextStyle(
//                                  fontSize: 14,
//                                  color: Colors.black,
//                                  fontWeight: FontWeight.w600),
//                            ),
//                            IconButton(
//                              icon: Icon(
//                                Icons.remove_circle,
//                                size: 20,
//                              ),
//                              onPressed: () {
//                                setState(() {
//                                  minus();
//                                });
//                              },
//                              color: appPrimaryMaterialColor,
//                            ),
//                            Padding(
//                              padding:
//                                  const EdgeInsets.only(left: 5.0, right: 5),
//                              child: Text('$_m'),
//                            ),
//                            IconButton(
//                              icon: Icon(
//                                Icons.add_circle,
//                                size: 20,
//                              ),
//                              onPressed: () {
//                                add();
//                              },
//                              color: appPrimaryMaterialColor,
//                            ),
//                            Flexible(
//                              child: Text(
//                                "₹ 15,00000",
//                                style: TextStyle(
//                                    fontSize: 14,
//                                    color: Colors.black,
//                                    fontWeight: FontWeight.w600),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//                IconButton(
//                    icon: Icon(
//                      Icons.cancel,
//                      color: appPrimaryMaterialColor,
//                      size: 20,
//                    ),
//                    onPressed: () {}),
//              ],
//            ),
//          ],
//        ),
//      ),
//    );
  }
}
