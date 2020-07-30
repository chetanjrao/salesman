import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:salesman/features/details/data/models/details_model.dart';

abstract class InvoiceInfoState extends Equatable {

  const InvoiceInfoState();

  @override
  List<Object> get props => [];

}

class InvoiceInfoInitialState extends InvoiceInfoState{}

class InvoiceInfoLoadingState extends InvoiceInfoState{}

class InvoiceInfoSuccessState extends InvoiceInfoState{

  final InvoiceDetail invoiceInfo;

  const InvoiceInfoSuccessState({
    @required this.invoiceInfo
  });

  @override
  List<Object> get props => [ invoiceInfo ];

}

class InvoiceInfoErrorState extends InvoiceInfoState {
  final String error;

  const InvoiceInfoErrorState({
    @required this.error
  });

  @override
  String toString() => "Error loading invoice info $error";

}