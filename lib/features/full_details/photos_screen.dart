import 'package:hdbox_app/core/helpers/app_imports.dart';

class PhotosScreen extends StatelessWidget {
  final int id;

  const PhotosScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    var cubit = MoviesCubit.get(context);
    cubit.getImagesData(id: id);

    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (cubit.imagesModel == null) {
          return Scaffold(
            body: BuildFullBack(),
          );
        }
        return cubit.imagesModel!.images!.backdrops!.isNotEmpty
            ? Scaffold(
                appBar: BuildAppbarScreen(title: 'Photos'),
                body: ConditionalBuilder(
                  condition: cubit.imagesModel != null,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                      itemCount: cubit.imagesModel!.images!.backdrops!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 1 / 1.70,
                          ),
                      itemBuilder: (context, index) {
                        final movie =
                            cubit.imagesModel!.images!.backdrops![index];
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) =>
                                  ShowImageDialog(image: '${movie.filePath!}'),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: CachedNetworkImage(
                                    height: double.infinity,
                                    width: double.infinity,
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/w500${movie.filePath!}',
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        BuildShimmer(height: 0.0, width: 0.0),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                          color: Colors.grey[800],
                                          child: const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  fallback: (context) => BuildFullBack(),
                ),
              )
            : NoDataView(title: 'No Photos Available', appBarTitle: 'Photos',image: 'no-photos.png',);
      },
    );
  }
}