import 'package:attendance_employee/HomePage.dart';
import 'package:attendance_employee/ui/login/controller/LoginRepository.dart';
import 'package:attendance_employee/utility/MyStatus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Components/Colors.dart';
import '../../../Components/MainComponents.dart';

class LoginController extends StatelessWidget {
  const LoginController({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LoginRepository(),
      child: Consumer(
        builder: (context, LoginRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return Login();
            case Status.Unauthenticated:
              return Login();
            case Status.Authenticating:
              return Login();
            case Status.Authenticated:
              return Login();
            case Status.error:
              return Login();
          }
        },
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController username_control = TextEditingController();
  TextEditingController password_control = TextEditingController();
  bool isPasswordVisible = false;

  // void HomePages() {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => HomePage()));
  // }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<LoginRepository>();
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                )),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    MainComponents().txtview28("Welcome Back"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            children: [
                              MainComponents().Textfields(
                                  "username",
                                  username_control,
                                  "Enter Username",
                                  Icons.person),
                              const SizedBox(
                                height: 10,
                              ),
                              MainComponents().Textfields(
                                  "password",
                                  password_control,
                                  "Enter Password",
                                  Icons.lock,
                                  isPasswordVisible: isPasswordVisible,
                                  isPassword: true, passwordToggle: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              }),
                              const SizedBox(
                                height: 10,
                              ),
                              MainComponents().Button("Login", () {
                                auth.login(context, username_control.text,
                                    password_control.text);
                              }, blue)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
