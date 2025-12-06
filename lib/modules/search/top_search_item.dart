import 'package:flutter/material.dart';

import '../../shared/styles/colors.dart';

class TopSearchItem extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const TopSearchItem({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            height: 90.0,
            width: 150.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorManager.baseColor.withOpacity(0.1),
              ),
              image: DecorationImage(
                image: NetworkImage('https://image.tmdb.org/t/p/w500/$image'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                title,
                style: TextStyle(
                  color: ColorManager.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 17.0,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Icon(
              Icons.play_circle_outline_rounded,
              color: ColorManager.white,
              size: 40.0,
            ),
          ),
        ],
      ),
    );
  }
}
