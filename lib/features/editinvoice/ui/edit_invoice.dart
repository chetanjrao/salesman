import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:salesman/utils/globals.dart';
import 'package:circular_check_box/circular_check_box.dart';

class EditInvoice extends StatefulWidget {
  @override
  _EditInvoiceState createState() => _EditInvoiceState();
}

class _EditInvoiceState extends State<EditInvoice> {

  int currentState = 0;

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
          backgroundColor: Colors.white
        ),
      body: Stepper(
            physics: ScrollPhysics(),
            type: StepperType.vertical,
            currentStep: currentState,
            onStepContinue: (){
              if(currentState < 2){
                setState(() {
                  currentState += 1;
                });
              } else {
                print("compleye");
              }
            },
            onStepTapped: (step){
              setState(() {
                currentState = step;
              });
            },
            controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}){
              return Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(vertical: 16.0),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: onStepContinue, 
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  )
                )
              );
            },
            onStepCancel: (){
                if(currentState > 0){
                setState(() {
                  currentState -= 1;
                });
              } else {
                setState(() {
                  currentState = 0;
                });
                print("compleye");
              }
            },
            steps: [
              Step(
                title: Text("Enter Amount"),
                content: Container(
                  child: TextField(
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.w500,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: UnderlineInputBorder(
                      borderSide: new BorderSide(
                        width: 0.3,
                        color: Color(0xFF404864)
                        )),
                        focusedBorder: UnderlineInputBorder(
                      borderSide: new BorderSide(
                          width: 0.3,
                          color: Color(0xFF404864)
                      )),
                      focusColor: Color(0xFF404864),
                      labelText: "Amount",
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF404864)
                      ),
                      hintStyle: TextStyle(
                        height: 2,
                        color: Color(0xFF404864)
                      ),
                      contentPadding: EdgeInsets.only(left: 0.0, right: 16.0, top: 12.0, bottom: 8.0),
                    ),
                  )
                ), 
                isActive: currentState != 0,
                state: currentState > 0 ? StepState.complete : StepState.indexed
              ),
              Step(
                title: Text("Choose Deadline"), 
                content: Container(
                  child: DateTimeField(
                  textAlign: TextAlign.left,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                      width: 0.3,
                      color: Color(0xFF404864)
                      )),
                      focusColor: Color(0xFF404864),
                      labelText: "Deadline",
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(
                        color: Color(0xFF404864)
                      ),
                      hintStyle: TextStyle(
                        height: 1.3,
                        color: Color(0xFF404864)
                      ),
                      hintText: ""
                    ),
                  format: DateFormat("yyyy-MM-dd"), 
                  onShowPicker: (context, value) {
                    return showDatePicker(
                    confirmText: "Choose",
                    cancelText: "Cancel",
                    context: context,
                    firstDate: DateTime.now(),
                    initialDate: DateTime.now().add(Duration(days: 1)),
                    lastDate: DateTime(2100));
                  }
                ),
                ), 
                isActive: currentState != 1,
                state: currentState > 1 ? StepState.complete : StepState.indexed),
              Step(
                title: Text("Choose Payment Method"), 
                content: Column(
        
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             ListTile(
                leading: CircularCheckBox(
                  value: true,
                  tristate: true,
                  activeColor: Theme.of(context).primaryColor, 
                  disabledColor: Colors.grey, 
                  onChanged: (val) => this.setState(() { }) 
                ),
                trailing: Container(
                    child: Image.network(
                    "$API_URL/uploads/uploads/providers/phonepe.png",
                    fit: BoxFit.cover,
                    height: 36.0,
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                subtitle: Text("9110466718@paytm"),
                title: Text("Phone Pe"),
                onTap: ()=> this.setState(() { }),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0)
                ),
                child: ListTile(
                leading: CircularCheckBox(
                  value: false,
                  tristate: true,
                  activeColor: Theme.of(context).primaryColor, 
                  disabledColor: Colors.grey, 
                  onChanged: (val) => this.setState(() { }) 
                ),
                trailing: Container(
                    child: Image.network(
                    "$API_URL/uploads/uploads/providers/gpay.jpg",
                    fit: BoxFit.cover,
                    height: 36.0,
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                subtitle: Container(
                  margin: EdgeInsets.only(top: 6.0),
                  child: Text(
                    "9110466718@paytm",
                    style: TextStyle(
                      fontSize: 13.0
                    ),
                  ),
                ),
                title: Container(
                  child: Text(
                    "Google Pay",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0
                    ),
                  )
                ),
                onTap: ()=> this.setState(() { }),
              ),
              )
            
          ],
        ),
                isActive: currentState != 2,
                state: currentState > 2 ? StepState.complete : StepState.indexed),
            ],
          ),
      )
    );
  }
}