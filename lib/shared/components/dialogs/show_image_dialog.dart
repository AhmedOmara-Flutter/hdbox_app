import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShowImageDialog extends StatelessWidget {
  final String image;

  const ShowImageDialog({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: CachedNetworkImage(
        height: 400.0,
        width: double.infinity,
        imageUrl: 'https://image.tmdb.org/t/p/w500$image',
        fit: BoxFit.cover,
        errorWidget: (context, url, error) =>
            Image.asset('images/default-movie.png', fit: BoxFit.cover),
      ),
    );
  }
}
