// import 'package:bloc/bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:meta/meta.dart';
//
// part 'auth_state.dart';
//
// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(AuthInitial());
//
//   Future<void> loginUser(
//       FirebaseAuth auth, {
//         required String email,
//         required String password,
//       }) async {
//     emit(LoginLoading());
//     try {
//       await auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       emit(LoginSuccess());
//     } on FirebaseAuthException catch (ex) {
//       if (ex.code == 'user-not-found') {
//         emit(LoginFailure(errorMsg: 'please check the email and try again'));
//       } else if (ex.code == 'wrong-password') {
//         emit(LoginFailure(errorMsg: 'please check the password and try again'));
//       }
//     } on Exception catch (e) {
//       emit(LoginFailure(errorMsg: 'Something went wrong'));
//     }
//   }
//
//
//   Future<void> registration(
//       FirebaseAuth auth, {
//         required String email,
//         required String password,
//       }) async {
//     emit(RegisterLoading());
//     try {
//       await auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       emit(RegisterSuccess());
//     } on FirebaseAuthException catch (ex) {
//       if (ex.code == 'weak-password') {
//         emit(RegisterFailure(errorMsg: 'Weak password'));
//       } else if (ex.code == 'email-already-in-use') {
//         emit(RegisterFailure(
//             errorMsg:
//             'The email is already using before, pleas try another email'));
//       }
//     } on Exception catch (e) {
//       emit(RegisterFailure(errorMsg: 'Something went wrong'));
//     }
//   }
//
//
// }
