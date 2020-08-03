class TransactionModel {
  final int id;
  final double amount;
  final bool isCredit;
  final String image;
  final String createdAt;

  TransactionModel(this.id, this.amount, this.isCredit, this.image, this.createdAt);
  
  static TransactionModel fromJson(dynamic json){
    return TransactionModel(
      json["id"],
      json["amount"],
      json["is_credit"],
      json["image"],
      json["created_at"]
    );
  }
}