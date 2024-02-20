import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../models/places_suggestoins.dart';
import '../web_services/places_web_services.dart';
import 'maps_repo.dart';

class MapsRepositoryImplementation extends MapsRepository {
  final PlacesWebservices placesWebservices;

  MapsRepositoryImplementation(this.placesWebservices);

  @override
  Future<Either<Failure, List>> todo(
    String place,
    String sessionToken,
  ) async {
    try {
      final suggestions =
          await placesWebservices.fetchSuggestions(place, sessionToken);
      return right(
        suggestions
            .map((suggestion) => PlaceSuggestion.fromJson(suggestion))
            .toList(),
      );
    } catch (error) {
      return left(
        ServerFailure(
          error.toString(),
        ),
      );
    }
  }
}
