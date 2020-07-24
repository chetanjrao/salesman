import 'dart:convert';
import 'package:http/src/response.dart';
import 'package:salesman/features/api/instantkhata_client.dart';
import 'package:salesman/features/dashboard/data/models/dashboard_models.dart';

class DashboardRepository {
  final _apiClient = new InstantKhataClient();

  Future<DashboardStatistics> getStatisticsData() async {
    Response _response = await _apiClient.getDashboardStatistics();
    print(_response.body);
    DashboardStatistics _statistics = DashboardStatistics.fromJson(jsonDecode(_response.body));
    return _statistics;
  }

  Future<dynamic> getRecentTransactionsData() async {}
}
