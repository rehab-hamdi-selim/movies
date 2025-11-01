import 'package:flutter/material.dart';
import '../../domain/entities/movie_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieDetailsPage extends StatelessWidget {
  final MovieEntity movie;
  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final mainTextColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? AppColors.lightMainText;
    final sideTextColor = Theme.of(context).brightness == Brightness.light
        ? AppColors.lightSideText
        : AppColors.darkSideText;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Movie Details',
          style: TextStyle(
            color: Theme.of(context).appBarTheme.titleTextStyle?.color,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: SizedBox(
                    width: 260.w,
                    height: 380.h,
                    child: CachedNetworkImage(
                      imageUrl: movie.posterPath.isNotEmpty
                          ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                          : 'assets/static_poster.png',
                      placeholder: (_, __) => Image.asset(
                        'assets/static_poster.png',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (_, __, ___) => Image.asset(
                        'assets/static_poster.png',
                        fit: BoxFit.cover,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                movie.title,
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w800,
                  color: mainTextColor,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Icon(Icons.star, color: AppColors.star),
                  SizedBox(width: 8.w),
                  Text(
                    '${movie.voteAverage.toStringAsFixed(1)} / 10',
                    style: TextStyle(fontSize: 16.sp, color: sideTextColor),
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppColors.lightMovieCard
                          : AppColors.darkMovieCard,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Text(
                      'Sci-Fi',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? AppColors.lightSideText
                            : AppColors.darkSideText,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: mainTextColor,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                movie.overview,
                style: TextStyle(fontSize: 14.sp, color: sideTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
