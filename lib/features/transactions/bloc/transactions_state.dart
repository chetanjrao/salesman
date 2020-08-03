import 'package:equatable/equatable.dart';
import 'package:salesman/features/transactions/data/models/transactions.dart';

abstract class TransactionsState extends Equatable {

  const TransactionsState();
  
  @override
  List<Object> get props => [];

}

class TransactionsInitialState extends TransactionsState {

}

class TransactionsLoadingState extends TransactionsState {
  
}

class TransactionsSuccessState extends TransactionsState {
  final List<TransactionModel> transactions;

  const TransactionsSuccessState(this.transactions);

  @override
    List<Object> get props => [ transactions ];
  
}

class TransactionsErrorState extends TransactionsState {
  final String error;

  const TransactionsErrorState(this.error);

  @override
  String toString() => "Error loading transactions $error";

}