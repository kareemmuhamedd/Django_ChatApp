import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, dynamic>> signIn(
    String username,
    String password,
  );

  Future<Either<Failure, dynamic>> signUp(
    String username,
    String fName,
    String lName,
    String password,
  );
}
