import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../effects/build_shimmer.dart';

class BuildSeasonCard extends StatelessWidget {
  final String image;
  final String season;
  final String date;
  final String numEpisodes;
  final String voteAverage;
  final VoidCallback onTap;

  const BuildSeasonCard({
    super.key,
    required this.image,
    required this.season,
    required this.date,
    required this.numEpisodes,
    required this.voteAverage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        height: 320,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: CachedNetworkImage(
                imageUrl: "https://image.tmdb.org/t/p/w500/$image}",
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    BuildShimmer(height: 200.0, width: double.infinity),
                errorWidget: (context, url, error) =>
                    Image.asset('images/default-movie.png', fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    season,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  // Air date
                  Row(
                    children: [
                      Icon(Icons.date_range, size: 15, color: Colors.white70),
                      SizedBox(width: 4),
                      Text(
                        date,
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.play_circle_fill,
                        size: 15,
                        color: Colors.white70,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "$numEpisodes Episodes",
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),

                  SizedBox(height: 4),

                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 3),
                      Text(
                        voteAverage,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
