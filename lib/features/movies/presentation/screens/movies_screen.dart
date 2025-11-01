import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart' as di;
import '../cubit/movies_cubit.dart';
import '../cubit/movies_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/movie_item.dart';
import '../widgets/load_more_button.dart';
import '../cubit/theme_cubit.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<MoviesCubit>()..fetchInitial(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Movies',
            style: TextStyle(
              color:
                  Theme.of(context).appBarTheme.titleTextStyle?.color ??
                  AppColors.lightMainText,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: const SizedBox(),
          actions: [
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, themeState) {
                final isDark = themeState.isDark;
                return IconButton(
                  tooltip: isDark ? 'Switch to Light' : 'Switch to Dark',
                  onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                  icon: Icon(isDark ? Icons.wb_sunny : Icons.nightlight_round),
                );
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: BlocBuilder<MoviesCubit, MoviesState>(
          builder: (context, state) {
            if (state.status == MoviesStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == MoviesStatus.error &&
                state.movies.isEmpty) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: state.movies.length,
                        separatorBuilder: (_, __) => SizedBox(height: 16.h),
                        itemBuilder: (context, index) {
                          final movie = state.movies[index];
                          return MovieItem(movie: movie);
                        },
                      ),
                    ),
                    SizedBox(height: 12.h),
                    LoadMoreButton(
                      isLoading: state.status == MoviesStatus.loadingMore,
                      enabled: state.hasMore,
                      onPressed: () =>
                          context.read<MoviesCubit>().fetchNextPage(),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
