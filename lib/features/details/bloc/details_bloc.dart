import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:salesman/features/details/bloc/details_event.dart';
import 'package:salesman/features/details/bloc/details_state.dart';
import 'package:salesman/features/details/data/models/details_model.dart';
import 'package:salesman/features/details/data/repository/details_repository.dart';
import 'package:salesman/features/editinvoice/bloc/editinvoice_bloc.dart';

class InvoiceDetailsBloc extends Bloc<InvoiceInfoEvent, InvoiceInfoState> {
  final InvoiceInfoRepository invoiceInfoRepository;

  InvoiceDetailsBloc({ @required this.invoiceInfoRepository}) : assert(invoiceInfoRepository != null), super(InvoiceInfoInitialState());

  
  @override
  Stream<InvoiceInfoState> mapEventToState(InvoiceInfoEvent event) async* {
    if(event is LoadInvoiceInfo){
      yield InvoiceInfoLoadingState();
      try{
        InvoiceDetail invoiceInfo = await invoiceInfoRepository.getInvoiceInfo(event.invoiceID);
        
        yield InvoiceInfoSuccessState(
          invoiceInfo: invoiceInfo
        );
      }catch(error){
        yield InvoiceInfoErrorState(
          error: error.toString()
        );
      }
    }

    if(event is LoadInfoInitial){
      yield InvoiceInfoInitialState();
    }
  }

}