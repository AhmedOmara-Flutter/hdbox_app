import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdbox_app/modules/full_details/full_details_movies_screen.dart';
import 'package:hdbox_app/shared/components/cards/build_watchlist_card.dart';
import 'package:hdbox_app/shared/components/layout/build_appbar_screens.dart';
import 'package:hdbox_app/shared/components/layout/build_full_back.dart';
import 'package:hdbox_app/shared/cubit/movies_cubit.dart';
import 'package:hdbox_app/shared/cubit/movies_states.dart';
import '../../shared/components/effects/build_shimmer.dart';
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
        return cubit.watchlist.isNotEmpty
            ? Scaffold(
                appBar: BuildAppbarScreen(title: 'My WatchList'),
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
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
                                    color: ColorManager.blue,
                                  ),
                                ),
                              ),
                            ),
                            Container(
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
                              // color:ColorManager.blue ,
                              width: 110.0,
                              height: 32.0,
                              child: Center(
                                child: Text(
                                  'Tv shows'.toUpperCase(),
                                  style: style(14.0),
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
                          image: cubit.watchlist[index].image ?? "",
                          name: cubit.watchlist[index].name ?? "",
                          overview: cubit.watchlist[index].overview ?? "",
                          delete: () {
                            //delete: () => cubit.deleteFromWatchList(cubit.watchlist[index].id),
                          },
                          onTap: () {
                            navigateTo(
                              context,
                              FullDetailsMoviesScreen(
                                movieId: cubit.watchlist[index].movieId!,
                              ),
                            );
                          },
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20.0),
                        itemCount: cubit.watchlist.length,
                      ),
                    ],
                  ),
                ),
              )
            : Scaffold(body: BuildFullBack());
      },
    );
  }
}
