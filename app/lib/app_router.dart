import 'package:app/cubits/auth_cubit/auth_cubit.dart';
import 'package:app/pages/login_screen.dart';
import 'package:app/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/' || LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
          child: LoginScreen(),
        ),
      );

    case RegisterScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => AuthCubit(),
          child: RegisterScreen(),
        ),
      );
  }
  return null;
}
