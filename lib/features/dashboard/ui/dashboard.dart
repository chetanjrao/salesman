import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:salesman/features/inventory/ui/inventory.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, isoverlap){
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              title: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Dashboard",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  Container(
                    child: CircleAvatar(
                      maxRadius: 16.0,
                      minRadius: 16.0,
                      child: Text(
                        "A",
                        style: TextStyle(
                          fontFamily: 'Euclid Circular B',
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "\u20b9",
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.black,
                              fontFamily: 'Euclid Circular B',
                              fontWeight: FontWeight.w500
                            )
                          ),
                          TextSpan(
                            text: "9,923.32",
                            style: TextStyle(
                              fontSize: 32.0,
                              color: Colors.black,
                              fontFamily: 'Euclid Circular B',
                              fontWeight: FontWeight.w500
                            )
                          ),
                        ]
                      )
                    )
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16.0),
                    child: Wrap(
                      children: <Widget>[
                        Container(
                          child: Text(
                            "+ 1.23%",
                            style: TextStyle(
                              color: Color(0XFF0EA581)
                            ),
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 4.0, top: 1.0),
                          child: Icon(
                            Feather.trending_up,
                            color: Color(0XFF0EA581),
                            size: 16.0,
                          )
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverHeaderDelegate(
                tabController: tabController
              ),
              floating: true,
              pinned: true,
            )
          ];
        }, 
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index){
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: ListTile(
                    leading: Container(
                      width: 48.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 0.5
                        )
                      ),
                      child: Center(
                        child: Icon(
                          index % 2 == 0 ? Feather.plus : Feather.arrow_right,
                          color: Theme.of(context).primaryColor,
                        )
                      )
                    ),
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
                            "May 2, 9:24 PM",
                            style: TextStyle(
                              color: Color(0XFF404864),
                              fontSize: 13.0
                            ),
                          ),
                        )
                      ],
                    ),
                    trailing: Container(
                      child: Text(
                        index % 2 == 0 ? "+1,232.4": "965.0",
                        style: TextStyle(
                          color: index % 2 == 0 ? Color(0XFF0EA581) : Color(0XFF131B26),
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0
                        )
                      )
                    ),
                  )
                );
              },
            ),
            Text("Credits"),
            Text("Debits")
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Inventory())),
        backgroundColor: Theme.of(context).primaryColor,
        child: Center(
          child:Icon(
            Feather.shopping_cart,
            size: 20.0,
          )
        )
      ),
    );
  }
}

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
    final TabController tabController;

    const SliverHeaderDelegate({Key key, @required this.tabController}) : super();

    @override
    Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
      return Material(
        elevation: 0,
        color: Colors.white,
        child: TabBar(
          isScrollable: true,
          controller: tabController,
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
              text: "All",
            ),
            Tab(
              text: "Credits",
            ),
            Tab(
              text: "Debits",
            ),
          ],
        ),
      );
    }
  
    @override
    double get maxExtent => 40.0;
  
    @override
    double get minExtent => 40.0;

    @override
    bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
      return true;
    }
  
  
}
