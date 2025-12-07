import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/popular_network_model.dart';
import '../../shared/components/buttons/build_action_button_row.dart';
import '../../shared/components/cards/build_network_card.dart';
import '../../shared/components/layout/build_full_back.dart';
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
      listener: (context, state) {
        //todo تعديل هنا
        if (state is MoviesGetVideoMoviesTrailerDataErrorData) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No video available'),
              backgroundColor: ColorManager.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = MoviesCubit.get(context);
        if (cubit.popularModel == null &&
            cubit.upcomingModel == null &&
            cubit.topRatedModel == null &&
            cubit.nowPlayingModel == null &&
            cubit.trendingModel == null) {
          return BuildFullBack();
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              //Carousel Slider
              Container(
                margin: EdgeInsets.only(bottom: 15.0),
                child: ConditionalBuilder(
                  condition: cubit.trendingModel != null,
                  builder: (context) => Stack(
                    alignment: AlignmentGeometry.bottomCenter,
                    children: [
                      MovieCarousel(movies: cubit.trendingModel!.results!),
                      BuildActionButtonRow(
                        myListPressed: () {},
                        playPressed: () async {
                          await cubit.getVideoMoviesTrailerData(
                            id: cubit.carousalIndex,
                          );
                          launchUrl(
                            Uri.parse(
                              "https://www.youtube.com/watch?v=${cubit.videoModel!.results![0].key}",
                            ),
                          );
                        },
                        infoPressed: () {
                          navigateTo(
                            context,
                            FullDetailsMoviesScreen(
                              movieId: cubit.carousalIndex,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  fallback: (context) => BuildFullBack(),
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
                fallback: (context) => BuildFullBack(),
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
                fallback: (context) => BuildFullBack(),
              ),
              //Popular Network Row Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
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
              //Now Playing  Movies
              ConditionalBuilder(
                condition: cubit.nowPlayingModel != null,
                builder: (context) => MoviesHorizontalSection(
                  title: 'Now Playing',
                  onSeeAll: () {
                    navigateTo(
                      context,
                      SeeAllScreen(
                        title: 'Now Playing Movies',
                        movies: cubit.nowPlayingModel!.results!,
                      ),
                    );
                  },
                  movies: cubit.nowPlayingModel!.results!,
                ),
                fallback: (context) => BuildFullBack(),
              ),
              //Top Rated Movies
              ConditionalBuilder(
                condition: cubit.topRatedModel != null,
                builder: (context) => MoviesHorizontalSection(
                  title: 'Top Rated',
                  onSeeAll: () {
                    navigateTo(
                      context,
                      SeeAllScreen(
                        title: 'Top Rated Movies',
                        movies: cubit.topRatedModel!.results!,
                      ),
                    );
                  },
                  movies: cubit.topRatedModel!.results!,
                ),
                fallback: (context) => BuildFullBack(),
              ),
            ],
          ),
        );
      },
    );
  }
}
