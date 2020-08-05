import 'package:equatable/equatable.dart';
import 'package:salesman/features/inventory/data/models/inventory.dart';

abstract class InventoryState {
  
  const InventoryState();

}


class InventoryInitialState extends InventoryState {

  const InventoryInitialState();
}

class NewInventoryState extends InventoryState {

  final Map<String, InventoryModel> localInventory;

  const NewInventoryState(
    this.localInventory
  );

}

class NewInventoryLoadingState extends InventoryState {

}
class InventoryLoadingState extends InventoryState {

}

class InventorySuccessState extends InventoryState {
  final Map<String, String> categories;
  final List<InventoryModel> inventory;
  final Map<String, InventoryModel> localInventory;

  InventorySuccessState(this.categories, this.inventory, [this.localInventory = const {}]);

}

class InventoryErrorState extends InventoryState {

}

class NewInventoryUploadState extends InventoryState {

}

class NewInventoryUploadingState extends InventoryState {

}

class NewInventoryUploadSucessState extends InventoryState {
  
}