part of 'package:navgiator/bloc/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late ProgressDialog progressDialog;


  @override
  void initState() {
    super.initState();
    progressDialog = ProgressDialog(context: context);

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: loginListener,
      child: Scaffold(
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
                        onPressed: () {
                          context.read<LoginBloc>().add(_OnLoginClicked(
                              email: emailController.text,
                              pass: passwordController.text));
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
      ),
    );
  }

  loginListener(BuildContext context, LoginState state) {
    if (state is _Loading) {
      progressDialog.show(msg: "Logging in");
    } else {
      progressDialog.close();
      if (state is _LoginSuccess) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Provider(
                    create: (_) => HomeBloc(),
                    child: const HomePage(),
                  )),
        );
      } else if (state is _LoginFail) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.error)));
      }
    }
  }
}
