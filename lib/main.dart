import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hdbox_app/shared/components/constants.dart';
import 'package:hdbox_app/shared/cubit/bloc_observer.dart';
import 'package:hdbox_app/shared/network/local/cache_helper.dart';
import 'package:hdbox_app/shared/network/remote/dio_helper.dart';
import 'package:hdbox_app/src/src.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // debugPrintRebuildDirtyWidgets = true;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
   Constants.uId=await CacheHelper.getData(key: 'uId')??'';
  runApp( AppRoot(uId:Constants.uId,));
}

// 4167b8eadc90545c75d2aa1c Recovery Phrase in dark web