import 'dart:convert';

import 'package:http/http.dart';
import 'package:salesman/features/api/instantkhata_client.dart';
import 'package:salesman/features/profile/data/models/profile_model.dart';

class ProfileRepository {

  InstantKhataClient _apiClient = new InstantKhataClient();

  Future<ProfileModel> getProfileInfo() async {
    Response response = await _apiClient.getProfileInfo();
    dynamic jsonData = jsonDecode(response.body);
    ProfileModel profile = ProfileModel.fromJson(jsonData);
    return profile;
  }

}