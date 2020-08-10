import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:salesman/features/inventory/bloc/inventory_bloc.dart';
import 'package:salesman/features/inventory/bloc/inventory_event.dart';
import 'package:salesman/features/inventory/bloc/inventory_state.dart';
import 'package:salesman/features/inventory/bloc/payment_bloc.dart';
import 'package:salesman/features/inventory/bloc/payment_event.dart';
import 'package:salesman/features/inventory/bloc/payment_state.dart';
import 'package:salesman/features/inventory/bloc/retailer_bloc.dart';
import 'package:salesman/features/inventory/bloc/retailer_event.dart';
import 'package:salesman/features/inventory/bloc/retailer_state.dart';
import 'package:salesman/features/inventory/data/models/inventory.dart';
import 'package:salesman/features/inventory/data/respository/inventory.dart';
import 'package:salesman/features/inventory/ui/payment.dart';
import 'package:salesman/features/inventory/ui/retailers.dart';
import 'package:salesman/features/inventory/ui/success.dart';
import 'package:salesman/utils/globals.dart';
import 'package:shimmer/shimmer.dart';

class Inventory extends StatefulWidget {
  final int length;

  const Inventory({Key key, this.length}) : super(key: key);
  @override
  _InventoryState createState() => _InventoryState();
}

class Price {
  final double amount;
  final double gst;

  const Price(this.amount, this.gst);
}

class _InventoryState extends State<Inventory> with SingleTickerProviderStateMixin {

