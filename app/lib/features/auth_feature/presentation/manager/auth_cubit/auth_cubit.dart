import 'package:app/features/auth_feature/data/repos/auth_repo_implementation.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepositoryImplementation) : super(AuthInitial());
  final AuthRepositoryImplementation authRepositoryImplementation;

  Future<void> loginUser(
      String username,
      String password,
      ) async {
    emit(LoginLoading());
    try {

      final response = await authRepositoryImplementation.signIn(
        username,
        password,
      );

      // Save token to shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      response.fold(
            (failure) {
          emit(LoginFailure(errorMsg: 'Sign-in failed'));
        },
            (r) async {
          prefs.setString('accessToken', r.tokens.access);
          emit(LoginSuccess());
        },
      );
      print("HHHHHHHHHHHHHHHHHHHHHHHHH ${prefs.getString('accessToken')}");
    } catch (ex) {
      emit(LoginFailure(errorMsg: 'Something Went Wrong'));
    }
  }


  Future<void> registration(
      String username,
      String fName,
      String lName,
      String password,
      ) async {
    emit(RegisterLoading());
    try {
      final response = await authRepositoryImplementation.signUp(
        username,
        fName,
        lName,
        password,
      );

      // Save token to shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      response.fold(
            (failure) {
          emit(RegisterFailure(errorMsg: 'Sign-up failed'));
        },
            (r) async {
          prefs.setString('accessToken', r.tokens.access);
          emit(RegisterSuccess());
        },
      );
    } catch (ex) {
      emit(RegisterFailure(errorMsg: 'Something Went Wrong'));
    }
  }

  Future<void> logoutUser() async {
    emit(LogoutLoading());
    try {
      // Clear token from shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('accessToken');

      emit(LogoutSuccess());
    } on Exception catch (ex) {
      emit(LogoutFailure(errorMsg: 'Something Went Wrong'));
    }
  }

}
