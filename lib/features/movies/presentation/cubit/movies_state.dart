import 'package:equatable/equatable.dart';
import '../../domain/entities/movie_entity.dart';

enum MoviesStatus { initial, loading, loaded, error, loadingMore }

class MoviesState extends Equatable {
  final MoviesStatus status;
  final List<MovieEntity> movies;
  final String? errorMessage;
  final int page;
  final bool hasMore;

  const MoviesState({
    required this.status,
    required this.movies,
    this.errorMessage,
    required this.page,
    required this.hasMore,
  });

  factory MoviesState.initial() => const MoviesState(
    status: MoviesStatus.initial,
    movies: [],
    page: 1,
    hasMore: true,
  );

  MoviesState copyWith({
    MoviesStatus? status,
    List<MovieEntity>? movies,
    String? errorMessage,
    int? page,
    bool? hasMore,
  }) {
    return MoviesState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [status, movies, errorMessage, page, hasMore];
}
