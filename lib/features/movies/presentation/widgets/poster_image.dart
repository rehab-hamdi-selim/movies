import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PosterImage extends StatelessWidget {
  final String posterPath;
  final double width;
  final double height;

  const PosterImage({
    super.key,
    required this.posterPath,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = (posterPath.isNotEmpty)
        ? 'https://image.tmdb.org/t/p/w500$posterPath'
        : null;

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: width,
        height: height,
        child: imageUrl != null
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (_, __) =>
                    Image.asset('assets/images/poster.jpg', fit: BoxFit.cover),
                errorWidget: (_, __, ___) =>
                    Image.asset('assets/images/poster.jpg', fit: BoxFit.cover),
                fit: BoxFit.cover,
              )
            : Image.asset('assets/images/poster.jpg', fit: BoxFit.cover),
      ),
    );
  }
}
