import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class EditInvoice extends StatefulWidget {
  @override
  _EditInvoiceState createState() => _EditInvoiceState();
}

class _EditInvoiceState extends State<EditInvoice> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
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
                  "Add Credit",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400
                  ),
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Customer Name"
                    ),
                  )
                )
              ]
            ),
          ),
        ),
      )
    );
  }
}