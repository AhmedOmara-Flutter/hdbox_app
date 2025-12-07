import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdbox_app/modules/auth/login/login_cubit/login_states.dart';

class LoginCubit extends Cubit<InitialState> {
  LoginCubit() : super(InitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);



}
