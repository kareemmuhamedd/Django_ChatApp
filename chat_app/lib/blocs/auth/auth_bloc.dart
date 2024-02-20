import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      /// login Event
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          await event.auth.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(LoginSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'user-not-found') {
            emit(
                LoginFailure(errorMsg: 'please check the email and try again'));
          } else if (ex.code == 'wrong-password') {
            emit(LoginFailure(
                errorMsg: 'please check the password and try again'));
          } else {
            emit(
              LoginFailure(errorMsg: 'Please enter a correct email format'),
            );
          }
        } on Exception catch (e) {
          emit(LoginFailure(errorMsg: 'Something went wrong'));
        }
      }

      /// register Event
      else if (event is RegisterEvent) {
        emit(RegisterLoading());
        try {
          await event.auth.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'weak-password') {
            emit(RegisterFailure(errorMsg: 'Weak password'));
          } else if (ex.code == 'email-already-in-use') {
            emit(
              RegisterFailure(
                  errorMsg:
                      'The email is already using before, pleas try another email'),
            );
          } else {
            emit(
              RegisterFailure(errorMsg: 'Please enter a correct email format'),
            );
          }
        } on Exception catch (e) {
          emit(RegisterFailure(errorMsg: 'Something went wrong'));
        }
      }
    });
  }
}
