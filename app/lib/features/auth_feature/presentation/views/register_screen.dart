import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants.dart';
import '../../../../helper/show_snackBar.dart';
import '../manager/auth_cubit/auth_cubit.dart';
import 'widgets/custom_button.dart';
import '../../../../widgets/custom_text_filed.dart';
import 'login_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = '/register-screen';

  RegisterScreen({super.key});

  String? username;
  String? fName;
  String? lName;
  String? password;
  String? retypePassword;

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
                    height: 200,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormFiled(
                    hintText: 'Username',
                    onChange: (data) => username = data,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormFiled(
                    hintText: 'First Name',
                    onChange: (data) => fName = data,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormFiled(
                    hintText: 'Last Name',
                    onChange: (data) => lName = data,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormFiled(
                    hintText: 'Password',
                    onChange: (data) => password = data,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormFiled(
                    hintText: 'Retype Password',
                    onChange: (data) => retypePassword = data,
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: 'Sign Up',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        if (password == retypePassword) {
                          BlocProvider.of<AuthCubit>(context).registration(
                            username!,
                            fName!,
                            lName!,
                            password!,
                          );
                        } else {
                          showSnackBar(context, "Passwords don't match", Colors.red);
                        }
                      }
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
                          'Sign In',
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
