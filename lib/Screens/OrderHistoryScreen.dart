import 'package:balaji/Common/Constants.dart';
import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with TickerProviderStateMixin {
//  TabController _tabController;
//
//  @override
//  void initState() {
//    super.initState();
//
//    _tabController = TabController(
//      vsync: this,
//      length: 2,
//      initialIndex: 0,
//    );
//
//    _tabController.addListener(() {
//      print(_tabController.index);
//    });
//  }

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
              Navigator.of(context).pop();
            }),
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(
          color: appPrimaryMaterialColor,
        ),
        title: const Text("View Details",
            style: TextStyle(
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.separated(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            height: 100,
                            width: 70,
                            child: Image.network(
                              "https://images.indulgexpress.com/uploads/user/ckeditor_images/article/2019/12/3/DF0374_(2).jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Pink Chanderi Women's Saree",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  "Date : 10-08-2000",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  "Qty : 10",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Total : ₹ 15,000",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            thickness: 2,
          ),
        ),
      ),
    );
  }
}
//Row(
//children: <Widget>[
//Expanded(
//child: Column(
//children: [
//Padding(
//padding: const EdgeInsets.only(top: 10.0),
//child: Container(
//height: 40,
//width: MediaQuery.of(context).size.width,
//child: TabBar(
////isScrollable: true,//do only when there is more tab
//controller: _tabController,
//unselectedLabelColor: Colors.grey,
//labelColor: appPrimaryMaterialColor,
//indicatorColor: appPrimaryMaterialColor,
////labelPadding: EdgeInsets.symmetric(horizontal: 30),
//tabs: [
//Tab(
//child: Text(
//"Active Order",
//style: TextStyle(fontWeight: FontWeight.bold),
//),
//),
//Tab(
//child: Text(
//"Completed Order",
//style: TextStyle(fontWeight: FontWeight.bold),
//),
//),
//],
//),
//),
//),
//Flexible(
//child: TabBarView(
////contents
//controller: _tabController,
//children: [
//Padding(
//padding: const EdgeInsets.only(top: 8.0),
//child: ListView.separated(
//itemCount: 3,
//itemBuilder: (BuildContext context, int index) {
//return ActiveOrderComponent();
//},
//separatorBuilder: (BuildContext context, int index) =>
//Divider(
//thickness: 2,
//),
//),
//),
//Padding(
//padding: const EdgeInsets.only(top: 8.0),
//child: ListView.separated(
//itemCount: 3,
//itemBuilder: (BuildContext context, int index) {
//return CompletedOrderComponent();
//},
//separatorBuilder: (BuildContext context, int index) =>
//Divider(
//thickness: 2,
//),
//),
//),
//],
//),
//),
//],
//),
//),
//],
//),
