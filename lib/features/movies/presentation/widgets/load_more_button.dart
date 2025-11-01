import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadMoreButton extends StatelessWidget {
  final bool isLoading;
  final bool enabled;
  final VoidCallback onPressed;

  const LoadMoreButton({
    super.key,
    required this.isLoading,
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled && !isLoading ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).cardColor,
        minimumSize: Size(double.infinity, 48.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(
              'Load More Movies',
              style: TextStyle(
                fontSize: 16.sp,
                color: Theme.of(context).textTheme.labelLarge?.color,
              ),
            ),
    );
  }
}
