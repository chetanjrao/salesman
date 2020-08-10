import 'package:equatable/equatable.dart';
import 'package:salesman/features/editinvoice/data/models/edit_invoice_models.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitialState extends PaymentState {}

class PaymentLoadingState extends PaymentState {}

class PaymentSuccessState extends PaymentState {

  final List<PaymentMethod> payments;
  final PaymentMethod selectedPayment;

  PaymentSuccessState(this.payments, this.selectedPayment);

  @override
  List<Object> get props => [ payments, selectedPayment ];

}