import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:salesman/features/inventory/bloc/inventory_bloc.dart';
import 'package:salesman/features/inventory/bloc/inventory_event.dart';
import 'package:salesman/features/inventory/bloc/inventory_state.dart';
import 'package:salesman/features/inventory/data/models/inventory.dart';
import 'package:shimmer/shimmer.dart';

class Inventory extends StatefulWidget {
  final int length;

  const Inventory({Key key, this.length}) : super(key: key);
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> with SingleTickerProviderStateMixin {

  @override
  void initState() {
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
                                  fontSize: 15.0
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 6.0),
                              child: Text(
                                "Base Price: \u20b9${e.basePrice}",
                                style: TextStyle(
                                  color: Color(0XFF404864),
                                  fontSize: 13.0
                                ),
                              ),
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
                                  margin: EdgeInsets.only(left: 12.0, right: 4.0),
                                  child: Icon(
                                    Feather.minus_square,
                                    color: Colors.red,
                                    size: 28.0,
                                  )
                                )
                              ),
                              Container(
                                child: Text(
                                  !state.containsKey(e.id.toString()) ? "0" : "${state[e.id.toString()].quantity}",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500
                                  ),
                                )
                              ),
                              GestureDetector(
                                onTap: () => context.bloc<InventoryBloc>().add(AddInventory(e)),
                                child: Container(
                                  margin: EdgeInsets.only(left: 12.0, right: 4.0),
                                  child: Icon(
                                    Feather.plus_square,
                                    color: Theme.of(context).primaryColor,
                                    size: 28.0,
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
          print(state);
          if(state is InventoryInitialState){
            context.bloc<InventoryBloc>().add(LoadInventory(1));
            return Scaffold(
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
                backgroundColor: Colors.white,
                bottomSheet: Container(
                  height: 84.0,
                  width: double.infinity,
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    margin: EdgeInsets.all(12.0),
                    elevation: 0,
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "${state.localInventory.length} ITEMS",
                                
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              )
                            )
                          ]
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