import 'package:equatable/equatable.dart';

abstract class TransactionsEvent extends Equatable {
  
  TransactionsEvent();
}

class LoadAllTransactions extends TransactionsEvent {
  
  final int distributor;

  LoadAllTransactions(this.distributor);

  @override
  List<Object> get props => [ distributor ];
}