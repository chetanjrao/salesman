class InventoryModel {
  final int id;
  final String name;
  final double mrp;
  final int quantity;

  InventoryModel(this.id, this.name, this.mrp, this.quantity);
  
  static InventoryModel fromJson(dynamic json){
    return InventoryModel(
      json["product_id"],
      json["product__name"],
      json["product__mrp"],
      json["quantity"]
    );
  }

}