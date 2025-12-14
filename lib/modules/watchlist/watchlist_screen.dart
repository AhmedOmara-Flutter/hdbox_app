import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdbox_app/shared/components/layout/build_appbar_screens.dart';
import 'package:hdbox_app/shared/components/layout/build_full_back.dart';
import 'package:hdbox_app/shared/cubit/movies_cubit.dart';
import 'package:hdbox_app/shared/cubit/movies_states.dart';
import '../../shared/components/effects/build_shimmer.dart';
import '../../shared/components/utils/function.dart';
import '../../shared/styles/colors.dart';

class WatchlistScreen extends StatelessWidget {
  //final List<dynamic> movies;

  const WatchlistScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    var cubit=MoviesCubit.get(context);
    cubit.getWatchList();
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return cubit.watchlist.isNotEmpty?Scaffold(
          appBar: BuildAppbarScreen(title: 'My WatchList'),
          body: GridView.count(
            padding: EdgeInsets.all(10.0),
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 20.0,
            childAspectRatio: 1 / 1.70,
            children: List.generate(
              cubit.watchlist.length,
                  (index) =>
                  GestureDetector(
                    onTap: () {
                      // navigateTo(
                      //   context,
                      //   FullDetailsMoviesScreen(movieId: movies[index].id),
                      // );
                      //print(cubit.watchlistModel!.image);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: CachedNetworkImage(
                        imageUrl:
                        'https://image.tmdb.org/t/p/w500${cubit.watchlist[index].image}',
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            BuildShimmer(height: 0.0, width: 0.0),
                        errorWidget: (context, url, error) =>
                            Image.asset(
                                'images/default-movie.png', fit: BoxFit.cover),
                      ),
                    ),
                  ),
            ),
          ),
        ):Scaffold(body: BuildFullBack(),);
      },
    );
  }
}
