import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth_feature/data/repos/auth_repo_implementation.dart';
import 'features/auth_feature/data/web_services/auth_services.dart';
import 'features/auth_feature/presentation/views/login_screen.dart';
import 'features/auth_feature/presentation/views/register_screen.dart';
import 'features/home_feature/home_screen.dart';
import 'features/auth_feature/presentation/manager/auth_cubit/auth_cubit.dart';

Future<bool> isLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('accessToken') != null;
}

Route? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (_) => FutureBuilder<bool>(
          future: isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              ); // You can return a loading indicator here if needed
            } else {
              if (snapshot.hasData && snapshot.data!) {
                return BlocProvider<AuthCubit>(
                  create: (context) => AuthCubit(
                    AuthRepositoryImplementation(
                      AuthServices(),
                    ),
                  ),
                  child: const HomeScreen(),
                );
              } else {
                return BlocProvider<AuthCubit>(
                  create: (context) => AuthCubit(
                    AuthRepositoryImplementation(
                      AuthServices(),
                    ),
                  ),
                  child: LoginScreen(),
                );
              }
            }
          },
        ),
      );
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            AuthRepositoryImplementation(
              AuthServices(),
            ),
          ),
          child: LoginScreen(),
        ),
      );
    case RegisterScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => AuthCubit(
            AuthRepositoryImplementation(
              AuthServices(),
            ),
          ),
          child: RegisterScreen(),
        ),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => AuthCubit(
            AuthRepositoryImplementation(
              AuthServices(),
            ),
          ),
          child: HomeScreen(), // Removed const
        ),
      );
  }
  return null;
}
