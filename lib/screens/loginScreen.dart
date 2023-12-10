import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebasiclook/bloc/auth/auth_bloc.dart';
import 'package:thebasiclook/constants.dart';
import 'package:thebasiclook/screens/Home.dart';
import 'package:thebasiclook/screens/productsScreen.dart';
import 'package:thebasiclook/screens/registerScreen.dart';
import 'package:thebasiclook/services/auth.dart';
import 'package:thebasiclook/services/savingUserData.dart';
import 'package:thebasiclook/widgets/customTextForm.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isLoggingIn = false; // Track whether login is in progress

  final AuthBloc authBloc = AuthBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 69, 69, 69),
      body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
              hint: 'Email',
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return 'Please enter a valid Email';
                }
                return null;
              },
            ),
            CustomTextFormField(
              hint: 'Password',
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 6) {
                  return 'Please enter a valid password';
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            BlocConsumer<AuthBloc, AuthState>(
              bloc: authBloc,
              listener: (context, state) {
                if (state is LoginSuccessState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Welcome')));
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                }
                if (state is LoginFailureState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.err)));
                }
              },
              builder: (context, state) {
                if (state is LoginLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is LoginSuccessState) {
                  return AuthContainer();
                }

                return GestureDetector(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        authBloc.add(LoginEvent(
                          email: emailController.text,
                          password: passwordController.text,
                        ));
                      }
                    },
                    child: AuthContainer());
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don\'t have an account? ",
                  style: TextStyle(fontSize: 15),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return RegisterScreen();
                    }));
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AuthContainer extends StatelessWidget {
  const AuthContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * .07,
        width: MediaQuery.of(context).size.width * .8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black,
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ));
  }
}
