import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesman/features/details/bloc/details_bloc.dart';
import 'package:salesman/features/details/bloc/details_event.dart';
import 'package:salesman/features/editinvoice/bloc/editinvoice_bloc.dart';
import 'package:salesman/features/editinvoice/bloc/editinvoice_event.dart';
import 'package:salesman/features/editinvoice/bloc/editinvoice_state.dart';
import 'package:salesman/features/editinvoice/data/models/edit_invoice_models.dart';
import 'package:salesman/features/inventory/bloc/inventory_bloc.dart';
import 'package:salesman/features/inventory/bloc/inventory_event.dart';
import 'package:salesman/features/inventory/bloc/inventory_state.dart';
import 'package:salesman/features/inventory/bloc/payment_bloc.dart';
import 'package:salesman/features/inventory/bloc/payment_state.dart';
import 'package:salesman/features/inventory/bloc/retailer_bloc.dart';
import 'package:salesman/features/inventory/bloc/retailer_state.dart';

class InventorySuccessPage extends StatefulWidget {

  final double amount;
  final String deadline;

  const InventorySuccessPage({Key key, this.amount, this.deadline}) : super(key: key);

  @override
  _InventorySuccessPageState createState() => _InventorySuccessPageState();
}

class _InventorySuccessPageState extends State<InventorySuccessPage> {      

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: BlocBuilder<InventoryBloc, InventoryState>(
          builder: (context, state){
            if(state is InventorySuccessState){
              int retailer;
              int distributor = 1;
              int payment;
              List<Map<String, int>> finalState = [];
              state.localInventory.values.forEach((element) {
                finalState.add(
                  {
                    "product": element.id,
                    "quantity": element.quantity,
                    "discount": 0,
                    "box": 0
                  }
                );
              });
              PaymentState paymentState = context.bloc<PaymentBloc>().state;
              if(paymentState is PaymentSuccessState){
                payment = paymentState.selectedPayment.id;
              }
              RetailerState retailerState = context.bloc<RetailerBloc>().state;
              if(retailerState is RetailerSuccessState){
                retailer = retailerState.selectedRetailer.id;
              }
              context.bloc<InventoryBloc>().add(InventoryUploadEvent(
                finalState,
                payment,
                widget.amount,
                retailer,
                distributor,
                widget.deadline
              ));
            }
            if(state is NewInventoryUploadSucessState){
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 150.0,
                    width: 150.0,
                    child: FlareActor(
                      "assets/success.flr",
                      animation:"Untitled"
                    )
                  ),
                  Container(
                    child: Text(
                      "${state.message}",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500
                      ),
                    )
                  )
                ],
              );
            } else if(state is EditInvoiceInitialState){
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 150.0,
                    width: 150.0,
                    child: FlareActor(
                      "assets/success.flr",
                      animation:"Untitled"
                    )
                  ),
                  Container(
                    child: Text(
                      "Invoice updated successfully",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500
                      ),
                    )
                  )
                ],
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 36.0,
                    width: 36.0,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.transparent,
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24.0),
                    child: Text(
                      "Processing your request",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500
                      ),
                    )
                  )
                ],
              );
            }
          }
        ),
      )
    );
  }
}