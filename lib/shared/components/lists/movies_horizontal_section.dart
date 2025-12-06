import 'package:flutter/material.dart';

import '../../../modules/full_details/full_details_movies_screen.dart';
import '../cards/build_movie_card.dart';
import '../layout/section_header.dart';
import '../utils/function.dart';

class MoviesHorizontalSection extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;
  final List movies;

  const MoviesHorizontalSection({
    super.key,
    required this.title,
    required this.onSeeAll,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: title, onPressed: onSeeAll),
        SizedBox(
          height: 180.0,
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => BuildMovieCard(
              onTap: () {
                var movieId = movies[index].id;
                navigateTo(context, FullDetailsMoviesScreen(movieId: movieId!));
              },
              image: movies[index].posterPath!,
            ),
            separatorBuilder: (context, index) => SizedBox(width: 10.0),
            itemCount: movies.length,
          ),
        ),
      ],
    );
  }
}
