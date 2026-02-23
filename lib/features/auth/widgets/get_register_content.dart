import 'package:hdbox_app/core/helpers/app_imports.dart';

class GetRegisterContent extends StatelessWidget {
  final RegisterCubit cubit;
  final RegisterStates state;

  const GetRegisterContent({super.key, required this.cubit, required this.state});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: PaddingManager.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(height: AppSizeManager.s100),
                Text(
                  StringManager.registerHeader1,
                  style: style(FontManager.s32),
                ),
                SizedBox(height: AppSizeManager.s13),
                Text(
                  StringManager.registerHeader2,
                  style: style(FontManager.s15),
                ),
                SizedBox(height: AppSizeManager.s35),
                BuildTextFormField(
                  controller: cubit.usernameController,
                  icon: Icons.person,
                  label: StringManager.userName,
                ),
                SizedBox(height: AppSizeManager.s18),
                BuildTextFormField(
                  controller: cubit.emailController,
                  icon: Icons.email_outlined,
                  label: StringManager.email,
                ),
                const SizedBox(height: AppSizeManager.s18),
                BuildTextFormField(
                  suffixIcon: cubit.isPassword
                      ? Icons.remove_red_eye
                      : Icons.visibility_off,
                  controller: cubit.passwordController,
                  icon: Icons.password,
                  label: StringManager.password,
                  isPassword: cubit.isPassword,
                  suffixOnPressed: () {
                    cubit.isPasswordChanged();
                  },
                  type: TextInputType.phone,
                ),
                const SizedBox(height: AppSizeManager.s28),
                ConditionalBuilder(
                  condition: state is! RegisterLoadingState,
                  builder: (context) => BuildPlayButton(
                    onPressed: () async {
                      await cubit.userRegister(
                        email: cubit.emailController.text,
                        password: cubit.passwordController.text,
                        username: cubit.usernameController.text,
                      );
                    },
                    label: StringManager.createAccount,
                  ),
                  fallback: (context) => BuildFullBack(),
                ),
                const SizedBox(height: AppSizeManager.s25),
                AuthFooter(
                  label: StringManager.alreadyHaveAccount,
                  buttonName: StringManager.login,
                  buttonOnPressed: () {
                    navigateTo(context, LoginScreen());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
