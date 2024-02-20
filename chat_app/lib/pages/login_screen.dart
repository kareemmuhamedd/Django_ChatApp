
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/pages/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../blocs/auth/auth_bloc.dart';
import '../constants.dart';
import '../helper/show_snackBar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_filed.dart';
import 'chat_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'loginScreen';
  String? email;

  String? password;
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            isLoading = true;
          } else if (state is LoginSuccess) {
            BlocProvider.of<ChatCubit>(context).getMessage();
            Navigator.pushNamed(
              context,
              ChatScreen.routeName,
              arguments: email,
            );
            isLoading = false;
          } else if (state is LoginFailure) {
            showSnackBar(context, state.errorMsg, Colors.red);
            isLoading = false;
          }
        },
        builder: (context, state) => ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    Image.asset(
                      'assets/images/loginIcon.png',
                      color: Colors.blueGrey[300],
                      scale: 0.8,
                      height: 300,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormFiled(
                      hintText: 'Email',
                      onChange: (String data) => email = data,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormFiled(
                      hintText: 'Password',
                      onChange: (String data) => password = data,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      text: 'Login',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(
                            LoginEvent(
                              auth: auth,
                              email: email!,
                              password: password!,
                            ),
                          );
                        } else {}
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, RegisterScreen.routeName);
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.blueGrey[300]),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
