import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:salesman/features/details/ui/details.dart';

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
          // title: Text(
          //   "Invoices",
          //   style: TextStyle(
          //     color: Colors.black
          //   )
          // ),
          // titleSpacing: 0,
          leading:  Icon(
            Feather.chevron_left,
            color: Theme.of(context).primaryColor
          ),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: 20,
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
                            "Raghav Sales and Services",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.0
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6.0),
                          child: Text(
                            "May 2, 9:24 PM",
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
                        "\u20b9 122.4",
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
          )
        ),
      ),
    );
  }
}