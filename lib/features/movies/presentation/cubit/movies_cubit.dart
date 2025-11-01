import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:movies/features/movies/data/repo_impl/movies_repository_impl.dart';
import 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MoviesRepo repository;
  MoviesCubit({required this.repository}) : super(MoviesState.initial());

  final _logger = Logger();

  Future<void> fetchInitial() async {
    emit(state.copyWith(status: MoviesStatus.loading, page: 1));
    try {
      final movies = await repository.getPopularMovies(page: 1);
      final hasMore = movies.isNotEmpty;
      emit(
        state.copyWith(
          status: MoviesStatus.loaded,
          movies: movies,
          page: 1,
          hasMore: hasMore,
        ),
      );
    } catch (e) {
      _logger.e('fetchInitial failed');
      emit(
        state.copyWith(status: MoviesStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> fetchNextPage() async {
    if (!state.hasMore || state.status == MoviesStatus.loadingMore) return;
    emit(state.copyWith(status: MoviesStatus.loadingMore));
    final nextPage = state.page + 1;
    try {
      final movies = await repository.getPopularMovies(page: nextPage);
      final hasMore = movies.isNotEmpty;
      final combined = List.of(state.movies)..addAll(movies);
      emit(
        state.copyWith(
          status: MoviesStatus.loaded,
          movies: combined,
          page: nextPage,
          hasMore: hasMore,
        ),
      );
    } catch (e) {
      _logger.e('fetchNextPage failed');
      emit(
        state.copyWith(status: MoviesStatus.error, errorMessage: e.toString()),
      );
    }
  }
}
