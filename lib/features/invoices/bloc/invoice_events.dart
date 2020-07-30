import 'package:equatable/equatable.dart';

abstract class InvoiceEvent extends Equatable {
  const InvoiceEvent();
}

class LoadInvoicesEvent extends InvoiceEvent {

  const LoadInvoicesEvent();

  @override
  List<Object> get props => [];
  
}