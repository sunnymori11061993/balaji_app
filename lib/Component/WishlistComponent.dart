import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Screens/ProductDetailScreen.dart';
import 'package:flutter/material.dart';

class WishlistComponent extends StatefulWidget {
  var wishListData;
  WishlistComponent({this.wishListData});
  @override
  _WishlistComponentState createState() => _WishlistComponentState();
}

class _WishlistComponentState extends State<WishlistComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => new ProductDetailScreen(
                      productDetail: widget.wishListData,
                    )));
      },
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Container(
                height: 125,
                width: 95,
                child: Image.network(
                    Image_URL + "${widget.wishListData["ProductImages"]}",
                    fit: BoxFit.fill)),
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
                          Navigator.of(context).pop();
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
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      "${widget.wishListData["ProductName"]}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Price :",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "₹",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${widget.wishListData["ProductSrp"]}",
                          style: TextStyle(
                              // color: Colors.grey[600],
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            "₹" + "${widget.wishListData["ProductMrp"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, right: 3, bottom: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/CartScreen');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: appPrimaryMaterialColor,
                              border: Border.all(
                                color: Colors.grey[100],
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            width: 150,
                            height: 35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3.0),
                                  child: Text(
                                    "Add to Cart",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
