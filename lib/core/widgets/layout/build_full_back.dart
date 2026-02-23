import 'package:hdbox_app/core/helpers/app_imports.dart';

class BuildFullBack extends StatelessWidget {
  const BuildFullBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: ColorManager.red));
  }
}
