import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:salesman/utils/globals.dart';

class InstantKhataClient {
  final String _accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNTk3OTQ4Nzc2LCJqdGkiOiJmNGNlMTliNDVkMWY0NzI5OWE5ZTcyNmFhNGU1ODk5ZCIsInVzZXJfaWQiOjF9.dH2pzDoxYtyxoT4TmWnIIwjCWQXEXUbQBQthUyfOORQ";
 // final String _refreshToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYwMDU0MDc3NiwianRpIjoiMzEyMDY2ZWFiZmZkNGJlZjgyMDQ2ZmY1OGFmNGY1YmUiLCJ1c2VyX2lkIjoxfQ.L_rHsNAzuk4cE6s-uxVmaVl8sdjh9eh85vHt_O98mqM";

  Future<http.Response> getDashboardStatistics() async {
    return await http.get(
      "$API_URL/salesman/analytics/",
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_accessToken"
      }
    );
  }

  Future<http.Response> getSalesmanTransactions() async {
    return await http.get(
      "$API_URL/salesman/transactions/",
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_accessToken"
      }
    );
  }

}