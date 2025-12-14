import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../shared/components/effects/build_shimmer.dart';
import '../../shared/styles/colors.dart';

class TopSearchItem extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const TopSearchItem({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            height: 90.0,
            width: 150.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ClipRRect(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              borderRadius: BorderRadius.circular(10.0),

              child: CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w500/$image',
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    BuildShimmer(height: 90.0, width: 150.0),
                errorWidget: (context, url, error) =>
                    Image.asset('images/default-movie.png', fit: BoxFit.cover),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                title,
                style: TextStyle(
                  color: ColorManager.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 17.0,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Icon(
              Icons.play_circle_outline_rounded,
              color: ColorManager.white,
              size: 40.0,
            ),
          ),
        ],
      ),
    );
  }
}
