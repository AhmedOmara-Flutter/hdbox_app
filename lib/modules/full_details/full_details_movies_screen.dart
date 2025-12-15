import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdbox_app/modules/full_details/person_data_movies.dart';
import 'package:hdbox_app/modules/full_details/photos_screen.dart';
import 'package:hdbox_app/modules/full_details/trailer_screen.dart';
import 'package:hdbox_app/modules/watchlist/watchlist_screen.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../shared/components/buttons/action_button_item.dart';
import '../../shared/components/buttons/build_play_button.dart';
import '../../shared/components/cards/build_cast_item.dart';
import '../../shared/components/cards/build_movie_card.dart';
import '../../shared/components/layout/build_full_back.dart';
import '../../shared/components/layout/build_image_screen.dart';
import '../../shared/components/lists/build_snackbar.dart';
import '../../shared/components/utils/function.dart';
import '../../shared/cubit/movies_cubit.dart';
import '../../shared/cubit/movies_states.dart';
import '../../shared/styles/colors.dart';

class FullDetailsMoviesScreen extends StatelessWidget {
  final int movieId;

  const FullDetailsMoviesScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    var cubit = MoviesCubit.get(context);
    cubit.getDetailsData(id: movieId);
    cubit.getCreditsData(id: movieId);
    cubit.getSimilarData(id: movieId);

    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {
        if (state is AddToWatchListSuccessState) {
          return BuildSnackBar.showWatchlistSnackBar(
            context: context,
            message: 'Added to watchlist',
            onPressed: () {
              navigateTo(context, WatchlistScreen());
            },
          );
        }
      },
      builder: (context, state) {
        if (cubit.detailsModel == null) {
          return Scaffold(
            backgroundColor: ColorManager.baseColor,
            body: Center(
              child: CircularProgressIndicator(color: ColorManager.red),
            ),
          );
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                ConditionalBuilder(
                  condition: cubit.detailsModel != null,
                  builder: (context) => BuildImageScreen(
                    image: cubit.detailsModel!.backdropPath ??cubit.detailsModel!.posterPath! ,
                    title: cubit.detailsModel!.title ?? '',
                    voteAverage: cubit.detailsModel!.voteAverage!
                        .toStringAsFixed(1)
                        .toString(),
                    date:
                        formattedDate(date: cubit.detailsModel!.releaseDate ?? 'Unknown year'),
                  ),
                  fallback: (context) => BuildFullBack(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 23.0),
                        child: BuildPlayButton(
                          onPressed: () async {
                            await cubit.getVideoMoviesTrailerData(id: movieId);
                            launchUrl(
                              Uri.parse(
                                "https://www.youtube.com/watch?v=${cubit.videoModel!.results![0].key}",
                              ),
                            );
                          },
                          label: 'Play',
                          icon: Icons.play_arrow,
                        ),
                      ),
                      ReadMoreText(
                        '${cubit.detailsModel!.overview}',
                        style: style(14.0),
                        trimMode: TrimMode.Line,
                        trimLines: 3,

                        trimCollapsedText: "See More",
                        trimExpandedText: "See Less",
                        colorClickableText: ColorManager.blue,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ActionButtonItem(
                              label: 'Trailer',
                              icon: Icons.movie_creation_outlined,
                              onPressed: () {
                                navigateTo(context, TrailerScreen(id: movieId));
                              },
                            ),
                            ActionButtonItem(
                              label: 'My List',
                              icon: Icons.add,
                              onPressed: () {
                                cubit.addToWatchList(
                                  movieId: cubit.detailsModel!.id!,
                                  name: cubit.detailsModel!.title ?? '',
                                  mediaType: 'movie',
                                  posterPath: '${cubit.detailsModel!.posterPath ?? cubit.detailsModel!.backdropPath}',
                                  backdropPath: '${cubit.detailsModel!.backdropPath ?? cubit.detailsModel!.posterPath}',
                                  overview: cubit.detailsModel!.overview ?? '',
                                );
                              },
                            ),
                            ActionButtonItem(
                              label: 'Share',
                              icon: Icons.share,
                              onPressed: () {},
                            ),
                            ActionButtonItem(
                              label: 'Photos',
                              icon: Icons.photo,
                              onPressed: () {
                                navigateTo(context, PhotosScreen(id: movieId));
                              },
                            ),
                          ],
                        ),
                      ),
                      ConditionalBuilder(
                        condition:
                            cubit.creditsModel != null &&
                            cubit.creditsModel!.credits != null &&
                            cubit.creditsModel!.credits!.cast != null &&
                            cubit.creditsModel!.credits!.cast!.isNotEmpty,
                        builder: (context) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('CAST', style: style(16.0)),
                            SizedBox(
                              height: 110.0,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final credit =
                                      cubit.creditsModel!.credits!.cast![index];
                                  return BuildCastItem(
                                    onTap: () {
                                      navigateTo(
                                        context,
                                        PersonDataMovies(
                                          id: credit.id!,
                                          name: credit.name!,
                                        ),
                                      );
                                    },
                                    image: '${credit.profilePath}',
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 10.0),
                                itemCount:
                                    cubit.creditsModel!.credits!.cast!.length,
                              ),
                            ),
                          ],
                        ),
                        fallback: (context) => SizedBox(),
                      ),
                      ConditionalBuilder(
                        condition:
                            cubit.similarModel != null &&
                            cubit.similarModel!.similar != null &&
                            cubit.similarModel!.similar!.results != null &&
                            cubit.similarModel!.similar!.results!.isNotEmpty,
                        builder: (context) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Text('RELATED', style: style(16.0)),
                            ),
                            SizedBox(
                              height: 180.0,
                              child: ListView.separated(
                                padding: EdgeInsets.only(bottom: 10.0),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final movie = cubit
                                      .similarModel!
                                      .similar!
                                      .results![index];
                                  return BuildMovieCard(
                                    onTap: () {
                                      navigateTo(
                                        context,
                                        FullDetailsMoviesScreen(
                                          movieId: movie.id!,
                                        ),
                                        isReplacement: true,
                                      );
                                    },
                                    image: '${movie.posterPath??movie.backdropPath}',
                                    voteAverage: movie.voteAverage!
                                        .toStringAsFixed(1),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 10.0),
                                itemCount: cubit
                                    .similarModel!
                                    .similar!
                                    .results!
                                    .length,
                              ),
                            ),
                          ],
                        ),
                        fallback: (context) => SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
