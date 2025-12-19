import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdbox_app/modules/full_details/full_details_tv_movies_screen.dart';
import 'package:hdbox_app/modules/watchlist/watchlist_screen.dart';
import 'package:hdbox_app/shared/components/cards/build_movie_card.dart';
import 'package:hdbox_app/shared/components/effects/build_shimmer.dart';
import 'package:hdbox_app/shared/components/lists/build_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/popular_network_model.dart';
import '../../shared/components/buttons/build_action_button_row.dart';
import '../../shared/components/cards/build_network_card.dart';
import '../../shared/components/empty_state/horizontal_movies_shimmer.dart';
import '../../shared/components/layout/build_full_back.dart';
import '../../shared/components/layout/section_header.dart';
import '../../shared/components/lists/movie_carousel_slider.dart';
import '../../shared/components/lists/movies_horizontal_section.dart';
import '../../shared/components/utils/function.dart';
import '../../shared/cubit/movies_cubit.dart';
import '../../shared/cubit/movies_states.dart';
import '../../shared/styles/colors.dart';
import '../full_details/full_details_movies_screen.dart';
import '../full_details/network_details_screen.dart';
import '../full_details/see_all_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MoviesCubit.get(context);
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Carousel Slider
                Container(
                  margin: EdgeInsets.only(bottom: 15.0),
                  child: ConditionalBuilder(
                    condition: cubit.trendingModel != null,
                    builder: (context) {
                      return Stack(
                        alignment: AlignmentGeometry.bottomCenter,
                        children: [
                          MovieCarousel(movies: cubit.trendingModel!.results!),
                          BuildActionButtonRow(
                            icon:
                                cubit.isInWatchList(
                                  movieId: cubit
                                      .trendingModel!
                                      .results![cubit.indexIteration]
                                      .id!,
                                  mediaType: 'movie',
                                )
                                ? Icons.done
                                : Icons.add,
                            myListPressed: () {
                              cubit.toggleWatchlist(
                                movieId: cubit
                                    .trendingModel!
                                    .results![cubit.indexIteration]
                                    .id!,
                                mediaType: 'movie',
                                name:
                                    cubit
                                        .trendingModel!
                                        .results![cubit.indexIteration]
                                        .title ??
                                    '',
                                posterPath:
                                    '${cubit.trendingModel!.results![cubit.indexIteration].posterPath ?? cubit.trendingModel!.results![cubit.indexIteration].backdropPath}',
                                backdropPath:
                                    '${cubit.trendingModel!.results![cubit.indexIteration].backdropPath ?? cubit.trendingModel!.results![cubit.indexIteration].posterPath}',
                                overview:
                                    '${cubit.trendingModel!.results![cubit.indexIteration].overview}',
                              );
                            },
                            playPressed: () async {
                              final movie = await cubit.getDetailsData(
                                id: cubit
                                    .trendingModel!
                                    .results![cubit.indexIteration]
                                    .id!,
                              );
                              if (movie!.homepage == "") {
                                showSnakeBar(
                                  color: ColorManager.red,
                                  context: context,
                                  label: 'No videos found',
                                );
                              } else {
                                launchUrl(Uri.parse(movie.homepage!));
                              }
                            },
                            infoPressed: () {
                              navigateTo(
                                context,
                                FullDetailsMoviesScreen(
                                  movieId: cubit
                                      .trendingModel!
                                      .results![cubit.indexIteration]
                                      .id!,
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                    fallback: (context) => Container(
                      width: double.infinity,
                      height: 500.0,
                      color: ColorManager.baseColor,
                    ),
                  ),
                ),
                //Most Popular Movies
                ConditionalBuilder(
                  condition: cubit.popularModel != null,
                  builder: (context) => MoviesHorizontalSection(
                    title: 'Most Popular',
                    onSeeAll: () {
                      navigateTo(
                        context,
                        SeeAllScreen(
                          title: 'Most Popular Movies',
                          movies: cubit.popularModel!.results!,
                        ),
                      );
                    },
                    movies: cubit.popularModel!.results!,
                  ),
                  fallback: (context) =>
                      HorizontalMoviesShimmer(title: 'Most Popular'),
                ),
                // UpComing Row Movies
                ConditionalBuilder(
                  condition: cubit.upcomingModel != null,
                  builder: (context) => MoviesHorizontalSection(
                    title: 'UpComing',
                    onSeeAll: () {
                      navigateTo(
                        context,
                        SeeAllScreen(
                          title: 'UpComing Movies',
                          movies: cubit.upcomingModel!.results!,
                        ),
                      );
                    },
                    movies: cubit.upcomingModel!.results!,
                  ),
                  fallback: (context) =>
                      HorizontalMoviesShimmer(title: 'UpComing'),
                ),
                //Popular Network Row Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 15.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('Popular Network', style: style(18.0))],
                  ),
                ),
                //Popular Network
                SizedBox(
                  height: 140.0,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => BuildNetworkCard(
                      onTap: () {
                        navigateTo(
                          context,
                          NetworkDetailsScreen(
                            popularNetworkModel: popularNetworkModel[index],
                          ),
                        );
                      },
                      title: popularNetworkModel[index].title,
                      image: popularNetworkModel[index].image,
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 10.0),
                    itemCount: popularNetworkModel.length,
                  ),
                ),
                //Top Rated Movies
                ConditionalBuilder(
                  condition: cubit.topRatedModel != null,
                  builder: (context) => MoviesHorizontalSection(
                    title: 'Top Rated',
                    onSeeAll: () {
                      navigateTo(context, WatchlistScreen());
                    },
                    movies: cubit.topRatedModel!.results!,
                  ),
                  fallback: (context) =>
                      HorizontalMoviesShimmer(title: 'Top Rated'),
                ),
                // My List
                if (cubit.watchlist.isNotEmpty)
                  ConditionalBuilder(
                    condition: cubit.watchlist.isNotEmpty,
                    builder: (context) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeader(
                          title: 'My List',
                          onPressed: () {
                            navigateTo(context, WatchlistScreen());
                          },
                        ),
                        SizedBox(
                          height: 180.0,
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                              final movies=cubit.watchlist[index];
                              return BuildMovieCard(
                                onTap: () {
                                  if(movies.mediaType=='movie'){
                                    navigateTo(
                                      context,
                                      FullDetailsMoviesScreen(movieId:movies.movieId!),
                                    );
                                  }else if(movies.mediaType=='tv'){
                                    navigateTo(
                                      context,
                                      FullDetailsTvMoviesScreen(movieId:movies.movieId!),
                                    );
                                  }
                                },
                                image:
                                movies.posterPath ??
                                    movies.backdropPath ??
                                    '',
                              );
                            } ,
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 10.0),
                            itemCount: cubit.watchlist.length,
                          ),
                        ),
                      ],
                    ),
                    fallback: (context) =>
                        HorizontalMoviesShimmer(title: 'My List'),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
