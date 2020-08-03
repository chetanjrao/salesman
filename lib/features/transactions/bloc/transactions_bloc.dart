import 'package:bloc/bloc.dart';
import 'package:salesman/features/transactions/bloc/transactions_event.dart';
import 'package:salesman/features/transactions/bloc/transactions_state.dart';
import 'package:salesman/features/transactions/data/models/transactions.dart';
import 'package:salesman/features/transactions/data/respoitory/transactions.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {

  final TransactionRepository transactionRepository;

  TransactionsBloc(this.transactionRepository): super(TransactionsInitialState());
  

  @override
  Stream<TransactionsState> mapEventToState(TransactionsEvent event) async* {
    if(event is LoadAllTransactions){
      yield TransactionsLoadingState();
      try{
        List<TransactionModel> transactions = await transactionRepository.getAllTrnsactions(event.distributor);
        yield TransactionsSuccessState(transactions);
      }catch(error){
        yield TransactionsErrorState(
          error.toString()
        );
      }
    }
  }

}