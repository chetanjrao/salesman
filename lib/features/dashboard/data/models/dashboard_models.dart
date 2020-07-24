
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