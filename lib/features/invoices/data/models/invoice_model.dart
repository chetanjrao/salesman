import 'package:equatable/equatable.dart';

class SingleInvoice extends Equatable {
  final String uid;
  final DateTime createdAt;
  final String retailer;
  final double amount;

  SingleInvoice({this.uid, this.retailer, this.amount, this.createdAt});

  @override
  List<Object> get props => [ uid, retailer, amount, createdAt ];

  static SingleInvoice fromJson(dynamic json){
    return SingleInvoice(
      uid: json["uid"],
      retailer: json["retailer__name"],
      amount: json["total_amount"],
      createdAt: DateTime.parse(json["created_at"])
    );
  }

}