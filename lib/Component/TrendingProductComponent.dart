import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Screens/ProductDetailScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrendingProductComponent extends StatefulWidget {
  var trendData;

  TrendingProductComponent(this.trendData);

  @override
  _TrendingProductComponentState createState() =>
      _TrendingProductComponentState();
}

class _TrendingProductComponentState extends State<TrendingProductComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => new ProductDetailScreen(
                      productDetail: widget.trendData["ProductId"],
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 10),
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey[300]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                Image_URL + "${widget.trendData["ProductImages"]}",
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height / 4.1,
                // height: MediaQuery.of(context).size.height / 4.0,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 8),
                child: Text(
                  "${widget.trendData["ProductName"]}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                      // color: Colors.grey[600],
                      fontSize: 11),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                ),
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
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
                              "${widget.trendData["ProductSrp"]}",
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
                            "₹" + "${widget.trendData["ProductMrp"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: appPrimaryMaterialColor,
                      ),
                      onPressed: null,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
