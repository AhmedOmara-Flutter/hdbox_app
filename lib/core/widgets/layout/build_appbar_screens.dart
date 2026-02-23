import 'package:hdbox_app/core/helpers/app_imports.dart';

class BuildAppbarScreen extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const BuildAppbarScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
        color: ColorManager.white,
      ),
      title: Text(title, style: style(18.0)),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50.0);
}
