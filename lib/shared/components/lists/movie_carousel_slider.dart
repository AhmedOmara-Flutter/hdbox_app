import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/movies_cubit.dart';
import '../../cubit/movies_states.dart';
import '../../styles/colors.dart';

class MovieCarousel extends StatelessWidget {
  final List<dynamic> movies;

  const MovieCarousel({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = MoviesCubit.get(context);
        return CarouselSlider(
          items: movies.map((e) {
            final imageUrl = "https://image.tmdb.org/t/p/w500/${e.posterPath}";
            return Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) => Container(
                    height: 500.0,
                    width: double.infinity,
                    decoration: BoxDecoration(color: ColorManager.baseColor),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'images/default-movie.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        ColorManager.baseColor,
                        ColorManager.baseColor.withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
          options: CarouselOptions(
            height: 500.0,
            enlargeCenterPage: false,
            enlargeFactor: 0.25,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 900),
            viewportFraction: 1,
            //initialPage: 5,
            aspectRatio: 16 / 9,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, _) {
              cubit.carousalIndex = movies[index].id;
            cubit.indexIteration=index;
            },
          ),
        );
      },
    );
  }
}
