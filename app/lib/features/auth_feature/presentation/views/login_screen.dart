import 'package:app/features/auth_feature/presentation/views/register_screen.dart';
import 'package:app/features/home_feature/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../../../../cubits/chat_cubit/chat_cubit.dart';
import '../../../../helper/show_snackBar.dart';
import '../manager/auth_cubit/auth_cubit.dart';
import 'widgets/custom_button.dart';
import '../../../../widgets/custom_text_filed.dart';
import '../../../../pages/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'loginScreen';
  String? username;

  String? password;
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            isLoading = true;
          } else if (state is LoginSuccess) {
            //BlocProvider.of<ChatCubit>(context).getMessage();
            Navigator.pushNamed(
              context,
              HomeScreen.routeName,
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
                          'Sign In',
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
                      hintText: 'Username',
                      onChange: (String data) => username = data,
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
                      text: 'Sign In',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          // BlocProvider.of<AuthBloc>(context).add(
                          //   LoginEvent(
                          //     auth: auth,
                          //     email: email!,
                          //     password: password!,
                          //   ),
                          // );
                          BlocProvider.of<AuthCubit>(context).loginUser(
                            username!,
                            password!,
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
                              context,
                              RegisterScreen.routeName,
                            );
                          },
                          child: Text(
                            'Sign Up',
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
