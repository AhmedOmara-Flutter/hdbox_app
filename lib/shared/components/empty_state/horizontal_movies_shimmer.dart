import 'package:flutter/material.dart';
import 'package:hdbox_app/shared/components/effects/build_shimmer.dart';

import '../../../modules/full_details/full_details_movies_screen.dart';
import '../cards/build_movie_card.dart';
import '../layout/section_header.dart';
import '../utils/function.dart';

class HorizontalMoviesShimmer extends StatelessWidget {
  final String title;

  const HorizontalMoviesShimmer({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: title, onPressed: () {  },),
        SizedBox(
          height: 180.0,
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => BuildShimmer(height: 180.0, width: 120.0),
            separatorBuilder: (context, index) => SizedBox(width: 10.0),
            itemCount: 20,
          ),
        ),
      ],
    );
  }
}
