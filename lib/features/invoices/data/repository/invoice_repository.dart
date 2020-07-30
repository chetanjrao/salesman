import 'dart:convert';

import 'package:http/http.dart';
import 'package:salesman/features/api/instantkhata_client.dart';
import 'package:salesman/features/invoices/data/models/invoice_model.dart';

class InvoiceRepository {
  
  InstantKhataClient _apiClient = new InstantKhataClient();

  Future<List<SingleInvoice>> getInvoices() async {
    Response _response = await _apiClient.getInvoices(1);
    List<dynamic> _parsedJson = jsonDecode(_response.body);
    List<SingleInvoice> _data = _parsedJson.map((e) => SingleInvoice.fromJson(e)).toList();
    return _data;
  }

} 