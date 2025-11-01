import 'package:dio/dio.dart';
import '../constants/api_contants.dart';

class ApiClient {
  final Dio dio;
  ApiClient(this.dio);

  Future<Response> getPopular(int page) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {
        'api_key': ApiConstants.tmdbApiKey,
        'language': 'en-US',
        'page': page,
      },
    );
    return response;
  }
}
