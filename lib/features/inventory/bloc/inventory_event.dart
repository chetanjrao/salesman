import 'package:equatable/equatable.dart';
import 'package:salesman/features/inventory/data/models/inventory.dart';

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