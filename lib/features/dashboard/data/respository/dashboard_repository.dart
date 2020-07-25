import 'dart:convert';
import 'package:http/src/response.dart';
import 'package:salesman/features/api/instantkhata_client.dart';
import 'package:salesman/features/dashboard/data/models/dashboard_models.dart';

class DashboardRepository {
  final _apiClient = new InstantKhataClient();

  Future<DashboardStatistics> getStatisticsData() async {
    Response _response = await _apiClient.getDashboardStatistics();
    DashboardStatistics _statistics = DashboardStatistics.fromJson(jsonDecode(_response.body));
    return _statistics;
  }

  Future<List<RecentTransactions>> getRecentTransactions() async {
    Response _response = await _apiClient.getSalesmanTransactions();
    List<dynamic> _parsedJson = jsonDecode(_response.body);
    List<RecentTransactions> _transactions = _parsedJson.map((e) => RecentTransactions.fromJson(e)).toList();
    return _transactions;
  }
}
