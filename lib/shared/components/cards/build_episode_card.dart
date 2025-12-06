import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../cubit/movies_cubit.dart';
import '../../cubit/movies_states.dart';
import '../../styles/colors.dart';
import '../effects/build_shimmer.dart';
import '../layout/build_full_back.dart';
import '../lists/build_video_bottom_sheet.dart';
import '../utils/function.dart';

class BuildEpisodeCard extends StatelessWidget {
  final int id;
  final int seasonNumber;

  const BuildEpisodeCard({
    super.key,
    required this.id,
    required this.seasonNumber,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = MoviesCubit.get(context);
    cubit.getEpisodeData(id: id, seasonNumber: seasonNumber);

    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return cubit.episodeModel != null
            ? Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    color: ColorManager.white,
                  ),
                  title: Row(
                    children: [
                      Text(
                        'Season ${cubit.episodeModel!.seasonNumber}',
                        style: style(17.0),
                      ),
                      SizedBox(width: 10.0),
                      if (cubit.episodeModel!.episodes!.length != 0)
                        Text(
                          '(${cubit.episodeModel!.episodes!.length} Episodes) ',
                          style: TextStyle(
                            color: ColorManager.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                    ],
                  ),
                ),
                body: ConditionalBuilder(
                  condition:
                      cubit.episodeModel != null &&
                      cubit.episodeModel!.episodes != null &&
                      cubit.episodeModel!.episodes!.isNotEmpty,
                  builder: (context) => ListView.separated(
                    itemBuilder: (context, index) => Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        "https://image.tmdb.org/t/p/w500/${cubit.episodeModel!.episodes![index].stillPath}",
                                    height: 180.0,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => BuildShimmer(
                                      height: 180.0,
                                      width: double.infinity,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                          'images/default-movie.png',
                                          fit: BoxFit.cover,
                                        ),
                                  ),
                                  Positioned(
                                    bottom: 12,
                                    left: 12,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "Episode ${cubit.episodeModel!.episodes![index].episodeNumber}",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          cubit.getVideoTVEpisodeData(
                                            id: id,
                                            seasonNumber: seasonNumber,
                                            episodeNumber: cubit
                                                .episodeModel!
                                                .episodes![index]
                                                .episodeNumber!,
                                          );
                                          BuildVideoBottomSheet.showEpisodeVideosSheet(
                                            context: context,
                                          );
                                        },
                                        child: Container(
                                          height: 55,
                                          width: 55,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(
                                              0.25,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  12,
                                  12,
                                  12,
                                  4,
                                ),
                                child: Text(
                                  "${cubit.episodeModel!.episodes![index].name ?? 'No title available'}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  '${cubit.episodeModel!.episodes![index].overview ?? 'No overview available'}',
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    infoItem(
                                      Icons.star,
                                      "${cubit.episodeModel!.episodes![index].voteAverage!.toStringAsFixed(1).toString()}",
                                    ),
                                    infoItem(
                                      Icons.timer,
                                      "${cubit.episodeModel!.episodes![index].runtime ?? 0} min",
                                    ),
                                    infoItem(
                                      Icons.calendar_today,
                                      "${cubit.episodeModel!.episodes![index].airDate ?? 'inValid date'}",
                                    ),
                                    infoItem(Icons.live_tv, "HD"),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 10.0),
                    itemCount: cubit.episodeModel!.episodes!.length,
                  ),
                  fallback: (context) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Image.asset(
                          'images/no-photos.png',
                          height: 200.0,
                          width: 200.0,
                        ),
                      ),
                      Text(
                        "No Data Available",
                        style: TextStyle(
                          color: ColorManager.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Scaffold(
                backgroundColor: ColorManager.baseColor,
                body: BuildFullBack(),
              );
      },
    );
  }

  Widget infoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 18),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13),
        ),
      ],
    );
  }
}
