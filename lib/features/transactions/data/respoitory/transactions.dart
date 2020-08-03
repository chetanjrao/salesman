import 'dart:convert';

import 'package:http/http.dart';
import 'package:salesman/features/api/instantkhata_client.dart';
import 'package:salesman/features/transactions/data/models/transactions.dart';

class TransactionRepository {
  InstantKhataClient _apiClient = new InstantKhataClient();
  
  Future<List<TransactionModel>> getAllTrnsactions(int distributor) async {
    Response source = await _apiClient.getAllTransactions(distributor);
    dynamic json = jsonDecode(source.body);
    List<TransactionModel> data = json.map<TransactionModel>((e) => TransactionModel.fromJson(e)).toList();
    return data;
  }

}