import 'package:flutter/material.dart';
import 'package:navgiator/network/auth_repo.dart';
import 'package:navgiator/network/dio_client.dart';
import 'package:navgiator/home-page.dart';
import 'package:navgiator/loginresponsemode.dart';
import 'package:navgiator/network/endponts.dart';
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
                        AuthRepo repo = AuthRepo();
                        final response = await repo.loginRequest(UserModel(
                          email: emailController.text,
                          password: passwordController.text
                        ));

                        if(response != null && response.error == null){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(
                                pin: response.toString(),
                              ),
                            ),
                          );
                        }else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(response!.error.toString()))
                          );
                        }

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
