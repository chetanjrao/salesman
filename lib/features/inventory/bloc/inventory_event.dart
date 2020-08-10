import 'package:equatable/equatable.dart';
import 'package:salesman/features/editinvoice/data/models/edit_invoice_models.dart';
import 'package:salesman/features/inventory/bloc/retailer_event.dart';
import 'package:salesman/features/inventory/data/models/inventory.dart';
import 'package:salesman/features/inventory/data/models/retailer.dart';

abstract class InventoryEvent extends Equatable {

}

class LoadInventory extends InventoryEvent {
  final int distributor;

  LoadInventory(this.distributor);
  
  @override
  List<Object> get props => [distributor];

}

class LoadNewInventory extends InventoryEvent {

  @override
  List<Object> get props => [];

}

class AddInventory extends InventoryEvent {
  final InventoryModel inventoryModel;

  AddInventory(this.inventoryModel);

  @override
  List<Object> get props => [ inventoryModel ];

}

class DeleteInventory extends InventoryEvent {
  final InventoryModel inventoryModel;

  DeleteInventory(this.inventoryModel);

  @override
  List<Object> get props => [ inventoryModel ];
}

class InventoryUploadEvent extends InventoryEvent {
  final int distributor;
  final List<Map<String, int>> inventory;
  final int payment;
  final double amount;
  final String deadline;
  final int retailer;

  InventoryUploadEvent(this.inventory, this.payment, this.amount, this.retailer, this.distributor, this.deadline);

  @override
  List<Object> get props => [ inventory, payment, amount, retailer ];
  
}