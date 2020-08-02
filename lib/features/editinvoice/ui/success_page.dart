import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesman/features/editinvoice/bloc/editinvoice_bloc.dart';
import 'package:salesman/features/editinvoice/bloc/editinvoice_event.dart';
import 'package:salesman/features/editinvoice/bloc/editinvoice_state.dart';
import 'package:salesman/features/editinvoice/data/models/edit_invoice_models.dart';

class SuccessPage extends StatefulWidget {

  final EditInvoiceModel model;

  const SuccessPage({Key key,@required this.model}) : super(key: key);

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: BlocBuilder<EditInvoiceBloc, EditInvoiceState>(
          builder: (context, state){
            if(state is EditInvoiceInitialState){
                context.bloc<EditInvoiceBloc>().add(UploadEditInvoice(model: widget.model));
            }
            print(state);
            if(state is EditInvoiceUploadSuccessState){
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
                      "Invoice created successfully",
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
                    height: 80.0,
                    width: 80.0,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.transparent,
                    )
                  ),
                  Container(
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
        )
      )
    );
  }
}