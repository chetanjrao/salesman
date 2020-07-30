import 'package:flutter/material.dart';

class ProfileModel {
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final String image;

  const ProfileModel({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.mobile,
    @required this.image,
  });

  static ProfileModel fromJson(dynamic json){
    return ProfileModel(
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      mobile: '+91${json["mobile"]}',
      image: json["image"]
    );
  }
}