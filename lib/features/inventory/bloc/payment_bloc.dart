import 'package:bloc/bloc.dart';
import 'package:salesman/features/editinvoice/data/models/edit_invoice_models.dart';
import 'package:salesman/features/inventory/bloc/payment_event.dart';
import 'package:salesman/features/inventory/bloc/payment_state.dart';
import 'package:salesman/features/inventory/bloc/retailer_event.dart';
import 'package:salesman/features/inventory/bloc/retailer_state.dart';
import 'package:salesman/features/inventory/data/models/retailer.dart';
import 'package:salesman/features/inventory/data/respository/inventory.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState>{

  final InventoryRepository inventoryRepository;

  PaymentBloc(this.inventoryRepository): assert(inventoryRepository != null), super(PaymentInitialState());

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    if(event is LoadPaymentmethods){
      try {
        yield PaymentLoadingState();
        List<PaymentMethod> payments = await inventoryRepository.getPaymentMethods(event.distributor);
        yield PaymentSuccessState(
          payments,
          payments[0]
        );
      } catch(error){
        print(error);
      }
    }
    if(event is SelectPaymentEvent){
      List<PaymentMethod> retailers = List<PaymentMethod>.from((state as PaymentSuccessState).payments);
      yield PaymentSuccessState(
        retailers,
        event.payment
      );
    }
  }

}