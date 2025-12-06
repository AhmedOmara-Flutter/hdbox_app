import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/layout/build_full_back.dart';
import '../../shared/components/utils/function.dart';
import '../../shared/cubit/movies_cubit.dart';
import '../../shared/cubit/movies_states.dart';
import '../full_details/genres_details_screen.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = MoviesCubit.get(context);
        return cubit.genresListModel != null
            ? Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    "🎭 Genres",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),

                body: Container(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cubit.genresListModel!.genres!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 18,
                          mainAxisSpacing: 18,
                          childAspectRatio: 1.1,
                        ),

                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          navigateTo(
                            context,
                            GenresDetailsScreen(
                              id: cubit.genresListModel!.genres![index].id!,
                              genres:
                                  cubit.genresListModel!.genres![index].name!,
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            color: Colors.grey.shade700,
                          ),

                          child: Center(
                            child: Text(
                              cubit.genresListModel!.genres![index].name!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            : BuildFullBack();
      },
    );
  }
}