  double amount;
  String deadline;
  final InventoryRepository inventoryRepository = new InventoryRepository();
  final GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    amount = 0;
    super.initState();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
  }

  @override
  void dispose(){
    super.dispose();
  }

  Price calculatePrice(Map<String, InventoryModel> state){
    double amount = 0;
    double gst = 0;
    state.forEach((key, value) { 
      amount += value.basePrice * value.quantity;
      gst += amount * 18 /100;
     });
    return Price(amount, double.parse(gst.toStringAsFixed(2)));
  }

  Price calculateSinglePrice(InventoryModel value){
    double amount = 0;
    double gst = 0; 
    amount += value.basePrice * value.quantity;
    gst += amount * 18 /100;
    return Price(amount, double.parse(gst.toStringAsFixed(2)));
  }

  List<Widget> _buildDataWidget(List<InventoryModel> data, BuildContext context, int filterIndex, Map<String, InventoryModel> state){
    List<Widget> list = new List<Widget>();
    list = data.where((element) => element.type == filterIndex).map<Widget>((e) => Container(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: ListTile(
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "${e.name}",
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 6.0),
                              child: Wrap(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      "\u20b9${e.mrp}",
                                      style: TextStyle(
                                        color: Color(0XFF8F8F8F),
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.lineThrough
                                      ),
                                    ),
                                  ),
                                    Text(
                                      "\u20b9${e.basePrice}",
                                      style: TextStyle(
                                        color: Color(0XFF161616),
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                ],
                              )
                            )
                          ],
                        ),
                        trailing: Container(
                          child: Flex(
                            direction: Axis.horizontal,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => context.bloc<InventoryBloc>().add(DeleteInventory(e)),
                                child: Container(
                                  padding: EdgeInsets.all(2.0),
                                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(
                                      width: 1.4,
                                      color: Color(0xFF363636)
                                    )
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: Color(0xFF363636),
                                    size: 20.0,
                                  )
                                )
                              ),
                              Container(
                                child: Text(
                                  !state.containsKey(e.id.toString()) ? "0" : "${state[e.id.toString()].quantity}",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500
                                  ),
                                )
                              ),
                              GestureDetector(
                                onTap: () => context.bloc<InventoryBloc>().add(AddInventory(e)),
                                child: Container(
                                  padding: EdgeInsets.all(2.0),
                                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: Theme.of(context).primaryColor,
                                    border: Border.all(
                                      width: 1.4,
                                      color: Theme.of(context).primaryColor,
                                    )
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20.0,
                                  )
                                )
                              )
                            ]
                          )
                        ),
                      )
                    )).toList();
    return list;
  }


  List<Widget> _buildCartDataWidget(BuildContext context, Map<String, InventoryModel> state){
    List<Widget> list = new List<Widget>();
    state.forEach((key, e) {
      list.add(Container(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: ListTile(
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  "${e.name}",
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 6.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${e.quantity} x \u20b9${e.basePrice} ",
                        style: TextStyle(
                          color: Color(0XFF161616),
                          fontFamily: "Euclid Circular B",
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      TextSpan(
                        text:"+ \u20b9 ${calculateSinglePrice(e).gst}",
                        style: TextStyle(
                          color: Color(0XFF161616),
                          fontFamily: "Euclid Circular B",
                          fontWeight: FontWeight.w500,
                          fontSize: 12
                        ),
                      )
                    ]
                  ),
                )
              )
            ],
          ),
          trailing: Container(
            child: Flex(
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    "\u20B9 ${calculateSinglePrice(e).amount + calculateSinglePrice(e).gst}",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500
                    ),
                  )
                ),
              ]
            )
          ),
        )
      ));
    });
    return list;
  }

  List<Widget> _buildTabView(List<String> categories, BuildContext context, Map<String, InventoryModel> state, List<InventoryModel> data){
    List<Widget> list = new List<Widget>();
    for(int i=0; i < categories.length; i++){
      list.add(
        ListView(
          children: _buildDataWidget(
            data,
            context,
            int.parse(categories[i]),
            state
          ),
        )
      );
    }
    return list;
  }

  List<Widget> _buildTabBars(Map<String, String> data){
    List<Widget> list = new List<Widget>();
    data.forEach((key, value) => list.add(
      Tab(
        text: value
      )
    ));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state){
          if(state is InventoryInitialState){
            context.bloc<InventoryBloc>().add(LoadInventory(1));
            context.bloc<RetailerBloc>().add(LoadRetailersEvent(1));
            context.bloc<PaymentBloc>().add(LoadPaymentmethods(distributor: 1));
            return Scaffold(
              key: key,
            backgroundColor: Colors.white,
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
                          "Add Inventory",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                body: Center(
                      child: ListView.builder(
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
                        )
                    ),
              );
          }
          if(state is InventorySuccessState){
            return DefaultTabController(
              length: state.categories.length,
              child: Scaffold(
                key: key,
                backgroundColor: Colors.white,
                bottomSheet: Container(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    color: Color(0xFF238551),
                    margin: EdgeInsets.all(12.0),
                    elevation: 0,
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      child: Flex(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      direction: Axis.horizontal,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "${state.localInventory.length} ${state.localInventory.length == 1 ? "ITEM" : "ITEMS"}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16
                                ),
                              )
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:"\u20b9 ${calculatePrice(state.localInventory).amount.toStringAsFixed(2)} + \u20b9 ${calculatePrice(state.localInventory).gst.toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontFamily: "Euclid Circular B",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14
                                      ),
                                    ),
                                    TextSpan(
                                      text:" (18% GST)",
                                      style: TextStyle(
                                        fontFamily: "Euclid Circular B",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10
                                      ),
                                    )
                                  ]
                                ),
                              )
                            )
                          ]
                        ),
                        Container(
                          child: state.localInventory.length > 0 ? FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                            color: Colors.transparent,
                            onPressed: (){
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context, 
                                builder: (_){
                                  return MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                        value: BlocProvider.of<InventoryBloc>(context),
                                      ),
                                      BlocProvider.value(
                                        value: BlocProvider.of<PaymentBloc>(context),
                                      ),
                                      BlocProvider.value(
                                        value: BlocProvider.of<RetailerBloc>(context),
                                      )
                                    ],
                                    child: Container(
                                        height: MediaQuery.of(context).size.height * 0.7,
                                        child: Flex(
                                          mainAxisSize: MainAxisSize.max,
                                          direction: Axis.vertical,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(12.0),
                                              width: double.infinity,
                                              color: Color(0Xff2e5bff),
                                              child: Flex(
                                                direction: Axis.vertical,
                                                children: [
                                                    Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "CREATE INVOICE FOR",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12.0
                                                      )
                                                    )
                                                  ),
                                                  BlocBuilder<RetailerBloc, RetailerState>(
                                                    builder: (context, state){
                                                      if(state is RetailerSuccessState){
                                                        return Container(
                                                    margin: EdgeInsets.only(
                                                      top: 12.0
                                                    ),
                                                    child: Flex(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      direction: Axis.horizontal,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Wrap(
                                                              children: [
                                                                Container(
                                                                  child: Icon(
                                                                    FontAwesome.check_circle,
                                                                    color: Colors.white,
                                                                  )
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets.only(left: 12.0),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        "${state.selectedRetailer.name}",
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontSize: 16.5
                                                                        )
                                                                      ),
                                                                      Container(
                                                                        margin: EdgeInsets.only(
                                                                          top: 6.0
                                                                        ),
                                                                        child: Text(
                                                                          "${state.selectedRetailer.address}",
                                                                        overflow: TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize: 13,
                                                                            fontWeight: FontWeight.w300
                                                                          )
                                                                        )
                                                                      )
                                                                    ]
                                                                  )
                                                                )
                                                              ]
                                                            )
                                                        ),
                                                        Container(
                                                          child: FlatButton(
                                                            onPressed: (){
                                                              Navigator.of(context).push(MaterialPageRoute(
                                                              builder: (_) => BlocProvider.value(
                                                                value: BlocProvider.of<RetailerBloc>(context),
                                                                child: RetailerMethod()
                                                              )
                                                            ));
                                                            },
                                                            child: Text(
                                                              "Change",
                                                              style: TextStyle(
                                                                decoration: TextDecoration.underline,
                                                                decorationStyle: TextDecorationStyle.dashed,
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 17.0
                                                              )
                                                            )
                                                          )
                                                        )
                                                      ],
                                                    )
                                                  );
                                                      }
                                                      return Container();
                                                    },
                                                  )
                                                ]
                                              )
                                                ]
                                              )
                                            ),
                                            Expanded(
                                              child: BlocBuilder(
                                                  bloc: context.bloc<InventoryBloc>(),
                                                  builder: (context, state){
                                                    if(state is InventorySuccessState){
                                                      return Container(
                                                        child: ListView(
                                                          shrinkWrap: true,
                                                          children: _buildCartDataWidget(
                                                          context,
                                                          state.localInventory),
                                                        )
                                                      );
                                                    } 
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
                                                  },
                                                ),
                                            ),
                                              Container(
                                                padding: EdgeInsets.all(16.0),
                                                child: BlocBuilder<PaymentBloc, PaymentState>(
                                                  builder: (context, state){
                                                    if(state is PaymentSuccessState){
                                                      return Flex(
                                                  direction: Axis.horizontal,
                                                  children: [
                                                    Expanded(
                                                      child: Material(
                                                        child: InkWell(
                                                          onTap: (){
                                                            Navigator.of(context).push(MaterialPageRoute(
                                                              builder: (_) => BlocProvider.value(
                                                                value: BlocProvider.of<PaymentBloc>(context),
                                                                child: PaymentsMethod()
                                                              )
                                                            ));
                                                          },
                                                          splashColor: Colors.black.withOpacity(0.2),
                                                        child: Container(
                                                          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            Container(
                                                              margin: EdgeInsets.only(top: 6.0),
                                                              child: Image.network(
                                                                "$API_URL${state.selectedPayment.image}",
                                                                height: 36.0
                                                              ),
                                                            ),
                                                            Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: <Widget>[
                                                                  Container(
                                                                    margin: EdgeInsets.only(left: 16.0),
                                                                    child: Text(
                                                                      "PAY USING",
                                                                      style: TextStyle(
                                                                        fontSize: 12.0,
                                                                        color: Color(0xFF8F8F8F),
                                                                        fontWeight: FontWeight.w400,
                                                                        decorationStyle: TextDecorationStyle.dashed
                                                                      ),
                                                                    )
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(left: 16.0, top: 1.0),
                                                                    child: Text(
                                                                      "${state.selectedPayment.name}",
                                                                      style: TextStyle(
                                                                        fontSize: 18.0,
                                                                        fontWeight: FontWeight.w600,
                                                                        decoration: TextDecoration.underline,
                                                                        decorationStyle: TextDecorationStyle.dashed
                                                                      ),
                                                                    )
                                                                  )
                                                                ],
                                                              ),
                                                          ],
                                                        )
                                                          ]
                                                        )
                                                              )))

                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.3,
                                                      child: FlatButton(      
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(4.0)
                                                        ),
                                                        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                                                        color: Color(0Xff2e5bff),
                                                        onPressed: () => {
                                                          showDialog(
                                                            context: _,
                                                            child: Dialog(
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: <Widget>[
                                                                  Container(
                                                                padding: EdgeInsets.all(24.0),
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
                                                              Container(
                                                                padding: EdgeInsets.all(24.0),

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
                                                              Container(
                                                                margin: EdgeInsets.all(24.0),
                                                                child: FlatButton(      
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(4.0)
                                                        ),
                                                        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                                                        color: Color(0Xff2e5bff),
                                                        onPressed: (){
                                                          InventoryState inventoryState = context.bloc<InventoryBloc>().state;
                                                          if(inventoryState is InventorySuccessState){
                                                            double totalPrice = calculatePrice(inventoryState.localInventory).amount + calculatePrice(inventoryState.localInventory).gst;
                                                            if(amount > totalPrice || amount == 0){
                                                              key.currentState.showSnackBar(SnackBar(
                                                                behavior: SnackBarBehavior.floating,
                                                                content: Text(
                                                                  "${amount == 0 ? "Amount cannot be zero":  "Amount should be greater than $totalPrice"}",
                                                                  style: TextStyle(
                                                                    fontFamily: "Euclid Circular B",
                                                                    fontWeight: FontWeight.w500
                                                                  ),
                                                                ),
                                                              ));
                                                            } else if (deadline == null) {
                                                                key.currentState.showSnackBar(SnackBar(
                                                                behavior: SnackBarBehavior.floating,
                                                                content: Text(
                                                                  "Deadline cannot be null",
                                                                  style: TextStyle(
                                                                    fontFamily: "Euclid Circular B",
                                                                    fontWeight: FontWeight.w500
                                                                  ),
                                                                ),
                                                              ));
                                                            } else {
                                                              Navigator.of(context).pop();
                                                              Navigator.of(context).pop();
                                                                Navigator.of(context).pushReplacement(
                                                                MaterialPageRoute(
                                                                  builder: (_) => MultiBlocProvider(
                                                                  providers: [
                                                                    BlocProvider.value(
                                                                      value: BlocProvider.of<InventoryBloc>(context),
                                                                    ),
                                                                    BlocProvider.value(
                                                                      value: BlocProvider.of<PaymentBloc>(context),
                                                                    ),
                                                                    BlocProvider.value(
                                                                      value: BlocProvider.of<RetailerBloc>(context),
                                                                    ),
                                                                  ],
                                                                  child: InventorySuccessPage(
                                                                    amount: amount,
                                                                    deadline: deadline
                                                                  )
                                                                )
                                                                  
                                                                  
                                                                )
                                                              );
                                                            }
                                                          }
                                                        },
                                                        child: Text(
                                                          "Process Payment",
                                                          style: TextStyle(
                                                            color: Colors.white
                                                          ),
                                                          ),
                                                         ),
                                                              )
                                                                ],
                                                              )
                                                            )
                                                          )
                                                        },
                                                        child: BlocBuilder<InventoryBloc, InventoryState>(
                                                          builder: (context, state){
                                                            if(state is InventorySuccessState){
                                                             return Flex(
                                                          direction: Axis.horizontal,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Container(
                                                                  child: Text(
                                                                    "\u20b9 ${(calculatePrice(state.localInventory).amount + calculatePrice(state.localInventory).gst).toStringAsFixed(2)}",
                                                                    style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 17.0,
                                                                      fontWeight: FontWeight.w500
                                                                    )
                                                                  )
                                                                ),
                                                                Container(
                                                                  child: Text(
                                                                    "TOTAL",
                                                                    style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 14.0,
                                                                      fontWeight: FontWeight.w300
                                                                    )
                                                                  )
                                                                )
                                                              ]
                                                            ),
                                                            Wrap(
                                                              children: [
                                                                Text(
                                                                  "Place order",
                                                                  style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 16.0,
                                                                    fontWeight: FontWeight.w300
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child: Icon(
                                                                    Icons.arrow_right,
                                                                    color: Colors.white,
                                                                    size: 24,
                                                                  ),
                                                                )
                                                              ]
                                                            ),

                                                          ]
                                                        );
                                                            } 
                                                            return Shimmer.fromColors(
                              baseColor: Colors.grey[200],
                              highlightColor: Colors.grey[100],
                              child: FlatButton(      
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(4.0)
                                                        ),
                                                        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                                                        color: Color(0Xff2e5bff),
                                                        onPressed: () => null,
                                                        child: Text(""),
                                                         )
                        );
                                                          }
                                                        )
                                                      ) 
                                                    )
                                                  ]
                                                );
                                                    }
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
                                                  }
                                                )
                                              )
                                            
                                          ]
                                        )
                                      ),
                                  );
                                }
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "View Cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400
                                  ),
                                ),
                                Container(
                                  child: Icon(
                                    Icons.arrow_right,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                )
                              ]
                            )
                          ) : Container(
                            height: 0,
                            width: 0
                          )
                        )
                      ]
                    ),)
                  )
                ),
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
                          "Add Inventory",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      )
                    ],
                  ),
                  bottom: TabBar(
                    isScrollable: true,
                    indicatorColor: Theme.of(context).primaryColor,
                    labelColor: Theme.of(context).primaryColor,
                    indicatorWeight: 1.0,
                    unselectedLabelColor: Color(0XFF404864),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Euclid Circular B'
                    ),
                    tabs: _buildTabBars(state.categories),
                  ),
                ),
                body: Container(
                  child: TabBarView(
                    children: _buildTabView(
                      state.categories.keys.toList(),
                      context,
                      state.localInventory,
                      state.inventory
                    )
                  ),
                )
              )
            );
          } 
          return Container();
        },
      )
    );
  }
}