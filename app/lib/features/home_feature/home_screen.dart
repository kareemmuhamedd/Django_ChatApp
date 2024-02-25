import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_feature/presentation/manager/auth_cubit/auth_cubit.dart';
import '../auth_feature/presentation/views/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LogoutLoading) {

          } else if (state is LogoutSuccess) {

            Navigator.pushNamed(
              context,
              LoginScreen.routeName,
            );

          } else if (state is LoginFailure) {

          }
        },
        builder: (context, state) => Scaffold(

          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
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

                const SizedBox(
                  height: 10,
                ),

                const SizedBox(
                  height: 10,
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
                        BlocProvider.of<AuthCubit>(context).logoutUser();
                      },
                      child: Text(
                        'logout',
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
    );
  }
}
