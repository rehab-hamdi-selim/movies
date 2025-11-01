import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies/features/movies/presentation/widgets/poster_image.dart';
import '../../domain/entities/movie_entity.dart';
import '../../../../core/constants/app_colors.dart';
import '../screens/details_screen.dart';
import 'genre_badge.dart';

class MovieItem extends StatelessWidget {
  final MovieEntity movie;
  const MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final mainTextColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? AppColors.lightMainText;
    final sideTextColor = Theme.of(context).brightness == Brightness.light
        ? AppColors.lightSideText
        : AppColors.darkSideText;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MovieDetailsPage(movie: movie)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14.r),
        ),
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            PosterImage(
              posterPath: movie.posterPath,
              width: 84.w,
              height: 120.h,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: mainTextColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.star, color: AppColors.star, size: 18.sp),
                      SizedBox(width: 6.w),
                      Text(
                        '${movie.voteAverage.toStringAsFixed(1)} / 10',
                        style: TextStyle(fontSize: 14.sp, color: sideTextColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  GenreBadge(),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.white54),
          ],
        ),
      ),
    );
  }
}
