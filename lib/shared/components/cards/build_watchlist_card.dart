import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hdbox_app/shared/styles/colors.dart';

import '../effects/build_shimmer.dart';
import '../utils/function.dart';

class BuildWatchlistCard extends StatelessWidget {
  final String image;
  final String name;
  final String overview;
  final VoidCallback delete;
  final VoidCallback onTap;

  const BuildWatchlistCard({
    super.key,
    required this.image,
    required this.name,
    required this.overview,
    required this.delete, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        ClipRRect(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          borderRadius: BorderRadius.circular(10.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap:onTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: 90.0,
                    height: 135.0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: CachedNetworkImage(
                      imageUrl: 'https://image.tmdb.org/t/p/w500$image',
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          BuildShimmer(height: 135.0, width: 90.0),
                      errorWidget: (context, url, error) => Image.asset(
                        'images/default-movie.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                        top: 5.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: style(16.0)),
                          Text(
                            overview,
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ClipRRect(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          borderRadius: BorderRadiusGeometry.circular(50.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: delete,
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.delete,
                  color: ColorManager.white,
                  size: 20.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
