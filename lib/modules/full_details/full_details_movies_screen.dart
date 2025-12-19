import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdbox_app/modules/full_details/person_data_movies.dart';
import 'package:hdbox_app/modules/full_details/photos_screen.dart';
import 'package:hdbox_app/modules/full_details/see_all_screen.dart';
import 'package:hdbox_app/modules/full_details/trailer_screen.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../shared/components/buttons/action_button_item.dart';
import '../../shared/components/buttons/build_play_button.dart';
import '../../shared/components/cards/build_cast_item.dart';
import '../../shared/components/cards/build_movie_card.dart';
import '../../shared/components/layout/build_full_back.dart';
import '../../shared/components/layout/build_image_screen.dart';
import '../../shared/components/lists/movies_horizontal_section.dart';
import '../../shared/components/utils/function.dart';
import '../../shared/cubit/movies_cubit.dart';
import '../../shared/cubit/movies_states.dart';
import '../../shared/styles/colors.dart';

class FullDetailsMoviesScreen extends StatefulWidget {
  final int movieId;

  const FullDetailsMoviesScreen({super.key, required this.movieId});

  @override
  State<FullDetailsMoviesScreen> createState() =>
      _FullDetailsMoviesScreenState();
}

class _FullDetailsMoviesScreenState extends State<FullDetailsMoviesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MoviesCubit.get(context).getDetailsData(id: widget.movieId);
    MoviesCubit.get(context).getCreditsData(id: widget.movieId);
    MoviesCubit.get(context).getSimilarData(id: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    var cubit = MoviesCubit.get(context);
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (cubit.detailsModel == null ||
            cubit.creditsModel == null ||
            cubit.similarModel == null) {
          return Scaffold(body: BuildFullBack());
        }
        //todo
        return WillPopScope(
          onWillPop: () async {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            return true;
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ConditionalBuilder(
                    condition: cubit.detailsModel != null,
                    builder: (context) => BuildImageScreen(
                      image:
                          cubit.detailsModel!.backdropPath ??
                          cubit.detailsModel!.posterPath ??
                          '',
                      title: cubit.detailsModel!.title ?? 'Untitled',
                      voteAverage: cubit.detailsModel!.voteAverage!
                          .toStringAsFixed(1)
                          .toString(),
                      date: formattedDate(
                        date: cubit.detailsModel!.releaseDate ?? 'Unknown year',
                      ),
                    ),
                    fallback: (context) => BuildFullBack(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 23.0,horizontal: 10.0),
                        child: BuildPlayButton(
                          onPressed: () async {
                            if (cubit.detailsModel!.homepage == "") {
                              showSnakeBar(
                                color: ColorManager.red,
                                context: context,
                                label: 'No videos found',
                              );
                            } else {
                              launchUrl(
                                Uri.parse(cubit.detailsModel!.homepage!),
                              );
                            }
                          },
                          label: 'Play',
                          icon: Icons.play_arrow,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ReadMoreText(
                          '${cubit.detailsModel!.overview}',
                          style: style(14.0),
                          trimMode: TrimMode.Line,
                          trimLines: 3,
                          trimCollapsedText: "See More",
                          trimExpandedText: "See Less",
                          colorClickableText: ColorManager.blue,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 25.0,
                          horizontal: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ActionButtonItem(
                              label: 'Trailer',
                              icon: Icons.movie_creation_outlined,
                              onPressed: () {
                                navigateTo(
                                  context,
                                  TrailerScreen(id: widget.movieId),
                                );
                              },
                            ),
                            ActionButtonItem(
                              label: 'My List',
                              icon:
                                  cubit.isInWatchList(
                                    movieId: cubit.detailsModel!.id!,
                                    mediaType: 'movie',
                                  )
                                  ? Icons.done
                                  : Icons.add,
                              onPressed: () {
                                cubit.toggleWatchlist(
                                  movieId: cubit.detailsModel!.id!,
                                  name: cubit.detailsModel!.title ?? 'No title',
                                  mediaType: 'movie',
                                  posterPath:
                                      '${cubit.detailsModel!.posterPath ?? cubit.detailsModel!.backdropPath}',
                                  backdropPath:
                                      '${cubit.detailsModel!.backdropPath ?? cubit.detailsModel!.posterPath}',
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
                                navigateTo(
                                  context,
                                  PhotosScreen(id: widget.movieId),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ConditionalBuilder(
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
                                    final credit = cubit
                                        .creditsModel!
                                        .credits!
                                        .cast![index];
                                    return BuildCastItem(
                                      onTap: () {
                                        navigateTo(
                                          context,
                                          PersonDataMovies(
                                            id: credit.id!,
                                            name: credit.name ?? '',
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
                      ),
                      ConditionalBuilder(
                        condition:
                            cubit.similarModel != null &&
                            cubit.similarModel!.similar != null &&
                            cubit.similarModel!.similar!.results != null &&
                            cubit.similarModel!.similar!.results!.isNotEmpty,
                        builder: (context) => MoviesHorizontalSection(
                          title: 'RELATED',
                          onSeeAll: () {
                            navigateTo(
                              context,
                              SeeAllScreen(
                                title: 'Related Movies',
                                movies: cubit.similarModel!.similar!.results!,
                              ),
                            );
                          },
                          movies: cubit.similarModel!.similar!.results!,
                        ),
                        fallback: (context) => SizedBox(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
