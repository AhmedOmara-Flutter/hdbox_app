import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules/full_details/video_details_screen.dart';
import '../../cubit/movies_cubit.dart';
import '../../cubit/movies_states.dart';
import '../../styles/colors.dart';
import '../layout/build_full_back.dart';
import '../utils/function.dart';

class BuildVideoBottomSheet {
  static void showEpisodeVideosSheet({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.baseColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return BlocConsumer<MoviesCubit, MoviesState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = MoviesCubit.get(context);

            if (state is MoviesGetVideoTVEpisodeLoadingData) {
              return BuildFullBack();
            }

            if (cubit.videoModel!.results!.isEmpty) {
              return Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text("No Videos Available", style: style(16.0)),
                    ),
                  ],
                ),
              );
            }

            return ConditionalBuilder(
              condition:
                  cubit.videoModel != null &&
                  cubit.videoModel!.results != null &&
                  cubit.videoModel!.results!.isNotEmpty,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Videos',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    ...cubit.videoModel!.results!.map((video) {
                      return InkWell(
                        onTap: () {
                          navigateTo(
                            context,
                            VideoDetailsScreen(
                              thumbnail: video.key!,
                              title: video.name ?? 'No title',
                              type: video.type ?? 'No type',
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.play_circle_outline,
                                color: Colors.red,
                                size: 30,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      video.name ?? "No title",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      video.type ?? 'No Type',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
              fallback: (context) => BuildFullBack(),
            );
          },
        );
      },
    );
  }
}
