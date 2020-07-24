import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:salesman/features/dashboard/data/models/dashboard_models.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class FetchDashboardStatistics extends DashboardEvent {
  
  const FetchDashboardStatistics();

  @override
  List<Object> get props => [];
}