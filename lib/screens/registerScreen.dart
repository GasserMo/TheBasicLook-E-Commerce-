import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thebasiclook/bloc/auth/auth_bloc.dart';
import 'package:thebasiclook/screens/Home.dart';
import 'package:thebasiclook/screens/loginScreen.dart';
import 'package:thebasiclook/services/auth.dart';
import 'package:thebasiclook/widgets/customTextForm.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onTapOutside() {}
  final AuthBloc authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 69, 69, 69),
      body: Form(
        key: _key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
              hint: 'Name',
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Name';
                }
                return null;
              },
            ),
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
                if (state is RegisterSuccessState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('User Registered Successfully, please log in')));
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                }
                if (state is RegisterFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.err)));
                }
              },
              builder: (context, state) {
                  if (state is RegisterLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is RegisterSuccessState) {
                  return AuthContainerr();
                }
                    return GestureDetector(
                        onTap: () async {
                          if (_key.currentState!.validate()) {
                            authBloc.add(RegisterEvent(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            ));
                          }
                        },
                        child: AuthContainerr());

                  
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(fontSize: 15),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  },
                  child: const Text(
                    'Sign in',
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
class AuthContainerr extends StatelessWidget {
  const AuthContainerr({
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
          'Sign up',
          style: TextStyle(color: Colors.white),
        ));
  }
}
