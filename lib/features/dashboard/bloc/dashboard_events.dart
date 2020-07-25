import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class FetchDashboardStatistics extends DashboardEvent {
  
  const FetchDashboardStatistics();

  @override
  List<Object> get props => [];
}

class FetchRecentTransactions extends DashboardEvent {
  
  const FetchRecentTransactions();

  @override
  List<Object> get props => [];
}