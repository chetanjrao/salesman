import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:salesman/features/inventory/bloc/retailer_bloc.dart';
import 'package:salesman/features/inventory/bloc/retailer_event.dart';
import 'package:salesman/features/inventory/bloc/retailer_state.dart';
import 'package:salesman/utils/globals.dart';

class RetailerMethod extends StatefulWidget {
  @override
  _RetailerMethodState createState() => _RetailerMethodState();
}

class _RetailerMethodState extends State<RetailerMethod> {
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
                          "Retailers",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      )
                    ],
                  ),
      ),
      body: BlocBuilder<RetailerBloc, RetailerState>(
        builder: (context, state){
          if(state is RetailerSuccessState){
            return Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  child: Container(
              padding: EdgeInsets.all(24.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.retailers.length,
              itemBuilder: (context, index){
                
                return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0)
                ),
                child: ListTile(
                
                leading: CircularCheckBox(
                  value: state.selectedRetailer.id == state.retailers[index].id,
                  tristate: true,
                  activeColor: Theme.of(context).primaryColor, 
                  disabledColor: Colors.grey, 
                  onChanged: (val) => this.setState(() {}) 
                ),
                contentPadding: EdgeInsets.zero,
                subtitle: Container(
                  margin: EdgeInsets.only(top: 6.0),
                  child: Text(
                    "${state.retailers[index].address}",
                    style: TextStyle(
                      fontSize: 13.0
                    ),
                  ),
                ),
                title: Container(
                  child: Text(
                    "${state.retailers[index].name}",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0
                    ),
                  )
                ),
                onTap: ()=> this.setState(() { 
                    context.bloc<RetailerBloc>().add(SelectRetailerEvent(state.retailers[index]));
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
                      "Select Retailer",
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