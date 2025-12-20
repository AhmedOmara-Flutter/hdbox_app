import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/components/lists/build_snackbar.dart';
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
          );

        }
        if(state is DeleteWatchListSuccessState){
          return BuildSnackBar.showWatchlistSnackBar(
            context: context,
            message: 'Deleted From watchlist',
          );
        }
      },
      builder: (context, state) {
        var cubit = MoviesCubit.get(context);
        //todo مش فاهم منها حاجه بس من غيرها التطبيق لو واقف علي watchlist ورجعت هرجع لل profile ثم home
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (didPop) return;
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
              return;
            }
            if (cubit.currentIndex != 0) {
              cubit.changeBottomNavBar(0);
              return;
            }
            Navigator.of(context).maybePop();
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
            //todo وحبيت اروح لمكان تاني في الشاشه ارجع الاقي مكانه مرجع من الاول  in home ده عشان انا في
            body: IndexedStack(
              index: cubit.currentIndex,
              children: cubit.screens,
            ),
          ),
        );
      },
    );
  }
}
