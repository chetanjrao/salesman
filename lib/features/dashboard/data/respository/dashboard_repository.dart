import 'dart:convert';
import 'package:http/src/response.dart';
import 'package:salesman/features/api/instantkhata_client.dart';
import 'package:salesman/features/dashboard/data/models/dashboard_models.dart';

class DashboardRepository {
  final _apiClient = new InstantKhataClient();

  Future<DashboardStatistics> getStatisticsData(int distributor) async {
    Response _response = await _apiClient.getDashboardStatistics(distributor);
    DashboardStatistics _statistics = DashboardStatistics.fromJson(jsonDecode(_response.body));
    return _statistics;
  }

  Future<List<RecentTransactions>> getRecentTransactions(int distributor) async {
    Response _response = await _apiClient.getSalesmanTransactions(distributor);
    List<dynamic> _parsedJson = jsonDecode(_response.body);
    List<RecentTransactions> _transactions = _parsedJson.map((e) => RecentTransactions.fromJson(e)).toList();
    return _transactions;
  }
}
