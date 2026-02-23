import 'package:hdbox_app/core/helpers/app_imports.dart';

class MoviesHomeLayout extends StatelessWidget {
  const MoviesHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {
        if (state is AddToWatchListSuccessState) {
          return BuildSnackBar.showWatchlistSnackBar(
            context: context,
            message: StringManager.addedToWatchlist,
          );
        }
        if(state is DeleteWatchListSuccessState){
          return BuildSnackBar.showWatchlistSnackBar(
            context: context,
            message: StringManager.deletedFromWatchlist,
          );
        }
      },
      builder: (context, state) {
        var cubit = MoviesCubit.get(context);
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              return cubit.changeBottomNavBar(index);
            },
            selectedItemColor: ColorManager.red,
            unselectedItemColor: ColorManager.white,
            backgroundColor: ColorManager.baseColor,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: StringManager.home),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: StringManager.search,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_rounded),
                label: StringManager.categories,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: StringManager.profile,
              ),
            ],
          ),
          body: IndexedStack(
            index: cubit.currentIndex,
            children: cubit.screens,
          ),
        );
      },
    );
  }
}