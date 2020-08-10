import 'package:equatable/equatable.dart';
import 'package:salesman/features/inventory/data/models/retailer.dart';

abstract class RetailerState extends Equatable {
  const RetailerState();

  @override
  List<Object> get props => [];
}

class RetailerInitialState extends RetailerState {}

class RetailerLoadingState extends RetailerState {}

class RetailerSuccessState extends RetailerState {

  final List<Retailer> retailers;
  final Retailer selectedRetailer;

  RetailerSuccessState(this.retailers, this.selectedRetailer);

  @override
  List<Object> get props => [ retailers, selectedRetailer ];

}