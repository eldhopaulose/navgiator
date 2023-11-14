import 'package:dio/dio.dart';
import 'package:navgiator/home_details_model.dart';
import 'package:navgiator/usermodel.dart';

import '../loginresponsemode.dart';
import 'dio_client.dart';
import 'endponts.dart';

class AuthRepo {
  final DioClient dioClient = DioClient(Dio());
  Future<LoginResponseModel?> loginRequest(UserModel loginRequest) async {
    try {
      final response = await dioClient.post(
          endpoints: Endpoints.login, data: loginRequest.toJson());
      if (response.statusCode == 200) {
        final loginResponse = LoginResponseModel.fromJson(response.data);
        if (loginResponse.token != null) {
          return loginResponse;
        } else {
          return null;
        }
      } else {
        final loginResponse = LoginResponseModel.fromJson(response.data);
        if (response.statusCode == 400) {
          return loginResponse;
        }
        ;
      }
      // return response.data.toString();
    } on DioException catch (e) {
      print(e);
      if (e.response?.data != null) {
        final errResp = LoginResponseModel.fromJson(e.response!.data);
        return errResp;
        // if (errResp.error != null) {
        //   // code for snackbar
        //   return null;
        // } else {
        //   return e.toString();
        // }
      }

      return null;
    }
  }

  Future<HomeDetailsModel?> userResponse() async {
    try {
     // final response = await dioClient.post(endpoints: Endpoints.home,headers: {"X-Api-Key": "ihasidjsad"});
      final response = await dioClient.post(endpoints: Endpoints.home);
      if (response.statusCode == 200) {
        final homeResponse = HomeDetailsModel.fromJson(response.data);
        if (homeResponse.data != null) {
          return homeResponse;
        } else {
          return null;
        }
      } else {
        final homeResponse = HomeDetailsModel.fromJson(response.data);
        if (response.statusCode == 400) {
          return homeResponse;
        }
        ;
      }
      // return response.data.toString();
    } on DioException catch (e) {
      if (e.response!.data != null) {
        final homeResponse = HomeDetailsModel.fromJson(e.response!.data);
        return homeResponse;
      }
    }
    return null;
  }
}
