import 'package:navgiator/network/dio_client.dart';

enum Endpoints { login, home }

extension EndPointData on Endpoints {
  String path() {
    String path = "";
    switch (this) {
      case Endpoints.login:
        path = "api/login";
      case Endpoints.home:
        path = "api/users?page=2";
    }
    return path;
  }

  ReqType type() {
    ReqType type;
    switch (this) {
      case Endpoints.login:
        type = ReqType.POST;
      case Endpoints.home:
        type = ReqType.GET;
    }
    return type;
  }
}
