import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../effects/build_shimmer.dart';

class BuildCastItem extends StatelessWidget {
  final String image;
  final VoidCallback onTap;

  const BuildCastItem({super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80.0,
        width: 80.0,
        decoration: BoxDecoration(shape: BoxShape.circle),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500/$image',
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                BuildShimmer(height: 85.0, width: 85.0),
            errorWidget: (context, url, error) =>
                CircleAvatar(backgroundColor: Color(0xff131313)),
          ),
        ),
      ),
    );
  }
}
