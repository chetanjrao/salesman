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

  const DashboardSuccess({
    @required this.statistics
  });

  @override
  List<Object> get props => [statistics];

}

class DashboardError extends DashboardState {
  final String error;

  const DashboardError({@required this.error});

  @override
  String toString() => "Error in dashboard loading: $error";

}