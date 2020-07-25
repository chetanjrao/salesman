import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:salesman/features/dashboard/data/models/dashboard_models.dart';
abstract class DashboardState extends Equatable {

  const DashboardState();

  @override
  List<Object> get props => [];

}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardSuccess extends DashboardState {
  final DashboardStatistics statistics;
  final List<RecentTransactions> transactions;

  const DashboardSuccess({
    @required this.statistics,
    @required this.transactions
  });

  @override
  List<Object> get props => [statistics, transactions];

}

class DashboardError extends DashboardState {
  final String error;

  const DashboardError({@required this.error});

  @override
  String toString() => "Error in dashboard loading: $error";

}