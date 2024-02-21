import 'package:app/features/auth_feature/data/repos/auth_repo_implementation.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
      authRepositoryImplementation.signIn(
        username,
        password,
      );
      emit(LoginSuccess());
    } on Exception catch (ex) {
      emit(LoginFailure(errorMsg: 'Something Want Wrong'));
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
      authRepositoryImplementation.signUp(
        username,
        fName,
        lName,
        password,
      );
      emit(RegisterSuccess());
    } on Exception catch (ex) {
      emit(LoginFailure(errorMsg: 'Something Want Wrong'));
    }
  }
}
