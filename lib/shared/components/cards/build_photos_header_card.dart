import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../effects/build_shimmer.dart';
import '../utils/function.dart';

class BuildPhotosHeaderCard extends StatelessWidget {
  final String title;
  final List movies;
  final VoidCallback seeAll;

  const BuildPhotosHeaderCard({
    super.key,
    required this.title,
    required this.seeAll,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 220.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                width: 5.0,
                height: 28.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: ColorManager.gold,
                ),
              ),
              Text(title, style: style(20.0)),
              SizedBox(width: 5.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text('${movies.length}', style: style(13.0)),
              ),
              Spacer(),
              TextButton(
                onPressed: seeAll,
                child: Text(
                  'See all',
                  style: TextStyle(color: ColorManager.red),
                ),
              ),
            ],
          ),
          Spacer(),
          SizedBox(
            height: 150.0,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (_) =>
                  //       ShowImageDialog(image: '${movies[index].filePath}'),
                  // );
                },
                child: ClipRRect(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  borderRadius: BorderRadius.circular(10.0),
                  child: SizedBox(
                    width: 230.0,
                    height: 150.0,
                    child: CachedNetworkImage(
                      width: 230.0,
                      height: 150.0,
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500/${movies[index].filePath}',
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          BuildShimmer(height: 150.0, width: 230.0),
                      errorWidget: (context, url, error) => Image.asset(
                        'images/default-movie.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(width: 10.0),
              itemCount: movies.length,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
