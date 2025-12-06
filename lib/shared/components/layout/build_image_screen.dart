import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../utils/function.dart';

class BuildImageScreen extends StatelessWidget {
  final String image;
  final String title;
  final String? voteAverage;
  final String? date;
  final String? season;
  final String? episode;

  const BuildImageScreen({
    super.key,
    required this.image,
    required this.title,
    this.voteAverage,
    this.date,
    this.season,
    this.episode,
  });

  @override
  Widget build(BuildContext context) {
    double height = 300.0;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        children: [
          CachedNetworkImage(
            width: double.infinity,
            height: height,
            imageUrl: 'https://image.tmdb.org/t/p/w500/$image',
            fit: BoxFit.fill,
            placeholder: (context, url) => Container(
              height: height,
              width: double.infinity,
              decoration: BoxDecoration(color: ColorManager.baseColor),
            ),
            errorWidget: (context, url, error) =>
                Image.asset('images/default-movie.png', fit: BoxFit.cover),
          ),
          shadowBellowPhoto(shadow: 0.7),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(title, style: style(24.0)),
                SizedBox(height: 10.0),
                if (voteAverage != null && date != null)
                  Row(
                    children: [
                      Icon(Icons.star, size: 12.0, color: Colors.white),
                      SizedBox(width: 3.0),
                      Text(voteAverage!, style: style(14.0)),
                      SizedBox(width: 5.0),
                      Text('.  $date', style: style(14.0)),
                    ],
                  ),
                if (episode != null && season != null)
                  Text(
                    '$season Seasons . $episode Episodes',
                    style: style(14.0),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: ColorManager.white,
                  size: 22.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
