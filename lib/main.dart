import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hdbox_app/shared/cubit/bloc_observer.dart';
import 'package:hdbox_app/shared/network/remote/dio_helper.dart';
import 'package:hdbox_app/src/src.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const AppRoot());
}
