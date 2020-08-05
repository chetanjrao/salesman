import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:salesman/features/transactions/bloc/transactions_bloc.dart';
import 'package:salesman/features/transactions/bloc/transactions_event.dart';
import 'package:salesman/features/transactions/bloc/transactions_state.dart';
import 'package:salesman/features/transactions/data/models/transactions.dart';
import 'package:salesman/utils/globals.dart';
import 'package:shimmer/shimmer.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> with SingleTickerProviderStateMixin {

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
                      "Transactions",
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
            SliverPersistentHeader(
              delegate: SliverHeaderDelegate(
                tabController: tabController
              ),
              floating: true,
              pinned: true,
            )
          ];
        }, 
        body: BlocBuilder<TransactionsBloc, TransactionsState>(
          builder: (context, state){
            if(state is TransactionsInitialState){
              BlocProvider.of<TransactionsBloc>(context).add(LoadAllTransactions(1));
            }
            if(state is TransactionsSuccessState){
              List<TransactionModel> allTransactions = state.transactions;
              List<TransactionModel> creditTransactions = state.transactions.where((element) => element.isCredit).toList();
              List<TransactionModel> debitTransactions = state.transactions.where((element) => !element.isCredit).toList();
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
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 0.5
                              )
                            ), 
                          child: Center(
                            child: Container(padding: EdgeInsets.all(6.0),
                              height: 48.0,
                             child: Image.network(
                               "$API_URL${allTransactions[index].image}"
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
                            allTransactions[index].isCredit ? "+\u20b9${state.transactions[index].amount.toStringAsFixed(2)}": "\u20b9${state.transactions[index].amount.toStringAsFixed(2)}",
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
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 0.5
                              )
                            ), 
                          child: Center(
                            child: Container(padding: EdgeInsets.all(6.0),
                              height: 48.0,
                             child: Image.network(
                               "$API_URL${allTransactions[index].image}"
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
                            creditTransactions[index].isCredit ? "+\u20b9${creditTransactions[index].amount.toStringAsFixed(2) }": "\u20b9${creditTransactions[index].amount.toStringAsFixed(2)}",
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
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 0.5
                              )
                            ), 
                          child: Center(
                            child: Container(padding: EdgeInsets.all(6.0),
                              height: 48.0,
                             child: Image.network(
                               "$API_URL${allTransactions[index].image}"
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
                            debitTransactions[index].isCredit ? "+\u20b9${state.transactions[index].amount.toStringAsFixed(2)}": "\u20b9${state.transactions[index].amount.toStringAsFixed(2)}",
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
