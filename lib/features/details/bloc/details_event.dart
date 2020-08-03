import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class InvoiceInfoEvent extends Equatable {

  const InvoiceInfoEvent();

}

class LoadInfoInitial extends InvoiceInfoEvent {
  const LoadInfoInitial();

  @override
  List<Object> get props => [];
}

class LoadInvoiceInfo extends InvoiceInfoEvent {

  final String invoiceID;

  const LoadInvoiceInfo({
    @required this.invoiceID
  });

  @override
  List<Object> get props => [ invoiceID ];

}