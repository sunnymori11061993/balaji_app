import 'package:balaji/Common/Constants.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  TextEditingController txtName = TextEditingController();
  TextEditingController txtCName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobileNumber = TextEditingController();
  final _formkey = new GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: appPrimaryMaterialColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.grey),
        title: const Text(
          "Add Address Screen",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
         key: _formkey,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 30.0, left: 15, right: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Address Details",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Text(
                    "Address 1",
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
                    maxLines: 2,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(5),
                      hintText: '450-451 , ABC Textile Market ',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          width: 43,
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(width: 2, color: Colors.grey))),
                          child: Icon(
                            Icons.location_on,
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

                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 15),
                                decoration:InputDecoration(
                                  contentPadding: const EdgeInsets.all(5),
                                  hintText: 'State ',

                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ) ,
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
                            child:  Container(
                              width: 150,
                              height: 40,

                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 15),
                                decoration:InputDecoration(
                                  contentPadding: const EdgeInsets.all(5),
                                  hintText: 'City ',

                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ) ,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
        const EdgeInsets.only(left: 13.0, right: 13, top: 70, bottom: 15),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45,
          child: RaisedButton(
            color: appPrimaryMaterialColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onPressed: () {

              // Navigator.of(context).pushNamed('/Home');
            },
            child: Text(
              "UPDATE PROFILE",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}
