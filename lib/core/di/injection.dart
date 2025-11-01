import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../../features/movies/data/data_sources/movies_local_data_source.dart';
import '../../features/movies/data/data_sources/movies_remote_data_source.dart';
import '../../features/movies/data/repo_impl/movies_repository_impl.dart';
import '../../features/movies/presentation/cubit/movies_cubit.dart';
import '../../features/movies/presentation/cubit/theme_cubit.dart';

final sl = GetIt.instance;

Future<void> initDI(SharedPreferences prefs) async {
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org/3'));
    return dio;
  });

  sl.registerLazySingleton<MoviesRemoteDataSource>(
    () => MoviesRemoteDataSourceImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<MoviesLocalDataSource>(
    () => MoviesLocalDataSourceImpl(sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<MoviesRepo>(
    () => MoviesRepo(
      remoteDataSource: sl<MoviesRemoteDataSource>(),
      localDataSource: sl<MoviesLocalDataSource>(),
    ),
  );

  sl.registerFactory(() => MoviesCubit(repository: sl<MoviesRepo>()));

  sl.registerFactory(() => ThemeCubit(prefs: sl<SharedPreferences>()));
}
