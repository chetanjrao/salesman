import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:salesman/features/editinvoice/data/models/edit_invoice_models.dart';

abstract class PaymentEvent extends Equatable {
  
}

class LoadPaymentmethods extends PaymentEvent{
  final int distributor;

  LoadPaymentmethods({
    @required this.distributor
  });

  @override
  List<Object> get props => [distributor];

}

class SelectPaymentEvent extends PaymentEvent {

  final PaymentMethod payment;

  SelectPaymentEvent(this.payment);

  @override
  List<Object> get props => [payment];

}