import 'package:app/features/auth_feature/presentation/views/login_screen.dart';
import 'package:app/features/auth_feature/presentation/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth_feature/presentation/manager/auth_cubit/auth_cubit.dart';

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
