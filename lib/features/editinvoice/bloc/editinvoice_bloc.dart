import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:salesman/features/editinvoice/bloc/editinvoice_event.dart';
import 'package:salesman/features/editinvoice/bloc/editinvoice_state.dart';
import 'package:salesman/features/editinvoice/data/models/edit_invoice_models.dart';
import 'package:salesman/features/editinvoice/data/repository/edit_invoice_repository.dart';

class EditInvoiceBloc extends Bloc<EditInvoiceEvent, EditInvoiceState> {

  final EditInvoiceRepository editInvoiceRepository;

  EditInvoiceBloc({
    @required this.editInvoiceRepository
  }) : assert( editInvoiceRepository != null ), super(EditInvoiceInitialState());


  @override
  Stream<EditInvoiceState> mapEventToState(EditInvoiceEvent event) async* {
    if(event is LoadPaymentmethods ){
      yield EditInvoiceLoadingState();
      try {
        List<PaymentMethod> methods = await editInvoiceRepository.getPaymentMethods(event.distributor);
        yield EditInvoiceSuccessState(
          methods: methods
        );
      } catch(error){
        yield EditInvoiceErrorState(error: error.toString());
      }
    }

    if(event is UploadEditInvoice){
      yield EditInvoiceUploadLoadingState();
      try {
        EditInvoiceMessage message = await editInvoiceRepository.editInvoice(event.model);
        yield EditInvoiceUploadSuccessState(message: message);
      } catch(error){
        yield EditInvoiceUploadErrorState(error: error.toString());
      }
    }
  }

}