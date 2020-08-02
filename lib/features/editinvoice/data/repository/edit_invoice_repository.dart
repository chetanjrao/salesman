import 'dart:convert';

import 'package:http/http.dart';
import 'package:salesman/features/api/instantkhata_client.dart';
import 'package:salesman/features/editinvoice/data/models/edit_invoice_models.dart';

class EditInvoiceRepository{
  final InstantKhataClient _instantKhataClient = new InstantKhataClient();

  Future<List<PaymentMethod>> getPaymentMethods(int distributor) async {
    Response _response = await _instantKhataClient.getPaymentMethods(distributor);
    dynamic _jsonResponse = jsonDecode(_response.body);
    List<PaymentMethod> methods = _jsonResponse.map<PaymentMethod>((e) => PaymentMethod.fromJson(e)).toList();
    return methods;
  }

  Future<EditInvoiceMessage> editInvoice(EditInvoiceModel model) async {
    print(model.deadline);
    Response _response = await _instantKhataClient.updateInvoice(model);
    dynamic _jsonResponse = jsonDecode(_response.body);
    EditInvoiceMessage message = EditInvoiceMessage.fromJson(_jsonResponse);
    return message;
  }

}