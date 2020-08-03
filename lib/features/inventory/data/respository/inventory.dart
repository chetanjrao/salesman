import 'dart:convert';

import 'package:http/http.dart';
import 'package:salesman/features/api/instantkhata_client.dart';
import 'package:salesman/features/inventory/data/models/inventory.dart';

class InventoryRepository {

  InstantKhataClient _apiClient = new InstantKhataClient();

  Future<List<InventoryModel>> getInventory(int distributor) async {
    Response response = await _apiClient.getSalesmanInventory(distributor);
    dynamic json = jsonDecode(response.body);
    List<InventoryModel> inventory = json.map<InventoryModel>((e) => InventoryModel.fromJson(e)).toList();
    return inventory;
  }

}