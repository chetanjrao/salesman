import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:salesman/features/profile/bloc/profile_event.dart';
import 'package:salesman/features/profile/bloc/profile_state.dart';
import 'package:salesman/features/profile/data/models/profile_model.dart';
import 'package:salesman/features/profile/data/respository/profile_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{

  final ProfileRepository profileRepository;

  ProfileBloc({
    @required this.profileRepository
  }) : assert(profileRepository != null), super(ProfileInitialState());


  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if(event is LoadProfile){
      yield ProfileLoadingState();
      try{
        ProfileModel profile = await profileRepository.getProfileInfo();
        yield ProfileSuccessState(profileModel: profile);
      }catch(error){
        yield ProfileErrorState(
          error: error.toString()
        );
      }
    }
  }

}