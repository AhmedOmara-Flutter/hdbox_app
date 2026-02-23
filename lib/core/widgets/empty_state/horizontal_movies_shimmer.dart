import 'package:hdbox_app/core/helpers/app_imports.dart';

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
