import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Screens/ProductDetailScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubCategoriesComponent extends StatefulWidget {
  var subCat;

  SubCategoriesComponent({this.subCat});

  @override
  _SubCategoriesComponentState createState() => _SubCategoriesComponentState();
}

class _SubCategoriesComponentState extends State<SubCategoriesComponent> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 6, right: 6),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => new ProductDetailScreen(
                        productDetail: widget.subCat["ProductId"],
                      )));
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 237,
                  child: Image.network(
                      Image_URL + "${widget.subCat["ProductImages"]}",
                      fit: BoxFit.fill)),
              Padding(
                padding: const EdgeInsets.only(
                  left: 4.0,
                  top: 2.0,
                ),
                child: Text("${widget.subCat["ProductName"]}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 4.0,
                  top: 6.0,
                ),
                child: Text("${widget.subCat["ProductDescription"]}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    //  fontWeight: FontWeight.w500,
                    )),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 1),
                  child: Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "₹",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "${widget.subCat["ProductSrp"]}",
                            style: TextStyle(
                                // color: Colors.grey[600],
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "₹" + "${widget.subCat["ProductMrp"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough),
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
    );
  }


}
