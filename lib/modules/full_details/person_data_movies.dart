import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/effects/build_shimmer.dart';
import '../../shared/components/layout/build_full_back.dart';
import '../../shared/components/utils/function.dart';
import '../../shared/cubit/movies_cubit.dart';
import '../../shared/cubit/movies_states.dart';
import '../../shared/styles/colors.dart';
import 'full_details_movies_screen.dart';

class PersonDataMovies extends StatelessWidget {
  final String name;
  final int id;

  const PersonDataMovies({super.key, required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    var cubit = MoviesCubit.get(context);
    cubit.getPersonData(id: id);
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 22.0,
                color: ColorManager.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              name,
              style: TextStyle(
                color: ColorManager.white,
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
          ),
          body: ConditionalBuilder(
            condition: cubit.personDataModel != null,
            builder: (context) => GridView.count(
              padding: EdgeInsets.all(10.0),
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 20.0,
              childAspectRatio: 1 / 1.70,
              children: List.generate(
                cubit.personDataModel!.cast!.length,
                (index) => InkWell(
                  onTap: () {
                    navigateTo(
                      context,
                      FullDetailsMoviesScreen(
                        movieId: cubit.personDataModel!.cast![index].id!,
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusGeometry.circular(10.0),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: ClipRRect(
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500/${cubit.personDataModel!.cast![index].posterPath}',
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
            fallback: (context) => BuildFullBack(),
          ),
        );
      },
    );
  }
}
