import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../shared/components/dialogs/show_image_dialog.dart';
import '../../shared/components/effects/build_shimmer.dart';
import '../../shared/styles/colors.dart';

class SeeAllTVImagesScreen extends StatelessWidget {
  final String title;
  final List<dynamic> movies;

  const SeeAllTVImagesScreen({
    super.key,
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorManager.baseColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: ColorManager.white,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: ColorManager.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      ),
      body: GridView.count(
        padding: EdgeInsets.all(10.0),
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 20.0,
        childAspectRatio: 1 / 1.70,
        children: List.generate(
          movies.length,
          (index) => ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) =>
                      ShowImageDialog(image: movies[index].filePath),
                );
              },
              child: Container(
                child: CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500/${movies[index].filePath}',
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      BuildShimmer(height: 0.0, width: 0.0),
                  errorWidget: (context, url, error) => Image.asset(
                    'images/default-movie.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
