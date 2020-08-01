import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:salesman/features/details/bloc/details_bloc.dart';
import 'package:salesman/features/details/bloc/details_event.dart';
import 'package:salesman/features/details/bloc/details_state.dart';
import 'package:salesman/features/editinvoice/ui/edit_invoice.dart';
import 'package:salesman/utils/globals.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {

  final String invoiceID;

  const Details({Key key, @required this.invoiceID}) : super(key: key);

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
  
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, 
      enableDomStorage: true,
      forceSafariVC: true,
      enableJavaScript: true,
      forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
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
                      "Invoice Details",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  )
                ],
              ),
            ),
           BlocBuilder<InvoiceDetailsBloc, InvoiceInfoState>(
             builder: (context, state){
              if(state is InvoiceInfoSuccessState){
               return SliverToBoxAdapter(
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
                            text: "${state.invoiceInfo.invoiceInfo.total.toStringAsFixed(2)}",
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
                        GestureDetector(
                          onTap: (){
                            launchURL("$API_URL/salesman/sales/invoice/${state.invoiceInfo.invoiceInfo.uid}");
                          },
                          child: Container(
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
                        ),
                        GestureDetector(
                          child: Container(
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
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditInvoice() ));
                          },
                        ),
                      ],
                    )
                  )
                ],
              ),
            );
              } else {
                return SliverToBoxAdapter(
                  child: Container()
                );
              }
             },
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
            BlocBuilder<InvoiceDetailsBloc, InvoiceInfoState>(
              builder: (context, state){
                if(state is InvoiceInfoInitialState){
                  context.bloc<InvoiceDetailsBloc>().add(LoadInvoiceInfo(invoiceID: widget.invoiceID));
                }
                if(state is InvoiceInfoSuccessState){
                  return ListView.builder(
              itemCount: state.invoiceInfo.invoiceSales.length,
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
                          "${state.invoiceInfo.invoiceSales[index].quantity}",
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
                            "${state.invoiceInfo.invoiceSales[index].name}",
                            style: TextStyle(
                              fontSize: 15.0
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6.0),
                          child: Text(
                            "Base Price: \u20b9${state.invoiceInfo.invoiceSales[index].price.toStringAsFixed(2)}",
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
                        "\u20b9${state.invoiceInfo.invoiceSales[index].amount.toStringAsFixed(2)}",
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
            );
                } else {
                  return ListView.builder(
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
                );
                }
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
