import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:salesman/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:salesman/features/dashboard/bloc/dashboard_events.dart';
import 'package:salesman/features/dashboard/bloc/dashboard_state.dart';
import 'package:salesman/features/dashboard/data/models/dashboard_models.dart';
import 'package:salesman/features/inventory/ui/inventory.dart';
import 'package:salesman/utils/globals.dart';
import 'package:shimmer/shimmer.dart';

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
              child: BlocBuilder<DashboardBloc, DashboardState>(
                builder: (blocContext, state){
                  if(state is DashboardInitial){
                    context.bloc<DashboardBloc>().add(FetchDashboardStatistics(
                      distributor: 1
                    ));
                    context.bloc<DashboardBloc>().add(FetchRecentTransactions(
                      distributor: 1
                    ));
                  }
                  if(state is DashboardSuccess){

                return Column(
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
                            text: "${state.statistics.total.toStringAsFixed(2)}",
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
                            state.statistics.status < 0 ? "${state.statistics.status.toStringAsFixed(2)} %" : "+ ${state.statistics.status.toStringAsFixed(2)} %",
                            style: TextStyle(
                              color: state.statistics.status < 0 ? Colors.red : Color(0XFF0EA581)
                            ),
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 4.0, top: 1.0),
                          child: Icon(
                            state.statistics.status < 0 ? Feather.trending_down : Feather.trending_up,
                            color: state.statistics.status < 0 ? Colors.red : Color(0XFF0EA581),
                            size: 16.0,
                          )
                        )
                      ],
                    )
                  )
                ],
              );
                  } else {
                    return Container();
                  }
                },
              )
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
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state){
            if(state is DashboardSuccess){
              List<RecentTransactions> allTransactions = state.transactions;
              List<RecentTransactions> creditTransactions = state.transactions.where((element) => element.isCredit).toList();
              List<RecentTransactions> debitTransactions = state.transactions.where((element) => !element.isCredit).toList();
            return TabBarView(
              controller: tabController,
              children: <Widget>[
                ListView.builder(
                  itemCount: allTransactions.length,
                  itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: ListTile(
                        leading:Container(
                              width: 48.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "$API_URL${allTransactions[index].image}"
                                  ),
                                  
                                ),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 0.5
                                )
                              ) 
                        ),
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                allTransactions[index].isCredit ? "Credit" : "Debit",
                                style: TextStyle(
                                  fontSize: 15.0
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 6.0),
                              child: Text(
                                "${DateFormat.jm().format(DateTime.parse(state.transactions[index].createdAt).toLocal())} ${DateFormat.yMMMMd('en_US').format(DateTime.parse(state.transactions[index].createdAt).toLocal())} ",
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
                            allTransactions[index].isCredit ? "+\u20b9${state.transactions[index].amount}": "\u20b9${state.transactions[index].amount}",
                            style: TextStyle(
                              color: allTransactions[index].isCredit ? Color(0XFF0EA581) : Color(0XFF131B26),
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0
                            )
                          )
                        ),
                      )
                    );
                  },
                ),
                ListView.builder(
                  itemCount: creditTransactions.length,
                  itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: ListTile(
                        leading: Container(
                              width: 48.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "$API_URL${allTransactions[index].image}"
                                  ),
                                  
                                ),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 0.5
                                )
                              ) 
                        ),
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                creditTransactions[index].isCredit ? "Credit" : "Debit",
                                style: TextStyle(
                                  fontSize: 15.0
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 6.0),
                              child: Text(
                                "${DateFormat.jm().format(DateTime.parse(creditTransactions[index].createdAt).toLocal())} ${DateFormat.yMMMMd('en_US').format(DateTime.parse(creditTransactions[index].createdAt).toLocal())} ",
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
                            creditTransactions[index].isCredit ? "+\u20b9${creditTransactions[index].amount}": "\u20b9${creditTransactions[index].amount}",
                            style: TextStyle(
                              color: creditTransactions[index].isCredit ? Color(0XFF0EA581) : Color(0XFF131B26),
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0
                            )
                          )
                        ),
                      )
                    );
                  },
                ),
                ListView.builder(
                  itemCount: debitTransactions.length,
                  itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: ListTile(
                        leading: Container(
                              width: 48.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "$API_URL${allTransactions[index].image}"
                                  ),
                                  
                                ),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 0.5
                                )
                              ) 
                        ),
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                debitTransactions[index].isCredit ? "Credit" : "Debit",
                                style: TextStyle(
                                  fontSize: 15.0
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 6.0),
                              child: Text(
                                "${DateFormat.jm().format(DateTime.parse(debitTransactions[index].createdAt).toLocal())} ${DateFormat.yMMMMd('en_US').format(DateTime.parse(debitTransactions[index].createdAt).toLocal())} ",
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
                            debitTransactions[index].isCredit ? "+\u20b9${state.transactions[index].amount}": "\u20b9${state.transactions[index].amount}",
                            style: TextStyle(
                              color: debitTransactions[index].isCredit ? Color(0XFF0EA581) : Color(0XFF131B26),
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
            );
          } else {
            return Center(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: ListTile(
                        leading: Shimmer.fromColors(
                              baseColor: Colors.grey[200],
                              highlightColor: Colors.grey[100],
                              child: Container(
                              width: 48.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 0.5
                                )
                              )
                            ),
                        ),
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[200],
                                highlightColor: Colors.grey[100],
                                child: Container(
                                  width: double.infinity,
                                  height: 16.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Colors.white
                                    ),
                                )
                              )
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 12.0),
                              child: Container(
                              child: Shimmer.fromColors(
                                  baseColor: Colors.grey[200],
                                  highlightColor: Colors.grey[100],
                                  child: Container(
                                    width: double.infinity,
                                    height: 13.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Colors.white
                                    ),
                                  )
                                )
                              ),
                            )
                          ],
                        ),
                        trailing: Container(
                          child: Shimmer.fromColors(
                              baseColor: Colors.grey[200],
                              highlightColor: Colors.grey[100],
                              child: Container(
                                height: 24,
                                width: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white
                                    ),
                              )
                            )
                        ),
                      )
                    );
                  },
                )
            );
          }
          }
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
