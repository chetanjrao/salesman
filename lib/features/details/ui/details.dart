import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> with SingleTickerProviderStateMixin {

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, isoverlap){
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: Icon(
                  Feather.chevron_left,
                  color: Theme.of(context).primaryColor
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              titleSpacing: 0,
              backgroundColor: Colors.white,
              title: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Details",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                      ),
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
                          padding: EdgeInsets.all(10.0),
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
                              Feather.download_cloud,
                              color: Theme.of(context).primaryColor,
                              size: 20.0
                            )
                          )
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.only(left: 12.0),
                          width: 48.0,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.5),
                              width: 0.5
                            )
                          ),
                          child: Center(
                            child: Icon(
                              Feather.plus,
                              color: Colors.white,
                              size: 20.0
                            )
                          )
                        ),
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
                        child: Text(
                          "20",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Theme.of(context).primaryColor
                          ),
                        )
                      )
                    ),
                    title: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            index % 2 == 0 ? "Rice" : "Cereals",
                            style: TextStyle(
                              fontSize: 15.0
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6.0),
                          child: Text(
                            "Base Price: \u20B940",
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
                        index % 2 == 0 ? "\u20b91,232.4": "\u20b9965.0",
                        style: TextStyle(
                          color: Color(0XFF131B26),
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0
                        )
                      )
                    ),
                  )
                );
              },
            )
          ],
        )
      )
    )
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
              text: "Product List",
            )
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
