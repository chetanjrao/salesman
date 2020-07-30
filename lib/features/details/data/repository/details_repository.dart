import 'dart:convert';

import 'package:http/http.dart';
import 'package:salesman/features/api/instantkhata_client.dart';
import 'package:salesman/features/details/data/models/details_model.dart';

class InvoiceInfoRepository {

  InstantKhataClient _apiClient = new InstantKhataClient();

  Future<InvoiceDetail> getInvoiceInfo(String invoiceID) async{
    Response _responseData = await _apiClient.getInvoiceInfo(invoiceID);
    dynamic parsedData = jsonDecode(_responseData.body);
    InvoiceDetail _invoiceInfo = InvoiceDetail.fromJson(parsedData);
    return _invoiceInfo;
  }

}