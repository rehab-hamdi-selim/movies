import '../../domain/entities/movie_entity.dart';
import '../data_sources/movies_local_data_source.dart';
import '../data_sources/movies_remote_data_source.dart';
import 'package:logger/logger.dart';

class MoviesRepo {
  final MoviesRemoteDataSource remoteDataSource;
  final MoviesLocalDataSource localDataSource;
  final _logger = Logger();

  MoviesRepo({required this.remoteDataSource, required this.localDataSource});

  Future<List<MovieEntity>> getPopularMovies({int page = 1}) async {
    try {
      final remote = await remoteDataSource.fetchPopularMovies(page: page);
      await localDataSource.cacheMoviesPage(page, remote);
      return remote.map((m) => m.toEntity()).toList();
    } catch (e) {
      // log and fallback to cache
      _logger.e('Remote fetch failed');
      await localDataSource.addErrorLog(e.toString());
      final cached = await localDataSource.getCachedMovies();
      if (cached != null && cached.isNotEmpty) {
        return cached.map((m) => m.toEntity()).toList();
      }
      rethrow;
    }
  }
}
