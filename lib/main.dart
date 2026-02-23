import 'package:hdbox_app/core/helpers/app_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Constants.isSeen = await CacheHelper.getData(key:'isSeen') ?? false;
  Constants.uId = await CacheHelper.getData(key: 'uId') ?? '';
  runApp(AppRoot(uId: Constants.uId, isSeen: Constants.isSeen));
}

