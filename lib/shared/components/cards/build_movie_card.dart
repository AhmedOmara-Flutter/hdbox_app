import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../styles/colors.dart';
import '../effects/build_shimmer.dart';

class BuildMovieCard extends StatelessWidget {
  final String image;
  final VoidCallback onTap;
  final String? voteAverage;

  const BuildMovieCard({
    super.key,
    required this.image,
    this.voteAverage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double height = 180;
    double width = 120;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          alignment: AlignmentGeometry.topRight,
          children: [
            CachedNetworkImage(
              height: height,
              width: width,
              imageUrl: 'https://image.tmdb.org/t/p/w500/$image',
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  BuildShimmer(height: height, width: width),
              errorWidget: (context, url, error) =>
                  Image.asset('images/default-movie.png', fit: BoxFit.cover),
            ),
            if (voteAverage != null)
              Container(
                margin: EdgeInsets.all(7.0),
                padding: EdgeInsets.only(
                  top: 5.0,
                  bottom: 5.0,
                  right: 7.0,
                  left: 4.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: ColorManager.blue,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 15),
                    const SizedBox(width: 4),
                    Text(
                      voteAverage!,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
