import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {}

class LoadProfile extends ProfileEvent {

  @override
  List<Object> get props => [];

}