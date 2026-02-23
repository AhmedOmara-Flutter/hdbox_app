import 'package:hdbox_app/core/helpers/app_imports.dart';

class TrailerScreen extends StatelessWidget {
  final int id;

  const TrailerScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    var cubit = MoviesCubit.get(context);
    cubit.getVideoMoviesTrailerData(id: id);

    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (cubit.videoModel == null) {
          return Scaffold(
            appBar: BuildAppbarScreen(title: 'Trailers'),
            body: BuildFullBack(),
          );
        }

        if (cubit.videoModel!.results == null ||
            cubit.videoModel!.results!.isEmpty) {
          return NoDataView(
            title: 'No Videos Available',
            appBarTitle: 'Trailers',
          );
        }
        return Scaffold(
          appBar: BuildAppbarScreen(title: 'Trailers'),
          body: ConditionalBuilder(
            condition:
                cubit.videoModel != null &&
                cubit.videoModel!.results != null &&
                cubit.videoModel!.results!.isNotEmpty,
            builder: (context) {
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cubit.videoModel!.results!.length,
                itemBuilder: (context, index) {
                  final v = cubit.videoModel!.results![index];
                  return InkWell(
                    onTap: () {
                      launchUrl(
                        Uri.parse("https://www.youtube.com/watch?v=${v.key}"),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Stack(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl:
                                          'https://img.youtube.com/vi/${v.key}/mqdefault.jpg',
                                      height: 80.0,
                                      width: 120.0,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                            'images/default-movie.png',
                                            fit: BoxFit.cover,
                                          ),
                                      placeholder: (context, url) =>
                                          BuildShimmer(height: 80.0, width: 120.0),
                                    ),
                                    Container(
                                      height: 80,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Colors.black45,
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 24,
                                      left: 45,
                                      child: Icon(
                                        Icons.play_circle_fill,
                                        size: 32,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      v.name ?? "Untitled",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      v.type ?? "Video",
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      //todo
                      if(index != cubit.videoModel!.results!.length-1)
                        Divider(color: Colors.white12, height: 1)
                      ],
                    ),
                  );
                },
              );
            },
            fallback: (context) => BuildFullBack(),
          ),
        );
      },
    );
  }
}
