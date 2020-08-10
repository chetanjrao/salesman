import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:salesman/features/inventory/bloc/payment_bloc.dart';
import 'package:salesman/features/inventory/bloc/payment_event.dart';
import 'package:salesman/features/inventory/bloc/payment_state.dart';
import 'package:salesman/utils/globals.dart';

class PaymentsMethod extends StatefulWidget {
  @override
  _PaymentsMethodState createState() => _PaymentsMethodState();
}

class _PaymentsMethodState extends State<PaymentsMethod> {
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
                          "Payment Methods",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      )
                    ],
                  ),
      ),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state){
          if(state is PaymentSuccessState){
            return Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  child: Container(
              padding: EdgeInsets.all(24.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.payments.length,
              itemBuilder: (context, index){
                
                return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0)
                ),
                child: ListTile(
                
                leading: CircularCheckBox(
                  value: state.selectedPayment.id == state.payments[index].id,
                  tristate: true,
                  activeColor: Theme.of(context).primaryColor, 
                  disabledColor: Colors.grey, 
                  onChanged: (val) => this.setState(() {}) 
                ),
                trailing: Container(
                    child: Image.network(
                    "$API_URL${state.payments[index].image}",
                    fit: BoxFit.contain,
                    height: 36.0,
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                subtitle: Container(
                  margin: EdgeInsets.only(top: 6.0),
                  child: state.payments[index].isBank ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 0),
                        child: Text(
                          "${state.payments[index].accountId}",
                    style: TextStyle(
                      fontSize: 13.0
                    ),
                        )
                      ),
                    ],
                  ) : Text(
                    "${state.payments[index].accountId}",
                    style: TextStyle(
                      fontSize: 13.0
                    ),
                  ),
                ),
                title: Container(
                  child: Text(
                    "${state.payments[index].name}",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0
                    ),
                  )
                ),
                onTap: ()=> this.setState(() { 
                    context.bloc<PaymentBloc>().add(SelectPaymentEvent(state.payments[index]));
                  }),
              ),
              );
              }
            )
            )
                ),
                Container(
                  margin: EdgeInsets.all(24.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      "Select Payment Method",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                  )
                )
              ]
            );
          } 
          return Container();
        },
      )
    )
    );
  }
}