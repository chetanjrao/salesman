
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:salesman/features/invoices/data/models/invoice_model.dart';

abstract class InvoiceState extends Equatable {

  const InvoiceState();

  @override
  List<Object> get props => [];

}

class InvoiceInitialState extends InvoiceState {}

class InvoiceLoadingState extends InvoiceState {}

class InvoiceLoadedState extends InvoiceState {
  final List<SingleInvoice> invoices;

  const InvoiceLoadedState({
    @required this.invoices
  });

  @override
  List<Object> get props => [invoices];

}

class InvoicesErrorState extends InvoiceState {
  final String error;

  const InvoicesErrorState({
    @required this.error
  });
  
  @override
  String toString() => "Error loading dashboard $error";

}