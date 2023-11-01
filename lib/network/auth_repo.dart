import 'package:dio/dio.dart';
import 'package:navgiator/usermodel.dart';

import '../loginresponsemode.dart';
import 'dio_client.dart';
import 'endponts.dart';

class AuthRepo {
  final DioClient dioClient = DioClient(Dio());
  Future<String?> loginRequest(UserModel loginRequest) async {

    try {

      final response = await dioClient.post(
          endpoints: Endpoints.login,
          data: loginRequest.toJson());
      if (response.statusCode == 200) {
        final loginResponse = LoginResponseModel.fromJson(response.data);
        if (loginResponse.token != null) {
          return loginResponse.token!;
        } else {
          return null;
        }
      } else {
        return null;
      }
      // return response.data.toString();
    } on DioException catch (e) {
      print(e);
      if (e.response?.data != null) {
        final errResp = LoginResponseModel.fromJson(e.response!.data);
        if (errResp.error != null) {
          // code for snackbar
          return null;
        } else {
          return e.toString();
        }
      }

      return e.toString();
    }
  }
}