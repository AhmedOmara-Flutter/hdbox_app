import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdbox_app/modules/search/search_info_row.dart';
import 'package:hdbox_app/modules/search/top_search_item.dart';
import '../../shared/components/utils/function.dart';
import '../../shared/cubit/movies_cubit.dart';
import '../../shared/cubit/movies_states.dart';
import '../../shared/styles/colors.dart';
import '../full_details/full_details_movies_screen.dart';
import '../full_details/full_details_tv_movies_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        String formatedYearDate({required String date}) {
          if (date == null || date.isEmpty) return "Unknown year";
          try {
            DateTime dateTime = DateTime.parse(date);
            String formatedDate = dateTime.year.toString();
            return formatedDate;
          } catch (e) {
            return 'Unknown year';
          }
        }

        var cubit = MoviesCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
                left: 10.0,
                top: 15.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Search',
                    style: TextStyle(
                      color: ColorManager.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff333333),
                      borderRadius: BorderRadiusGeometry.circular(15.0),
                    ),
                    margin: const EdgeInsets.only(top: 15.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: ColorManager.baseColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: ColorManager.baseColor),
                        ),
                        hintText: 'Enter here to search a movie',
                        hintStyle: TextStyle(color: ColorManager.white),
                      ),
                      style: TextStyle(color: ColorManager.white),
                      onChanged: (value) {
                        cubit.getMultiSearch(q: value);
                        cubit.searchText = value;
                      },
                    ),
                  ),
                  if (cubit.searchText.isNotEmpty)
                    ConditionalBuilder(
                      condition: cubit.multiSearchModel != null,
                      builder: (context) => Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            final movie =
                                cubit.multiSearchModel!.results[index];

                            return SearchInfoRow(
                              onTap: () {
                                if (movie.isMovie) {
                                  navigateTo(
                                    context,
                                    FullDetailsMoviesScreen(movieId: movie.id!),
                                  );
                                } else if (movie.isTv) {
                                  navigateTo(
                                    context,
                                    FullDetailsTvMoviesScreen(
                                      movieId: movie.id!,
                                    ),
                                  );
                                }
                              },
                              title: movie.displayTitle,
                              date: formatedYearDate(
                                date: movie.displayDate,
                              ),
                            );
                          },
                          itemCount: cubit.multiSearchModel!.results!.length,
                        ),
                      ),
                      fallback: (context) => Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 10.0,
                          ),
                          child: LinearProgressIndicator(
                            color: ColorManager.red,
                          ),
                        ),
                      ),
                    ),
                  if (cubit.searchText.isEmpty)
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 25.0),
                      child: Text(
                        'Top Searches',
                        style: TextStyle(
                          color: ColorManager.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (cubit.searchText.isEmpty)
                    ConditionalBuilder(
                      condition: cubit.topSearchModel != null,
                      builder: (context) => Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => TopSearchItem(
                            onTap: () {
                              navigateTo(
                                context,
                                FullDetailsMoviesScreen(
                                  movieId:
                                      cubit.topSearchModel!.results![index].id!,
                                ),
                              );
                            },
                            image: cubit
                                .topSearchModel!
                                .results![index]
                                .posterPath!,
                            title: cubit.topSearchModel!.results![index].title!,
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 20.0),
                          itemCount: cubit.topSearchModel!.results!.length,
                        ),
                      ),
                      fallback: (context) =>
                          CircularProgressIndicator(color: ColorManager.red),
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
