import 'package:flutter/material.dart';

import '../../shared/styles/colors.dart';

class SearchInfoRow extends StatelessWidget {
  final String title;
  final String date;
  final VoidCallback onTap;

  const SearchInfoRow({
    super.key,
    required this.title,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.search, color: ColorManager.white, size: 20.0),
                SizedBox(width: 13.0),
                Expanded(
                  child: Text(
                    '$title ($date)',
                    style: TextStyle(color: ColorManager.white, fontSize: 15.0),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              width: double.infinity,
              height: 2.0,
              color: ColorManager.darkGray,
            ),
          ],
        ),
      ),
    );
  }
}
