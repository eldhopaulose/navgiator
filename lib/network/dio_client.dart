import 'package:dio/dio.dart';
import 'package:navgiator/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'endponts.dart';

class DioClient{

  DioClient(this._dio){
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
  }
  final Dio _dio;

  Future<dynamic> post({required Endpoints endpoints, Map<String,dynamic>? data , Map<String,dynamic>? headers , }) async{
    Response response;
    if(headers != null){
      _dio.options.headers.addAll(headers);

    }
    try{
      switch (endpoints.type()) {
        case ReqType.GET:
          response = await _dio.get("$baseUrl/${endpoints.path()}", queryParameters: data ,);
          break;
        case ReqType.POST:
          response = await _dio.post("$baseUrl/${endpoints.path()}", data: data);
          break;
        case ReqType.PUT:
          response = await _dio.put("$baseUrl/${endpoints.path()}", data: data);
          break;
      }
    }on DioException catch (e){
      if(e.response != null) {
        response = e.response!;
      }else{
        switch(e.type){
          case DioExceptionType.receiveTimeout :
            response = Response(requestOptions: e.requestOptions,statusMessage: "Received time out",statusCode: 700);
          default : response = Response(requestOptions: e.requestOptions,statusMessage: "Some error happened",statusCode: 800);
        }

      }
    }

    return response;
  }


}

enum ReqType{
  GET,
  POST,
  PUT
}