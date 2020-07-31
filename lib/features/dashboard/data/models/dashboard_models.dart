
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DashboardStatistics extends Equatable {
  final double status;
  final double total;

  DashboardStatistics({@required this.status,@required this.total});

  @override
  List<Object> get props => [status, total];

  static DashboardStatistics fromJson(dynamic json){
    return DashboardStatistics(
      status: json["status"],
      total: json["total"]
    );
  }

}

class RecentTransactions extends Equatable {
  final int id;
  final double amount;
  final bool isCredit;
  final String image;
  final String createdAt;

  RecentTransactions({
    @required this.id,
    @required this.amount,
    @required this.image,
    @required this.isCredit,
    @required this.createdAt
  });

  @override
  List<Object> get props => [id, amount, isCredit, createdAt];

  static RecentTransactions fromJson(dynamic json){
    return RecentTransactions(
      id: json["id"],
      amount: json["amount"],
      isCredit: json["is_credit"],
      image: json["image"],
      createdAt: json["created_at"]
    );
  }

}