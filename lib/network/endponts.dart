import 'package:navgiator/network/dio_client.dart';

enum Endpoints{
  login
}


extension EndPointData on Endpoints{

  String path(){
   String path = "";
    switch(this){
     case Endpoints.login :
        path = "api/login";
   }
   return path;
}

  ReqType type(){
    ReqType type;
    switch(this){
      case Endpoints.login :
        type = ReqType.POST;
    }
    return type;
  }

}