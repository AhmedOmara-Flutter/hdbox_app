import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/effects/build_shimmer.dart';
import '../../shared/components/layout/build_full_back.dart';
import '../../shared/components/utils/function.dart';
import '../../shared/cubit/movies_cubit.dart';
import '../../shared/cubit/movies_states.dart';
import '../../shared/styles/colors.dart';
import 'full_details_movies_screen.dart';

class GenresDetailsScreen extends StatelessWidget {
  final int id;
  final String genres;

  GenresDetailsScreen({super.key, required this.id, required this.genres});

  @override
  Widget build(BuildContext context) {
    var cubit = MoviesCubit.get(context);
    cubit.getGenresData(id: id);

    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (cubit.genresDataModel == null) {
          return Scaffold(
            backgroundColor: ColorManager.baseColor,
            body: BuildFullBack(),
          );
        }
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
              '$genres Movies',
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
              cubit.genresDataModel!.results!.length,
              (index) => GestureDetector(
                onTap: () {
                  print(cubit.genresDataModel!.results![index].id!);
                  navigateTo(
                    context,
                    FullDetailsMoviesScreen(
                      movieId: cubit.genresDataModel!.results![index].id!,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500/${cubit.genresDataModel!.results![index].posterPath}',
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
        );
      },
    );
  }
}
