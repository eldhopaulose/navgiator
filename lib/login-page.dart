import 'package:flutter/material.dart';
import 'package:navgiator/dio_client.dart';
import 'package:navgiator/home-page.dart';
import 'package:navgiator/loginresponsemode.dart';
import 'package:navgiator/otp-page.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:navgiator/usermodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  final DioClient dioClient= DioClient(Dio());
  Future<String?> request() async {
    // final dio = Dio()
    //   ..interceptors.add(PrettyDioLogger(
    //     requestHeader: true,
    //     requestBody: true,
    //     responseBody: true,
    //     responseHeader: false,
    //     compact: false,
    //   ));
    try {
      final UserModel userModel = UserModel(
        email: emailController.text,
        password: passwordController.text,
      );
      final response  = await dioClient.post(requestMode: ReqType.POST, path: 'api/login', data: userModel.toJson());
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
      if(e.response?.data != null){
        final errResp = LoginResponseModel.fromJson(e.response!.data);
        if(errResp.error != null) {
          // code for snackbar
          return null;
        }else{
          return e.toString();
        }
      }

      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                       final response = await request();
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => HomePage(
                             pin: response ?? "",
                           ),
                         ),
                       );
                        // final val = await Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const OtpPage()),
                        // );
                        // print(val);
                        // if (val != null) {
                        //   // ignore: use_build_context_synchronously
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => HomePage(
                        //         pin: val,
                        //       ),
                        //     ),
                        //   );
                        // }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
