import 'package:app/constants.dart';
import 'package:dio/dio.dart';

class PlacesWebservices {
  late Dio dio;

  PlacesWebservices() {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> fetchSuggestions(
    String place,
    String sessionToken,
  ) async {
    try {
      Response response = await dio.get(
        baseUrl,
        queryParameters: {
          'input': place,
          'types': 'address',
          'components': 'country:eg',
          'key': 'googleApiKey',
          'sessiontoken': sessionToken,
        },
      );
      return response.data['predictions'];
    } catch (error) {
      print(error.toString());
      return [];
    }
  }
}