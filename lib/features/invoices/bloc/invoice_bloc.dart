import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:salesman/features/invoices/bloc/invoice_events.dart';
import 'package:salesman/features/invoices/bloc/invoice_state.dart';
import 'package:salesman/features/invoices/data/models/invoice_model.dart';
import 'package:salesman/features/invoices/data/repository/invoice_repository.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {

  InvoiceRepository invoiceRepository;

  InvoiceBloc({
    @required this.invoiceRepository
  })  :assert( invoiceRepository != null ), super(InvoiceInitialState());

  
  @override
  Stream<InvoiceState> mapEventToState(InvoiceEvent event) async* {
    if(event is LoadInvoicesEvent){
      yield InvoiceLoadingState();
      try{
        List<SingleInvoice> invoices = await invoiceRepository.getInvoices();
        yield InvoiceLoadedState(
          invoices: invoices
        );
      } catch(error){
        yield InvoicesErrorState(
          error: error.toString()
        );
      }
    }
  }

}