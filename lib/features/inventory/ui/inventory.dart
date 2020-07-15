import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Inventory extends StatefulWidget {
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Feather.chevron_left,
              color: Theme.of(context).primaryColor
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          titleSpacing: 0,
          title: Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: <Widget>[
              Container(
                child: Text(
                  "Add Inventory",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                  ),
                ),
              )
            ],
          ),
          bottom: TabBar(
            isScrollable: true,
            controller: _tabController,
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            indicatorWeight: 1.0,
            unselectedLabelColor: Color(0XFF404864),
            labelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: 'Euclid Circular B'
            ),
            tabs: <Widget>[
              Tab(
                text: "Cat A"
              ),
              Tab(
                text: "Cat B"
              ),
              Tab(
                text: "Cat C"
              )
            ],
          ),
        ),
        body: Container(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Container(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: ListTile(
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                index % 2 == 0 ? "Credit" : "Debit",
                                style: TextStyle(
                                  fontSize: 15.0
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 6.0),
                              child: Text(
                                "Base Price: \u20b946.99",
                                style: TextStyle(
                                  color: Color(0XFF404864),
                                  fontSize: 13.0
                                ),
                              ),
                            )
                          ],
                        ),
                        trailing: Container(
                          child: Flex(
                            direction: Axis.horizontal,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 12.0),
                                child: Center(
                                  child: Icon(
                                    Feather.minus_square,
                                    color: Color(0XFF404864),
                                    size: 28.0,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "0",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500
                                  ),
                                )
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 12.0, right: 4.0),
                                child: Icon(
                                  Feather.plus_square,
                                  color: Theme.of(context).primaryColor,
                                  size: 28.0,
                                )
                              )
                            ]
                          )
                        ),
                      )
                    );
                  },
                ),
              ),
              Container(
                child: Text("2")
              ),
              Container(
                child: Text("3")
              )
            ],
          ),
        ),
      )
    );
  }
}