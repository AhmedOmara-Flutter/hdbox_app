import 'package:hdbox_app/core/helpers/app_imports.dart';

class GetLoginContent extends StatelessWidget {
  final LoginCubit cubit;
  final LoginStates state;

  const GetLoginContent({super.key, required this.cubit, required this.state});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: PaddingManager.p20),
        child: Column(
          children: [
            SizedBox(height: AppSizeManager.s100),
            Text(StringManager.loginHeader1, style: style(FontManager.s32)),
            SizedBox(height: AppSizeManager.s13),
            Text(StringManager.loginHeader2, style: style(FontManager.s15)),
            SizedBox(height: AppSizeManager.s35),
            BuildTextFormField(
              controller: cubit.emailController,
              label: StringManager.email,
              icon: Icons.email_outlined,
            ),
            SizedBox(height: AppSizeManager.s18),
            BuildTextFormField(
              controller: cubit.passwordController,
              label: StringManager.password,
              icon: Icons.lock_outline_rounded,
              isPassword: cubit.isPassword,
              suffixIcon: cubit.isPassword
                  ? Icons.remove_red_eye
                  : Icons.visibility_off,
              suffixOnPressed: () {
                cubit.isPasswordChanged();
              },
              type: TextInputType.phone,
            ),
            SizedBox(height: AppSizeManager.s14),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                StringManager.forgetPassword,
                style: style(FontManager.s13, color: ColorManager.red),
              ),
            ),
            SizedBox(height: AppSizeManager.s28),
            ConditionalBuilder(
              condition: state is! LoginLoadingState,
              builder: (context) => BuildPlayButton(
                onPressed: () async {
                  await cubit.userLogin(
                    email: cubit.emailController.text,
                    password: cubit.passwordController.text,
                  );
                },
                label: StringManager.login,
              ),
              fallback: (context) => BuildFullBack(),
            ),
            SizedBox(height: AppSizeManager.s25),
            AuthFooter(
              label: StringManager.dontHaveAccount,
              buttonName: StringManager.signUp,
              buttonOnPressed: () {
                navigateTo(context, RegisterScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
