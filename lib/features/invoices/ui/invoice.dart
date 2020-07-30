import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:salesman/features/details/ui/details.dart';
import 'package:salesman/features/invoices/bloc/invoice_bloc.dart';
import 'package:salesman/features/invoices/bloc/invoice_events.dart';
import 'package:salesman/features/invoices/bloc/invoice_state.dart';
import 'package:shimmer/shimmer.dart';

class Invoice extends StatefulWidget {
  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Invoices",
            style: TextStyle(
              color: Colors.black
            )
          ),
          titleSpacing: 0,
          leading:  Icon(
            Feather.chevron_left,
            color: Theme.of(context).primaryColor
          ),
        ),
        body: Container(
          child: BlocBuilder<InvoiceBloc, InvoiceState>(
            builder: (context, state){
              print(state);
              if(state is InvoiceInitialState){
                  context.bloc<InvoiceBloc>().add(LoadInvoicesEvent());
              }
              if (state is InvoiceLoadedState){
                  return ListView.builder(
                    itemCount: state.invoices.length,
                    itemBuilder: (context, index){
                      return Container(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: ListTile(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Details()));
                            },
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
                                  Feather.file,
                                  color: Colors.red,
                                  size: 20.0,
                                )
                              )
                            ),
                            title: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "${state.invoices[index].retailer}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15.0
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 6.0),
                                  child: Text(
                                    "${DateFormat.jm().format(state.invoices[index].createdAt.toLocal())} ${DateFormat.yMMMM('en_US').format(state.invoices[index].createdAt.toLocal())}",
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
                                "\u20b9 ${state.invoices[index].amount.toStringAsPrecision(2)}",
                                style: TextStyle(
                                  color: Color(0XFF131B26),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0
                                )
                              )
                            ),
                          )
                        );
                    },
                  );
              }
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
            },
          )
        ),
      ),
    );
  }
}