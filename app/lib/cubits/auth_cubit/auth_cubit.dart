import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginUser() async {
    emit(LoginLoading());
    try {
      emit(LoginSuccess());
    } on Exception catch (ex) {
      emit(LoginFailure(errorMsg: 'please check the email and try again'));
    }
  }

  Future<void> registration(
    ) async {
    emit(RegisterLoading());
    try {

      emit(RegisterSuccess());
    } on Exception catch (ex) {

        emit(RegisterFailure(errorMsg: 'Weak password'));

    }
  }
}
