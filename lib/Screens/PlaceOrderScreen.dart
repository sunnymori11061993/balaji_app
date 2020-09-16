import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Component/PlaceOrderComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaceOrderScreen extends StatefulWidget {
  @override
  _PlaceOrderScreenState createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  int step = 0;

  Widget _Step1(BuildContext context, int index) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 30.0, left: 15, right: 15, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Contact Details",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              "Name",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: TextField(
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 15),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                hintText: 'Enter your Name',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    width: 43,
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(width: 2, color: Colors.grey))),
                    child: Icon(
                      Icons.perm_identity,
                      color: appPrimaryMaterialColor,
                    ),
                  ),
                ),
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              "Company Name",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: TextField(
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 15),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                hintText: 'Enter Company Name',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    width: 43,
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(width: 2, color: Colors.grey))),
                    child: Icon(
                      Icons.card_travel,
                      color: appPrimaryMaterialColor,
                    ),
                  ),
                ),
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              "Email",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(fontSize: 15),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                hintText: 'Enter Company Email',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    width: 43,
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(width: 2, color: Colors.grey))),
                    child: Icon(
                      Icons.email,
                      color: appPrimaryMaterialColor,
                    ),
                  ),
                ),
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              "Mobile Number",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: TextField(
              keyboardType: TextInputType.phone,
              style: TextStyle(fontSize: 15),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                hintText: '+91 9429828152',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    width: 43,
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(width: 2, color: Colors.grey))),
                    child: Icon(
                      Icons.call,
                      color: appPrimaryMaterialColor,
                    ),
                  ),
                ),
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 10),
            child: Text(
              "Shipping Details",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "State",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey[300]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Gujarat",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "City",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey[300]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Surat",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              "Address",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 3),
            child: TextField(
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 15),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                hintText: '450-451 , ABC Textile Market ',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    width: 43,
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(width: 2, color: Colors.grey))),
                    child: Icon(
                      Icons.perm_identity,
                      color: appPrimaryMaterialColor,
                    ),
                  ),
                ),
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              "Description",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 3),
            child: TextField(
              style: TextStyle(fontSize: 15),
              cursorColor: Colors.black,
              maxLines: 3,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: "Add Description"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: RaisedButton(
                color: appPrimaryMaterialColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onPressed: () {
                  setState(() {
                    step = 1;
                  });
                },
                child: Text(
                  "NEXT",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _Step2(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 25),
          child: Row(
            children: <Widget>[
              Text(
                "Your Order",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 12,
            color: Colors.grey[300],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return PlaceOrderComponent();
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 9,
            color: Colors.grey[300],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10, bottom: 20),
                child: Text(
                  "Pricing Calculation",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Product Amount",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "₹ 15,000",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 15, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Tax Amount",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "₹ 15,00",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total Amount",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "₹ 16,500",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 68,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: RaisedButton(
                          color: appPrimaryMaterialColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  height: 30,
                                  width: 30,
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.white,
                                  )),
                              Text(
                                "ORDER ON WHATSAPP",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 68,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: RaisedButton(
                            color: appPrimaryMaterialColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .popAndPushNamed('/CartScreen');
                            },
                            child: Text(
                              "PLACE ORDER",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: appPrimaryMaterialColor,
              ),
              onPressed: () {
                Navigator.of(context).pop('/Home');
              }),
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: Colors.grey),
          title: const Text("Place Order",
              style: TextStyle(
                color: Colors.black,
              )),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  Navigator.of(context).pushNamed('/Whishlist');
                }),
            IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed('/CartScreen');
                }),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          step = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: appPrimaryMaterialColor,
                        ),
                        child: Center(
                            child: Text(
                          "1",
                          style: TextStyle(color: Colors.white),
                        )),
                        width: 25,
                        height: 25,
                      ),
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width / 2,
                      color: Colors.black,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          step = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: step == 0
                                ? Colors.grey
                                : appPrimaryMaterialColor),
                        child: Center(
                            child: Text(
                          "2",
                          style: TextStyle(color: Colors.white),
                        )),
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Shipping",
                      style: TextStyle(
                          color: appPrimaryMaterialColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Order Detail",
                      style: TextStyle(
                        color:
                            step == 0 ? Colors.grey : appPrimaryMaterialColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              step == 0 ? _Step1(context, 0) : _Step2(context, 1)
            ],
          ),
        ));
  }
}
