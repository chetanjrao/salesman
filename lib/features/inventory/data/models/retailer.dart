class Retailer {
  final int id;
  final String name;
  final String address;
  final String mobile;

  Retailer(this.id, this.name, this.address, this.mobile);

  static Retailer fromJson(dynamic json){
    return Retailer(
      json["id"],
      json["name"],
      json["address"],
      json["mobile"]
    );
  }

}