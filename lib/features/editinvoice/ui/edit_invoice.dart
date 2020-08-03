import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:salesman/features/details/bloc/details_bloc.dart';
import 'package:salesman/features/details/bloc/details_event.dart';
import 'package:salesman/features/details/data/repository/details_repository.dart';
import 'package:salesman/features/editinvoice/bloc/editinvoice_bloc.dart';
import 'package:salesman/features/editinvoice/bloc/editinvoice_event.dart';
import 'package:salesman/features/editinvoice/bloc/editinvoice_state.dart';
import 'package:salesman/features/editinvoice/data/models/edit_invoice_models.dart';
import 'package:salesman/features/editinvoice/data/repository/edit_invoice_repository.dart';
import 'package:salesman/features/editinvoice/ui/success_page.dart';
import 'package:salesman/utils/globals.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:shimmer/shimmer.dart';

class EditInvoice extends StatefulWidget {

  final String invoice;
  final double balance;

  const EditInvoice({Key key,@required this.invoice,@required this.balance}) : super(key: key);

  @override
  _EditInvoiceState createState() => _EditInvoiceState();
}

class _EditInvoiceState extends State<EditInvoice> {
  InvoiceInfoRepository invoiceInfoRepository = new InvoiceInfoRepository();
  EditInvoiceRepository editInvoiceRepository = new EditInvoiceRepository();
  int currentState = 0;
  int choosenIndex = 0;
  int choosenMethod = 0;
  
  double amount = 0.0;
  String deadline;
  ScrollController _controller = new ScrollController();

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
          title: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Add Credit",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  )
                ],
              ),
          titleSpacing: 0,
          backgroundColor: Colors.white
        ),
      body: SingleChildScrollView(
        controller: _controller,
        child: BlocBuilder<EditInvoiceBloc, EditInvoiceState>(
        builder: (context, state){
          if(state is EditInvoiceInitialState){
            context.bloc<EditInvoiceBloc>().add(LoadPaymentmethods(distributor: 1));
          }
          if(state is EditInvoiceSuccessState){
            return Stepper(
            physics: ClampingScrollPhysics(),
            type: StepperType.vertical,
            currentStep: currentState,
            onStepContinue: (){
              if(currentState < 2){
                setState(() {
                  currentState += 1;
                });
              } else {
                if(amount <= 0){
                  Scaffold.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      "Amount cannot be zero",
                      style: TextStyle(
                        fontFamily: "Euclid Circular B",
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ));
                } else if(amount > widget.balance.ceil()){
                  Scaffold.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      "Amount should be less than or equal to \u20b9${widget.balance.ceil()}",
                      style: TextStyle(
                        fontFamily: "Euclid Circular B",
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ));
                } else if(deadline == null){
                  Scaffold.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      "Deadline cannot be empty",
                      style: TextStyle(
                        fontFamily: "Euclid Circular B",
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ));
                } else {
                  EditInvoiceModel data = EditInvoiceModel(
                    invoice: widget.invoice, 
                    amount: amount, 
                    deadline: deadline, 
                    paymentMode: state.methods[choosenIndex].id
                  );
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) =>  MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                                        value: context.bloc<InvoiceDetailsBloc>()
                                                      ),
                                      BlocProvider.value(
                                                        value: context.bloc<EditInvoiceBloc>()
                                                      ),
                                    ],
                    child: SuccessPage(
                        model: data,
                      )
                  )
                   ));
                }
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
                  disabledColor: Theme.of(context).primaryColor.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)
                  ),
                  color: Theme.of(context).primaryColor,
                  //state is EditInvoiceUploadLoadingState ? null : onStepContinue
                  onPressed: onStepContinue,
                  child: state is EditInvoiceUploadLoadingState ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Creating transaction",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 12.0),
                        height: 18.0,
                        width: 18.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation(Colors.white)
                        )
                      )
                    ],
                  ) : Text(
                    currentState < 2 ? "Next" : "Submit",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
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
              }
            },
            steps: [
              Step(
                
                title: Text("Enter Amount"),
                content: Container(
                  child: TextField(
                    onChanged: (val){
                      setState((){
                        amount = double.parse(val);
                      });
                    },
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
                    onChanged: (val){
                      setState((){
                        final DateFormat formatter = DateFormat('yyyy-MM-dd');
                        final String formatted = formatter.format(val);
                        deadline = formatted;
                      });
                    },
                    style: TextStyle(
                      fontWeight: FontWeight.w500
                    ),
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
                content: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.methods.length,
                  controller: _controller,
              itemBuilder: (context, index){
                
                return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0)
                ),
                child: ListTile(
                
                leading: CircularCheckBox(
                  value: choosenIndex == index,
                  tristate: true,
                  activeColor: Theme.of(context).primaryColor, 
                  disabledColor: Colors.grey, 
                  onChanged: (val) => this.setState(() {}) 
                ),
                trailing: Container(
                    child: Image.network(
                    "$API_URL${state.methods[index].image}",
                    fit: BoxFit.contain,
                    height: 36.0,
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                subtitle: Container(
                  margin: EdgeInsets.only(top: 6.0),
                  child: state.methods[index].isBank ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 0),
                        child: Text(
                          "${state.methods[index].accountId}",
                    style: TextStyle(
                      fontSize: 13.0
                    ),
                        )
                      ),
                    //   Container(
                    //     margin: EdgeInsets.only(top: 4),
                    //     child: Text(
                    //       "IFSC: ${state.methods[index].ifsc}",
                    // style: TextStyle(
                    //   fontSize: 13.0
                    // ),
                    //     )
                    //   )
                    ],
                  ) : Text(
                    "${state.methods[index].accountId}",
                    style: TextStyle(
                      fontSize: 13.0
                    ),
                  ),
                ),
                title: Container(
                  child: Text(
                    "${state.methods[index].name}",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0
                    ),
                  )
                ),
                onTap: ()=> this.setState(() { 
                    choosenIndex = index;
                    }),
              ),
              );
              }
            ),
              
                isActive: currentState != 2,
                state: currentState > 2 ? StepState.complete : StepState.indexed),
            ],
          );
          } else {
            return ListView.builder(
              shrinkWrap: true,
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
        }
      )
      )
      )
    );
  }
}