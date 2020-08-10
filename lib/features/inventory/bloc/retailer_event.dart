import 'package:equatable/equatable.dart';
import 'package:salesman/features/inventory/data/models/retailer.dart';

abstract class RetailerEvent extends Equatable {}

class LoadRetailersEvent extends RetailerEvent {

  final int distributor;

  LoadRetailersEvent(this.distributor);

  @override
  List<Object> get props => [distributor];

}

class SelectRetailerEvent extends RetailerEvent {

  final Retailer retailer;

  SelectRetailerEvent(this.retailer);

  @override
  List<Object> get props => [retailer];

}