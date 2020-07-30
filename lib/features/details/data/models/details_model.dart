import 'package:flutter/material.dart';

class InvoiceDetail {
  final InvoiceInfo invoiceInfo;
  final List<InvoiceSale> invoiceSales;

  InvoiceDetail({
    @required this.invoiceInfo,
    @required this.invoiceSales
  });

  static InvoiceDetail fromJson(dynamic json){
    List<InvoiceSale> sales = json["sales"].map<InvoiceSale>((e) => InvoiceSale.fromJson(e)).toList();
    return InvoiceDetail(
      invoiceInfo: InvoiceInfo.fromJson(json["info"]),
      invoiceSales: sales
    );
  }

}

class InvoiceInfo {
  final String uid;
  final String retailer;
  final double balance;
  final double total;
  final String deadline;
  final String salesman;
  final DateTime createdAt;

  InvoiceInfo({
    @required this.uid,
    @required this.retailer,
    @required this.balance,
    @required this.total,
    @required this.deadline,
    @required this.salesman,
    @required this.createdAt
  });

  static InvoiceInfo fromJson(dynamic json){
    return InvoiceInfo(
      uid: json["uid"],
      retailer: json["retailer"],
      balance: json["balance"],
      total: json["total"],
      deadline: json["deadline"],
      salesman: json["salesman"],
      createdAt: DateTime.parse(json["created_at"])
    );
  }

}

class InvoiceSale {

  final String name;
  final int quantity;
  final double amount;
  final double price;

  const InvoiceSale({
    @required this.name,
    @required this.quantity,
    @required this.amount,
    @required this.price,
  });

  static InvoiceSale fromJson(dynamic json){
    return InvoiceSale(
      name: json["name"],
      quantity: json["quantity"],
      amount: json["amount"],
      price: json["price"]
    );
  }

}

// class InvoiceTransaction {
//   final int id;
//   final int invoiceId;
//   final double openingBalance;
//   final double closingBalance;
//   final double amount;
//   final double remainingBalance;
//   final bool isCredit;
//   final String paymentImage;
//   final String paymentMode;
//   final double
// }