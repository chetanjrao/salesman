import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:salesman/features/dashboard/bloc/dashboard_events.dart';
import 'package:salesman/features/dashboard/bloc/dashboard_state.dart';
import 'package:salesman/features/dashboard/data/models/dashboard_models.dart';
import 'package:salesman/features/dashboard/data/respository/dashboard_repository.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository dashboardRepository;

  DashboardBloc({  @required this.dashboardRepository }) : assert(dashboardRepository != null), super(DashboardInitial());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if(event is FetchDashboardStatistics){
      yield DashboardLoading();
      try {
        final DashboardStatistics _statistics = await dashboardRepository.getStatisticsData();
        final List<RecentTransactions> _transactions = await dashboardRepository.getRecentTransactions();
        yield DashboardSuccess(
          statistics: _statistics,
          transactions: _transactions
        );
      } catch(error){
        print(error);
        yield DashboardError(error: error.toString());
      }
    }
    
  } 

}