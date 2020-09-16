import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Component/ActiveOrderComponent.dart';
import 'package:balaji/Component/CompletedOrderComponent.dart';
import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );

    _tabController.addListener(() {
      print(_tabController.index);
    });
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
              Navigator.of(context).pop();
            }),
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(
          color: appPrimaryMaterialColor,
        ),
        title: const Text("OrderHistory",
            style: TextStyle(
              color: Colors.black,
            )),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: TabBar(
                      //isScrollable: true,//do only when there is more tab
                      controller: _tabController,
                      unselectedLabelColor: Colors.grey,
                      labelColor: appPrimaryMaterialColor,
                      indicatorColor: appPrimaryMaterialColor,
                      //labelPadding: EdgeInsets.symmetric(horizontal: 30),
                      tabs: [
                        Tab(
                          child: Text(
                            "Active Order",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Completed Order",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: TabBarView(
                    //contents
                    controller: _tabController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListView.separated(
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return ActiveOrderComponent();
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(
                            thickness: 2,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListView.separated(
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return CompletedOrderComponent();
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(
                            thickness: 2,
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
      ),
    );
  }
}
