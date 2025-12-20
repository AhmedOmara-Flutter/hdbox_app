import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdbox_app/layout/movies_homeLayout.dart';
import 'package:hdbox_app/modules/full_details/full_details_movies_screen.dart';
import 'package:hdbox_app/modules/full_details/full_details_tv_movies_screen.dart';
import 'package:hdbox_app/shared/components/cards/build_watchlist_card.dart';
import 'package:hdbox_app/shared/components/layout/build_appbar_screens.dart';
import 'package:hdbox_app/shared/components/layout/build_full_back.dart';
import 'package:hdbox_app/shared/cubit/movies_cubit.dart';
import 'package:hdbox_app/shared/cubit/movies_states.dart';
import '../../shared/components/buttons/segmented_tab_selector.dart';
import '../../shared/components/empty_state/no_data_view.dart';
import '../../shared/components/lists/build_snackbar.dart';
import '../../shared/components/utils/function.dart';
import '../../shared/styles/colors.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MoviesCubit.get(context).getWatchList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        var cubit = MoviesCubit.get(context);
        if (cubit.isWatchlistLoading) {
          return Scaffold(body: BuildFullBack());
        }
        if (cubit.watchlist.isEmpty) {
          return NoDataView(
            title: 'Your watchlist is empty',
            appBarTitle: 'My WatchList',
            buttonText: 'Browse Movies & TV',
            onPressed: () {
              cubit.resetCurrentIndex();
              navigateTo(context, MoviesHomeLayout(), isReplacement: true);
            },
          );
        }
        return WillPopScope(
          onWillPop: () async {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            return true;
          },
          child: Scaffold(
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
                                child: SegmentedTabSelector(
                                  label: 'Movies',
                                  color: cubit.selectedType == 'movie'
                                      ? ColorManager.blue
                                      : ColorManager.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(7.0),
                                    bottomLeft: Radius.circular(7.0),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  cubit.filteredWatchListFun(type: 'tv');
                                },
                                child: SegmentedTabSelector(
                                  label: 'TV Shows',
                                  color: cubit.selectedType == 'tv'
                                      ? ColorManager.blue
                                      : ColorManager.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(7.0),
                                    bottomRight: Radius.circular(7.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        cubit.filteredWatchList.isNotEmpty
                            ? ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                itemBuilder: (context, index) => BuildWatchlistCard(
                                  image:
                                      '${cubit.filteredWatchList[index].posterPath ?? cubit.filteredWatchList[index].backdropPath}',
                                  name:
                                      cubit.filteredWatchList[index].name ?? "",
                                  overview:
                                      cubit.filteredWatchList[index].overview ??
                                      "",
                                  delete: () {
                                    cubit.deleteWatchList(
                                      mediaType: cubit
                                          .filteredWatchList[index]
                                          .mediaType!,
                                      movieId: cubit
                                          .filteredWatchList[index]
                                          .movieId!,
                                    );
                                  },
                                  onTap: () {
                                    if (cubit
                                            .filteredWatchList[index]
                                            .mediaType ==
                                        'movie') {
                                      navigateTo(
                                        context,
                                        FullDetailsMoviesScreen(
                                          movieId: cubit
                                              .filteredWatchList[index]
                                              .movieId!,
                                        ),
                                      );
                                    } else if (cubit
                                            .filteredWatchList[index]
                                            .mediaType ==
                                        'tv') {
                                      navigateTo(
                                        context,
                                        FullDetailsTvMoviesScreen(
                                          movieId: cubit
                                              .filteredWatchList[index]
                                              .movieId!,
                                        ),
                                      );
                                    }
                                  },
                                ),
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 20.0),
                                itemCount: cubit.filteredWatchList.length,
                              )
                            :SizedBox(
                                //todo
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                child: Center(
                                  child: Text(
                                    'Add ${cubit.selectedType=='movie'?'Movies':'TV shows'} to your list so you can easily\nfind them later.',
                                    textAlign: TextAlign.center,
                                    style: style(17.0),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  )
                : BuildFullBack(),
          ),
        );
      },
    );
  }
}
