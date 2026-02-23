import 'package:hdbox_app/core/helpers/app_imports.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      height: 200.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ClipOval(child: BuildShimmer(height: 110, width: 110)),
          SizedBox(height: 15.0),
          BuildShimmer(height: 12.0, width: 150.0),
          SizedBox(height: 10.0),
          BuildShimmer(height: 12.0, width: 200.0),
        ],
      ),
    );
  }
}
