import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdbox_app/modules/full_details/full_details_movies_screen.dart';
import 'package:hdbox_app/modules/full_details/full_details_tv_movies_screen.dart';
import 'package:hdbox_app/shared/components/cards/build_watchlist_card.dart';
import 'package:hdbox_app/shared/components/layout/build_appbar_screens.dart';
import 'package:hdbox_app/shared/components/layout/build_full_back.dart';
import 'package:hdbox_app/shared/cubit/movies_cubit.dart';
import 'package:hdbox_app/shared/cubit/movies_states.dart';
import '../../shared/components/effects/build_shimmer.dart';
import '../../shared/components/lists/build_snackbar.dart';
import '../../shared/components/utils/function.dart';
import '../../shared/styles/colors.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = MoviesCubit.get(context);
    cubit.getWatchList();
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        // if (cubit.watchlist.isEmpty) {
        //   return Scaffold(
        //     appBar: BuildAppbarScreen(title: 'My WatchList'),
        //     body:Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Image.asset('images/video.png', height: 140.0, width: 140.0),
        //         SizedBox(height: 8.0),
        //         Center(child: Text("Your watchlist is empty", style: style(16.0))),
        //       ],
        //     )
        //   );
        // }
        return Scaffold(
          appBar: BuildAppbarScreen(title: 'My WatchList'),
          body: cubit.watchlist.isNotEmpty
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                cubit.filteredWatchListFun(type: 'movie');
                              },
                              child: Container(
                                //color: ColorManager.red,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(7.0),
                                    bottomLeft: Radius.circular(7.0),
                                  ),
                                  border: Border.all(
                                    color: ColorManager.white,
                                    width: 0.5,
                                  ),
                                ),
                                width: 110.0,
                                height: 32.0,
                                child: Center(
                                  child: Text(
                                    'Movies'.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: cubit.selectedType == 'movie'
                                          ? ColorManager.blue
                                          : ColorManager.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                cubit.filteredWatchListFun(type: 'tv');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(7.0),
                                    bottomRight: Radius.circular(7.0),
                                  ),
                                  border: Border.all(
                                    color: ColorManager.white,
                                    width: 0.5,
                                  ),
                                ),
                                width: 110.0,
                                height: 32.0,
                                child: Center(
                                  child: Text(
                                    'Tv shows'.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: cubit.selectedType == 'tv'
                                          ? ColorManager.blue
                                          : ColorManager.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        itemBuilder: (context, index) => BuildWatchlistCard(
                          image:
                              '${cubit.filteredWatchList[index].posterPath ??
                                  cubit.filteredWatchList[index].backdropPath}',
                          name: cubit.filteredWatchList[index].name ?? "",
                          overview:
                              cubit.filteredWatchList[index].overview ?? "",
                          delete: () {
                            //delete: () => cubit.deleteFromWatchList(cubit.watchlist[index].id),
                          },
                          onTap: () {
                            if (cubit.filteredWatchList[index].mediaType ==
                                'movie') {
                              navigateTo(
                                context,
                                FullDetailsMoviesScreen(
                                  movieId:
                                      cubit.filteredWatchList[index].movieId!,
                                ),
                              );
                            } else if (cubit
                                    .filteredWatchList[index]
                                    .mediaType ==
                                'tv') {
                              navigateTo(
                                context,
                                FullDetailsTvMoviesScreen(
                                  movieId:
                                      cubit.filteredWatchList[index].movieId!,
                                ),
                              );
                            }
                          },
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20.0),
                        itemCount: cubit.filteredWatchList.length,
                      ),
                    ],
                  ),
                )
              : BuildFullBack(),
        );
      },
    );
  }
}
