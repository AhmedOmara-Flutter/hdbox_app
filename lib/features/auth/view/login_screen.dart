import 'package:hdbox_app/core/helpers/app_imports.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then(
              (value) {
                Constants.uId = state.uId;
              },
            );
            showSnakeBar(
              context: context,
              label: StringManager.loginSuccess,
              color: Colors.green,
            );
            navigateTo(context, MoviesHomeLayout(), isReplacement: true);
          }
          if (state is LoginErrorState) {
            showSnakeBar(
              context: context,
              label: StringManager.loginError,
              color: ColorManager.red,
            );
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Scaffold(
              body: Stack(
                children: [
                  GetBackgroundImage(),
                  GetBlurredOverlay(),
                  GetDarkGradientBottomOverlay(),
                  CustomBackButton(),
                  GetLoginContent(cubit: cubit, state: state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
