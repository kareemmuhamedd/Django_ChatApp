import 'package:app/cubits/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';
import '../helper/show_snackBar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_filed.dart';
import 'login_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = '/register-screen';

  RegisterScreen({super.key});

  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            isLoading = true;
          } else if (state is RegisterSuccess) {
            // Navigator.pushNamed(
            //   context,
            //   ChatScreen.routeName,
            //   arguments: email,
            // );
            isLoading = false;
          } else if (state is RegisterFailure) {
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
                child: ListView(children: [
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
                        'REGISTER',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormFiled(
                      hintText: 'email', onChange: (data) => email = data),
                  const SizedBox(height: 10),
                  CustomTextFormFiled(
                    hintText: 'Password',
                    onChange: (data) => password = data,
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: 'Register',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthCubit>(context).registration();
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
                        'already have an account ?',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            LoginScreen.routeName,
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.blueGrey[300]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
