import 'package:bloc/bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:salesman/features/editinvoice/data/models/edit_invoice_models.dart';
import 'package:salesman/features/inventory/bloc/inventory_event.dart';
import 'package:salesman/features/inventory/bloc/inventory_state.dart';
import 'package:salesman/features/inventory/data/models/inventory.dart';
import 'package:salesman/features/inventory/data/respository/inventory.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState>{

  final InventoryRepository inventoryRepository;

  InventoryBloc(
    this.inventoryRepository
  ) : super(InventoryInitialState());

  @override
  Stream<InventoryState> mapEventToState(InventoryEvent event) async* {
    if(event is LoadNewInventory){
      yield NewInventoryState(
        inventoryRepository.loadNewInventory()
      );
    } else if(event is LoadInventory){
      try{
        List<InventoryModel> inventory = await inventoryRepository.getInventory(event.distributor);
        Map<String, String> categories = await inventoryRepository.getCategories(event.distributor);
        yield InventorySuccessState(categories, inventory);
      } catch(error){
        print(error);
      }
    }
    if(event is AddInventory){
        Map<String, InventoryModel> inventory = new Map<String, InventoryModel>.from((state as InventorySuccessState).localInventory);
        if(inventory.containsKey(event.inventoryModel.id.toString())){
          if(inventory[event.inventoryModel.id.toString()].quantity < inventory[event.inventoryModel.id.toString()].productQuantity){
            inventory[event.inventoryModel.id.toString()].quantity += 1;
          }
        } else {
            inventory[event.inventoryModel.id.toString()] = event.inventoryModel;
            if(inventory[event.inventoryModel.id.toString()].productQuantity == 0){
              inventory.remove(event.inventoryModel.id.toString());
            }
        }

        yield InventorySuccessState(
          Map<String, String>.from((state as InventorySuccessState).categories), 
          List<InventoryModel>.from((state as InventorySuccessState).inventory),
          inventory
        );
    }

    if(event is DeleteInventory){
        Map<String, InventoryModel> inventory = Map<String, InventoryModel>.from((state as InventorySuccessState).localInventory);
        if(inventory.containsKey(event.inventoryModel.id.toString())){
           if(inventory[event.inventoryModel.id.toString()].quantity > 1){
              inventory[event.inventoryModel.id.toString()].quantity -= 1;
              yield InventorySuccessState(
                Map<String, String>.from((state as InventorySuccessState).categories), 
                List<InventoryModel>.from((state as InventorySuccessState).inventory),
                inventory
              );
           } else {
             inventory.remove(event.inventoryModel.id.toString());
              yield InventorySuccessState(
                Map<String, String>.from((state as InventorySuccessState).categories), 
                List<InventoryModel>.from((state as InventorySuccessState).inventory),
                inventory
              );
           }
        }
    }

    if(event is InventoryUploadEvent){
      try{
        EditInvoiceMessage message = await inventoryRepository.uploadSale(event.retailer, event.distributor, event.payment, 0, event.amount, event.deadline, event.inventory);
        print(message.message);
        yield NewInventoryUploadSucessState(
          message.message
        );
      } catch(error){
        print(error);
      }

    }

  }



}