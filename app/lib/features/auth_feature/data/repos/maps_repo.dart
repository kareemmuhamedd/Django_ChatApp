import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';

abstract class MapsRepository {
  Future<Either<Failure, List<dynamic>>> todo(
    String place,
    String sessionToken,
  );
}
