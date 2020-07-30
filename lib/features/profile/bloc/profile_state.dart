import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:salesman/features/profile/data/models/profile_model.dart';

abstract class ProfileState extends Equatable {

  const ProfileState();

  @override
  List<Object> get props => [];

}

class ProfileInitialState extends ProfileState {

}

class ProfileLoadingState extends ProfileState {

}

class ProfileSuccessState extends ProfileState {
  final ProfileModel profileModel;

  const ProfileSuccessState({
    @required this.profileModel
  });

  @override
  List<Object> get props => [profileModel];
}

class ProfileErrorState extends ProfileState {
  final String error;

  const ProfileErrorState({
    @required this.error
  });

  @override
  String toString() => "Error loading profile";

}