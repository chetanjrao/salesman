import 'package:flutter/material.dart';

class EditInvoiceModel {
  final String invoice;
  final double amount;
  final String deadline;
  final int paymentMode;

  const EditInvoiceModel({
    @required this.invoice,
    @required this.amount,
    @required this.deadline,
    @required this.paymentMode
  });

}

class PaymentMethod {
  final int id;
  final String accountId;
  final String accountName;
  final bool isBank;
  final String ifsc;
  final String image;
  final String name;

  const PaymentMethod({
    @required this.id,
    @required this.accountId,
    @required this.accountName,
    @required this.isBank,
    @required this.ifsc,
    @required this.image,
    @required this.name,
  });

  static PaymentMethod fromJson(dynamic json){
    return PaymentMethod(
      id: json["id"],
      accountId: json["account_id"],
      accountName: json["account_name"],
      isBank: json["is_bank"],
      ifsc: json["ifsc"],
      image: json["image"],
      name: json["name"]
    );
  }

}

class EditInvoiceMessage {

  final int status;
  final String message;

  const EditInvoiceMessage(this.status, this.message);

  static EditInvoiceMessage fromJson(dynamic json){
    return EditInvoiceMessage(
      json["status"],
      json["message"]
    );
  }

}