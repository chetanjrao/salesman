import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/message_format.dart';
import 'package:salesman/features/api/instantkhata_client.dart';
import 'package:salesman/features/editinvoice/data/models/edit_invoice_models.dart';
import 'package:salesman/features/inventory/data/models/inventory.dart';
import 'package:salesman/features/inventory/data/models/retailer.dart';

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

  Future<List<Retailer>> getRetailers(int distributor) async {
    Response _response = await _apiClient.getAllRetailers(distributor);
    dynamic _jsonResponse = jsonDecode(_response.body);
    List<Retailer> retailers = _jsonResponse.map<Retailer>((e) => Retailer.fromJson(e)).toList();
    return retailers;
  }

  Future<List<PaymentMethod>> getPaymentMethods(int distributor) async {
    Response _response = await _apiClient.getPaymentMethods(distributor);
    dynamic _jsonResponse = jsonDecode(_response.body);
    List<PaymentMethod> methods = _jsonResponse.map<PaymentMethod>((e) => PaymentMethod.fromJson(e)).toList();
    return methods;
  }

  Future<EditInvoiceMessage> uploadSale(int retailer, int distributor, int paymentMode, double amount, double paid, String deadline, List<Map<String, int>> state) async {
    Response response = await _apiClient.createSale(retailer, distributor, paymentMode, amount, paid, deadline, state);
    dynamic json = jsonDecode(response.body);
    EditInvoiceMessage message = EditInvoiceMessage.fromJson(json);
    return message;
  }

}