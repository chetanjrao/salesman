import 'package:bloc/bloc.dart';
import 'package:salesman/features/inventory/bloc/retailer_event.dart';
import 'package:salesman/features/inventory/bloc/retailer_state.dart';
import 'package:salesman/features/inventory/data/models/retailer.dart';
import 'package:salesman/features/inventory/data/respository/inventory.dart';

class RetailerBloc extends Bloc<RetailerEvent, RetailerState>{

  final InventoryRepository inventoryRepository;

  RetailerBloc(this.inventoryRepository): assert(inventoryRepository != null), super(RetailerInitialState());

  @override
  Stream<RetailerState> mapEventToState(RetailerEvent event) async* {
    if(event is LoadRetailersEvent){
      try {
        yield RetailerLoadingState();
        List<Retailer> retailers = await inventoryRepository.getRetailers(event.distributor);
        yield RetailerSuccessState(
          retailers,
          retailers[0]
        );
      } catch(error){
        print(error);
      }
    }
    if(event is SelectRetailerEvent){
      List<Retailer> retailers = List<Retailer>.from((state as RetailerSuccessState).retailers);
      yield RetailerSuccessState(
        retailers,
        event.retailer
      );
    }
  }

}