import 'package:hdbox_app/core/helpers/app_imports.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        var cubit = MoviesCubit.get(context);
        return cubit.genresListModel != null
            ? Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    StringManager.genres,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: FontManager.s22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: FontManager.s1_2,
                    ),
                  ),
                ),
                body: GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: cubit.genresListModel!.genres!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSizeManager.s18,
            mainAxisSpacing: AppSizeManager.s18,
            childAspectRatio: AppSizeManager.s1_1,
          ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        navigateTo(
                          context,
                          GenresDetailsScreen(
                            id: cubit.genresListModel!.genres![index].id!,
                            genres: cubit.genresListModel!.genres![index].name!,
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSizeManager.s26),
                          color: Colors.grey.shade700,
                        ),

                        child: Center(
                  child: Text(
                    cubit.genresListModel!.genres![index].name!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: FontManager.s22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      )
          : BuildFullBack();
    },);
  }
}
