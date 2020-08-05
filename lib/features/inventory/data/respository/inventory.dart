import 'dart:convert';

import 'package:http/http.dart';
import 'package:salesman/features/api/instantkhata_client.dart';
import 'package:salesman/features/inventory/data/models/inventory.dart';

class InventoryRepository {

  InstantKhataClient _apiClient = new InstantKhataClient();
  Map<String, InventoryModel> localInventory = {};
  

  Future<List<InventoryModel>> getInventory(int distributor) async {
    Response response = await _apiClient.getSalesmanInventory(distributor);
    dynamic json = jsonDecode(response.body);
    List<InventoryModel> inventory = json.map<InventoryModel>((e) => InventoryModel.fromJson(e)).toList();
    return inventory;
  }

  Map<String, InventoryModel> loadNewInventory(){
    return localInventory;
  }

  Future<Map<String, String>> getCategories(int distributor) async {
    Response response = await _apiClient.getInventoryTypes(distributor);
    dynamic json = jsonDecode(response.body);
    List<CategoryModel> data = json.map<CategoryModel>((e) => CategoryModel.fromJson(e)).toList();
    return Map.fromIterable(data, key: (v) => v.id.toString(), value: (v) => v.name);
  }

}