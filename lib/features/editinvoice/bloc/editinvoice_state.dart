import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:salesman/features/editinvoice/data/models/edit_invoice_models.dart';

abstract class EditInvoiceState extends Equatable {

  const EditInvoiceState();

  @override
  List<Object> get props => [];

}

class EditInvoiceInitialState extends EditInvoiceState {}

class EditInvoiceLoadingState extends EditInvoiceState {}

class EditInvoiceUploadState extends EditInvoiceState {



}

class EditInvoiceUploadLoadingState extends EditInvoiceState {
  
}

class EditInvoiceUploadSuccessState extends EditInvoiceState {

  final EditInvoiceMessage message;

  const EditInvoiceUploadSuccessState({
    @required this.message
  });

  @override
  List<Object> get props => [message];

}

class EditInvoiceUploadErrorState extends EditInvoiceState {
  final String error;

  const EditInvoiceUploadErrorState({
    @required this.error
  });

  @override
  String toString() => "Error updating invoice $error";
}

class EditInvoiceSuccessState extends EditInvoiceState {
  final List<PaymentMethod> methods;

  const EditInvoiceSuccessState({
    @required this.methods
  });

  @override
  List<Object> get props => [methods];

}

class EditInvoiceErrorState extends EditInvoiceState {

  final String error;

  const EditInvoiceErrorState({
    @required this.error
  });

  @override
  String toString() => "Error loading payment methods $error";

}