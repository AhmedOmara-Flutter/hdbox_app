import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hdbox_app/shared/cubit/bloc_observer.dart';
import 'package:hdbox_app/shared/network/remote/dio_helper.dart';
import 'package:hdbox_app/src/src.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const AppRoot());
}
