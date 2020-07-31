import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class FetchDashboardStatistics extends DashboardEvent {
  final int distributor;
  
  const FetchDashboardStatistics({
    @required this.distributor
  });

  @override
  List<Object> get props => [distributor];
}

class FetchRecentTransactions extends DashboardEvent {

  final int distributor;
  
  const FetchRecentTransactions({
    @required this.distributor
  });

  @override
  List<Object> get props => [distributor];
}