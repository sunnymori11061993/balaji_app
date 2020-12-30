import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Screens/ProductDetailScreen.dart';
import 'package:flutter/material.dart';

class SetFilterComponent extends StatefulWidget {
  var setfilter;
  SetFilterComponent({this.setfilter});
  @override
  _SetFilterComponentState createState() => _SetFilterComponentState();
}

class _SetFilterComponentState extends State<SetFilterComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailScreen(
                    productDetail: widget.setfilter["ProductId"],
                    // productId: widget.setfilter["ProductId"],
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      '${widget.setfilter["ProductImages"]}',
                      width: 110,
                      height: 110,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.setfilter["ProductName"]}",
                              style: TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(
                                "${widget.setfilter["ProductBrandName"]}",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: RichText(
                                text: TextSpan(
                                    text: 'MRP : ',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            "${Inr_Rupee + widget.setfilter["ProductMrp"]}",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      )
                                    ]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${Inr_Rupee}" +
                                          "${widget.setfilter["ProductSrp"]}",
                                      // " ${Inr_Rupee + widget.product["ProductSrp"]}",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black)),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: SizedBox(
                                      height: 35,
                                      width: 75,
                                      child: FlatButton(
                                        onPressed: () {
                                          //  _addToCart();
                                        },
                                        color: Colors.redAccent,
                                        child:
                                            /* iscartLoading
                                            ? LoadingComponent()
                                            : iscartlist == true
                                                ? */
                                            // Text('Added',
                                            //             style: TextStyle(
                                            //                 color: Colors.white,
                                            //                 fontSize: 14))
                                            //         :
                                            Text('Add',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14)),
                                      ),
                                    ),
                                  ),
                                ],
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
          ],
        ),
      ),
    );
  }
}
