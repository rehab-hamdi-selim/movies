import 'package:dio/dio.dart';
import '../../../../core/constants/api_contants.dart';
import '../models/movie_model.dart';

abstract class MoviesRemoteDataSource {
  Future<List<MovieModel>> fetchPopularMovies({int page = 1});
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final Dio dio;
  MoviesRemoteDataSourceImpl(this.dio);

  @override
  Future<List<MovieModel>> fetchPopularMovies({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {
        'api_key': ApiConstants.tmdbApiKey,
        'language': 'en-US',
        'page': page,
      },
    );
    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;
      return results
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load remote movies');
    }
  }
}
