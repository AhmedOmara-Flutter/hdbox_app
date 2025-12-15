import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../modules/watchlist/watchlist_screen.dart';
import '../shared/components/lists/build_snackbar.dart';
import '../shared/components/utils/function.dart';
import '../shared/cubit/movies_cubit.dart';
import '../shared/cubit/movies_states.dart';
import '../shared/styles/colors.dart';

class MoviesHomeLayout extends StatelessWidget {
  const MoviesHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is AddToWatchListSuccessState) {
          return BuildSnackBar.showWatchlistSnackBar(
            context: context,
            message: 'Added to watchlist',
            buttonText: 'VIEW',
            onPressed: () {
              navigateTo(context, WatchlistScreen());
            },
          );
        }
      },
      builder: (context, state) {
        var cubit = MoviesCubit.get(context);
        return WillPopScope(
          onWillPop: () async {
            if (cubit.currentIndex != 0) {
              cubit.changeBottomNavBar(0);
              return false; //todo متقفلش التطبيق
            } else {
              return true; //todo اقفل التطبيق
            }
          },
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                return cubit.changeBottomNavBar(index);
              },
              selectedItemColor: ColorManager.red,
              unselectedItemColor: ColorManager.white,
              backgroundColor: ColorManager.baseColor,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.grid_view_rounded),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
            //appBar: cubit.appBars[cubit.currentIndex],
            body: cubit.screens[cubit.currentIndex],
          ),
        );
      },
    );
  }
}
