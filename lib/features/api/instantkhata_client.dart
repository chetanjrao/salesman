import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:salesman/features/editinvoice/data/models/edit_invoice_models.dart';
import 'package:salesman/features/inventory/data/models/inventory.dart';
import 'package:salesman/utils/globals.dart';

class InstantKhataClient {

  final String CONTEXT_API_URL = "$API_URL/salesman";

  final String _accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNTk3OTQ4Nzc2LCJqdGkiOiJmNGNlMTliNDVkMWY0NzI5OWE5ZTcyNmFhNGU1ODk5ZCIsInVzZXJfaWQiOjF9.dH2pzDoxYtyxoT4TmWnIIwjCWQXEXUbQBQthUyfOORQ";
 // final String _refreshToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYwMDU0MDc3NiwianRpIjoiMzEyMDY2ZWFiZmZkNGJlZjgyMDQ2ZmY1OGFmNGY1YmUiLCJ1c2VyX2lkIjoxfQ.L_rHsNAzuk4cE6s-uxVmaVl8sdjh9eh85vHt_O98mqM";

  Future<http.Response> getDashboardStatistics(int distributor) async {
    return http.post(
      "$CONTEXT_API_URL/analytics/",
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_accessToken",
        HttpHeaders.contentTypeHeader: "application/json"
      },
      body: jsonEncode({
        "distributor": distributor
      })
    );
  }

  Future<http.Response> getInvoices(int distributor) async {
    return http.post(
      "$CONTEXT_API_URL/invoices/",
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_accessToken",
        HttpHeaders.contentTypeHeader: "application/json"
      },
      body: jsonEncode({
        "distributor": distributor
      })
    );
  }

  Future<http.Response> getSalesmanTransactions(int distributor) async {
    return http.post(
      "$CONTEXT_API_URL/transactions/",
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_accessToken",
        HttpHeaders.contentTypeHeader: "application/json"
      },
      body: jsonEncode({
        "distributor": distributor
      })
    );
  }

  Future<http.Response> getInvoiceInfo(String invoiceID) async {
    return http.get(
      "$API_URL/distributors/invoices/info/$invoiceID/",
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_accessToken",
        HttpHeaders.contentTypeHeader: "application/json"
      }
    );
  }

  Future<http.Response> getProfileInfo() async {
    return http.post(
      "$API_URL/accounts/profile/",
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_accessToken",
        HttpHeaders.contentTypeHeader: "application/json"
      }
    );
  }

  Future<http.Response> getPaymentMethods(int distributor) async {
      return http.post(
        "$CONTEXT_API_URL/payments/",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $_accessToken",
          HttpHeaders.contentTypeHeader: "application/json"
        },
        body: jsonEncode({
          "distributor": distributor
        })
      );
  }

  Future<http.Response> updateInvoice(EditInvoiceModel invoice) {
    return http.post(
        "$CONTEXT_API_URL/sales/invoice/edit/",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $_accessToken",
          HttpHeaders.contentTypeHeader: "application/json"
        },
        body: jsonEncode({
          "invoice": invoice.invoice,
          "amount": invoice.amount,
          "deadline": invoice.deadline,
          "payment_mode": invoice.paymentMode
        })
      );
  }

  Future<http.Response> getSalesmanInventory(int distributor) {
    return http.post(
      "$CONTEXT_API_URL/inventory/",
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_accessToken",
        HttpHeaders.contentTypeHeader: "application/json"
      },
      body: jsonEncode({
        "distributor": distributor
      })
    );
  }

  Future<http.Response> getInventoryTypes(int distributor) {
    return http.post(
      "$CONTEXT_API_URL/categories/",
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_accessToken",
        HttpHeaders.contentTypeHeader: "application/json"
      },
      body: jsonEncode({
        "distributor": distributor
      })
    );
  }

  Future<http.Response> getAllTransactions(int distributor){
    return http.post(
      "$CONTEXT_API_URL/transactions/all/",
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_accessToken",
        HttpHeaders.contentTypeHeader: "application/json"
      },
      body: jsonEncode({
        "distributor": distributor
      })
    );
  }

  Future<http.Response> getAllRetailers(int distributor){
    return http.get(
      "$CONTEXT_API_URL/retailers/?distributor=$distributor",
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_accessToken",
        HttpHeaders.contentTypeHeader: "application/json"
      },
    );
  }

  Future<http.Response> createSale(int retailer, int distributor, int paymentMode, double amount, double paid, String deadline, List<Map<String, int>> state){
    return http.post(
      "$CONTEXT_API_URL/sales/create/",
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_accessToken",
        HttpHeaders.contentTypeHeader: "application/json"
      },
      body: jsonEncode({
        "retailer": retailer,
        "distributor": distributor,
        "total_amount": amount,
        "amount_paid": paid,
        "payment_mode": paymentMode,
        "deadline": deadline,
        "sales": state
      })
    );

  }

}