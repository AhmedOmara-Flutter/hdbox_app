import 'package:hdbox_app/core/helpers/app_imports.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (cotext, state) {
          if (state is RegisterSuccessState) {
            showSnakeBar(
              context: context,
              label: StringManager.registerSuccess,
              color: Colors.green,
            );
            navigateTo(context, LoginScreen(),isReplacement: true);
          }
          if (state is RegisterErrorState) {
            showSnakeBar(
              context: context,
              label: StringManager.registerError,
              color: ColorManager.red,
            );
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Scaffold(
              body: Stack(
                children: [
                  GetBackgroundImage(),
                  GetBlurredOverlay(),
                  GetDarkGradientBottomOverlay(),
                  CustomBackButton(),
                  GetRegisterContent(cubit: cubit, state: state)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
