import 'package:equatable/equatable.dart';

class InventoryModel extends Equatable {
  final int id;
  final int type;
  final String name;
  final double mrp;
  final int productQuantity;
  int quantity;
  final double basePrice;

  InventoryModel(this.id, this.name, this.mrp, this.productQuantity, this.quantity, this.type, this.basePrice);

  @override
  List<Object> get props => [id, name, mrp, quantity, type];
  
  static InventoryModel fromJson(dynamic json){
    return InventoryModel(
      json["product_id"],
      json["name"],
      json["mrp"],
      json["quantity"],
      json["quantity"] > 0,
      json["type"],
      json["base_price"]
    );
  }

}

class LocalInventoryStatus extends Equatable {
  final int items;
  final double amount;

  LocalInventoryStatus(this.items, this.amount);

  @override
  List<Object> get props => [items, amount];

}

class CategoryModel extends Equatable {
  final int id;
  final String name;

  CategoryModel(this.id, this.name);

  @override
  List<Object> get props => [id, name];

  static CategoryModel fromJson(dynamic json){
    return CategoryModel(
      json["id"],
      json["name"]
    );
  }

}