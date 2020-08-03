import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:salesman/features/editinvoice/data/models/edit_invoice_models.dart';

abstract class EditInvoiceEvent extends Equatable {
  const EditInvoiceEvent();
}

class LoadInitialEvent extends EditInvoiceEvent {
  const LoadInitialEvent();
  
  @override
  List<Object> get props => [];
}

class LoadPaymentmethods extends EditInvoiceEvent{
  final int distributor;

  const LoadPaymentmethods({
    @required this.distributor
  });

  @override
  List<Object> get props => [distributor];

}

class UploadEditInvoice extends EditInvoiceEvent{
  final EditInvoiceModel model;

  const UploadEditInvoice({
    @required this.model
  });

  @override
  List<Object> get props => [model];

}