import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    super.key,
    required this.imgUrl,
    required this.height,
    required this.width,
    this.radius = 0,
    this.fit = BoxFit.cover,
  });

  final String imgUrl;

  final double height;
  final double width;
  final double radius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: imgUrl == "null" ? "" : imgUrl,
        fit: fit,
        height: height,
        width: width,
        placeholder: (context, url) => const SizedBox(
          width: 15,
          height: 15,
          child: SizedBox(
            width: 20,
            height: 20,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
