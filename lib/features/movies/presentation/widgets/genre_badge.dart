import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';

class GenreBadge extends StatelessWidget {
  final String text;
  const GenreBadge({super.key, this.text = 'Genre'});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white24),
        color: isLight ? AppColors.lightMovieCard : AppColors.darkMovieCard,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isLight ? AppColors.lightSideText : AppColors.darkSideText,
        ),
      ),
    );
  }
}
