import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdbox_app/modules/full_details/see_all_tv_images_screen.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/components/buttons/action_button_item.dart';
import '../../shared/components/buttons/build_play_button.dart';
import '../../shared/components/cards/build_episode_card.dart';
import '../../shared/components/cards/build_movie_card.dart';
import '../../shared/components/cards/build_photos_header_card.dart';
import '../../shared/components/cards/build_season_card.dart';
import '../../shared/components/layout/build_full_back.dart';
import '../../shared/components/layout/build_image_screen.dart';
import '../../shared/components/lists/build_snackbar.dart';
import '../../shared/components/utils/function.dart';
import '../../shared/cubit/movies_cubit.dart';
import '../../shared/cubit/movies_states.dart';
import '../../shared/styles/colors.dart';
import '../watchlist/watchlist_screen.dart';

class FullDetailsTvMoviesScreen extends StatelessWidget {
  final int movieId;

  const FullDetailsTvMoviesScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    var cubit = MoviesCubit.get(context);
    cubit.getTVMoviesData(id: movieId);
    cubit.getSimilarTVData(id: movieId);
    cubit.getImagesTVData(id: movieId);

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
        if (cubit.tvMoviesModel == null || cubit.imagesTVModel == null) {
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
                //image poster
                ConditionalBuilder(
                  condition: cubit.tvMoviesModel != null,
                  builder: (context) => BuildImageScreen(
                    image: '${cubit.tvMoviesModel!.backdropPath??cubit.tvMoviesModel!.posterPath}',
                    title: '${cubit.tvMoviesModel!.name}',
                    season: '${cubit.tvMoviesModel!.numberOfSeasons}',
                    episode: '${cubit.tvMoviesModel!.numberOfEpisodes}',
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
                          label: 'Play',
                          icon: Icons.play_arrow,
                          onPressed: () async {
                            await cubit.getVideoTVData(id: movieId);
                            launchUrl(
                              Uri.parse(
                                "https://www.youtube.com/watch?v=${cubit.videoModel!.results![0].key}",
                              ),
                            );
                          },
                        ),
                      ),

                      ReadMoreText(
                        '${cubit.tvMoviesModel!.overview}',
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ActionButtonItem(
                              label: 'My List',
                              icon: Icons.add,
                              onPressed: () {
                                cubit.addToWatchList(
                                  movieId: cubit.tvMoviesModel!.id!,
                                  name: cubit.tvMoviesModel!.name ?? '',
                                  mediaType: 'tv',
                                  posterPath:
                                      '${cubit.tvMoviesModel!.posterPath ?? cubit.tvMoviesModel!.backdropPath}',
                                  backdropPath: '${cubit.tvMoviesModel!.backdropPath ?? cubit.tvMoviesModel!.posterPath}',
                                  overview: cubit.tvMoviesModel!.overview ?? '',
                                );
                              },
                            ),
                            ActionButtonItem(
                              label: 'Share',
                              icon: Icons.share,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10.0),
                        width: 5.0,
                        height: 28.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: ColorManager.gold,
                        ),
                      ),
                      Text('Episodes', style: style(20.0)),
                      SizedBox(width: 5.0),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          '${cubit.tvMoviesModel!.numberOfEpisodes}',
                          style: style(13.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ConditionalBuilder(
                    condition:
                        cubit.tvMoviesModel != null &&
                        cubit.tvMoviesModel!.seasons != null &&
                        cubit.tvMoviesModel!.seasons!.isNotEmpty,
                    builder: (context) => SizedBox(
                      height: 320.0,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var tvShow = cubit.tvMoviesModel!.seasons![index];
                          return BuildSeasonCard(
                            onTap: () {
                              navigateTo(
                                context,
                                BuildEpisodeCard(
                                  id: cubit.tvMoviesModel!.id!,
                                  seasonNumber: cubit
                                      .tvMoviesModel!
                                      .seasons![index]
                                      .seasonNumber!,
                                ),
                              );
                            },
                            image: tvShow.posterPath ?? '',
                            season: tvShow.name ?? 'No title',
                            date: tvShow.airDate ?? "inValid Date",
                            numEpisodes: '${tvShow.episodeCount}',
                            voteAverage: tvShow.voteAverage!
                                .toStringAsFixed(1)
                                .toString(),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 10.0),
                        itemCount: cubit.tvMoviesModel!.seasons!.length,
                      ),
                    ),
                    fallback: (context) => BuildFullBack(),
                  ),
                ),
                ConditionalBuilder(
                  condition:
                      cubit.imagesTVModel != null &&
                      cubit.imagesTVModel!.backdrops != null &&
                      cubit.imagesTVModel!.backdrops!.isNotEmpty,
                  builder: (context) => BuildPhotosHeaderCard(
                    title: 'Photos',
                    seeAll: () {
                      navigateTo(
                        context,
                        SeeAllTVImagesScreen(
                          title: '${cubit.tvMoviesModel!.name} Gallery',
                          movies: cubit.imagesTVModel!.backdrops!,
                        ),
                      );
                    },
                    movies: cubit.imagesTVModel!.backdrops!,
                  ),
                  fallback: (context) => SizedBox(),
                ),
                SizedBox(height: 15.0),
                ConditionalBuilder(
                  condition:
                      cubit.similarTVModel != null &&
                      cubit.similarTVModel!.results != null &&
                      cubit.similarTVModel!.results!.isNotEmpty,
                  builder: (context) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [Text('RELATED', style: style(16.0))],
                        ),
                      ),
                      SizedBox(height: 15.0),
                      SizedBox(
                        height: 180.0,
                        child: ListView.separated(
                          padding: EdgeInsets.only(
                            bottom: 10.0,
                            left: 10.0,
                            right: 10.0,
                          ),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final movie = cubit.similarTVModel!.results![index];
                            return BuildMovieCard(
                              onTap: () {
                                navigateTo(
                                  context,
                                  FullDetailsTvMoviesScreen(movieId: movie.id!),
                                  isReplacement: true,
                                );
                              },
                              image: '${movie.posterPath??movie.backdropPath}',
                              voteAverage: movie.voteAverage!.toStringAsFixed(
                                1,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 10.0),
                          itemCount: cubit.similarTVModel!.results!.length,
                        ),
                      ),
                    ],
                  ),
                  fallback: (context) => SizedBox(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
