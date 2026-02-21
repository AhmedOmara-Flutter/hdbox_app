import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hdbox_app/modules/onboarding/get_started_screen.dart';
import 'package:hdbox_app/modules/profile/update_profile_screen.dart';
import 'package:hdbox_app/shared/components/constants.dart';
import 'package:hdbox_app/shared/components/effects/build_shimmer.dart';
import 'package:hdbox_app/shared/components/utils/function.dart';
import 'package:hdbox_app/shared/cubit/movies_cubit.dart';
import 'package:hdbox_app/shared/cubit/movies_states.dart';
import 'package:hdbox_app/shared/styles/colors.dart';
import '../../shared/components/empty_state/profile_shimmer.dart';
import '../../shared/components/lists/build_profile_option_button.dart';
import '../../shared/network/local/cache_helper.dart';
import '../watchlist/watchlist_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = MoviesCubit.get(context);

    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final model = cubit.userModel;
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                ConditionalBuilder(
                  condition: model != null,
                  builder: (context) => Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      children: [
                        // Profile Image
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xff131313),
                              backgroundImage: NetworkImage('${model!.image}'),
                              radius: 55.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: () {
                                  navigateTo(
                                    context,
                                    UpdateProfileScreen(userModel: model),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 13.0,
                                  backgroundColor: ColorManager.red,
                                  child: Icon(
                                    Icons.edit,
                                    color: ColorManager.white,
                                    size: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        // Username
                        Text('${model.name}'.toUpperCase(), style: style(17.0)),
                        SizedBox(height: 5.0),
                        // Email
                        Text('${model.email}'.toLowerCase(), style: style(13.0)),
                      ],
                    ),
                  ),
                  fallback: (context) => ProfileShimmer(),
                ),
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    BuildProfileOptionButton(
                      icon: Icons.settings,
                      title: "Settings",
                      onPressed: () {},
                    ),
                    BuildProfileOptionButton(
                      icon: Icons.lock,
                      title: "Privacy",
                      onPressed: () {},
                    ),
                    BuildProfileOptionButton(
                      icon: Icons.movie,
                      title: "My Watchlist",
                      onPressed: () {
                        navigateTo(context, WatchlistScreen());
                      },
                    ),
                    BuildProfileOptionButton(
                      icon: Icons.help_outline,
                      title: "Help & Support",
                      onPressed: () {},
                    ),
                    const SizedBox(height: 20),
                    // Logout Button
                    Center(
                      child: TextButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Color(0xff1a1a1a),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: Text(
                                "Logout?",
                                style: TextStyle(color: ColorManager.white),
                              ),
                              content: Text(
                                "Are you sure you want to log out?",
                                style: TextStyle(color: ColorManager.lightGray),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: ColorManager.lightGray,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await FirebaseAuth.instance.signOut();

                                    // 2️⃣ Clear local data
                                    await CacheHelper.removeData(key: 'uId');
                                    Constants.uId = '';

                                    // 3️⃣ Reset app state
                                    cubit.resetUserModel();
                                    cubit.resetCurrentIndex();
                                    // 4️⃣ Feedback
                                    showSnakeBar(
                                      context: context,
                                      label: 'Logout Successfully',
                                      color: Colors.green,
                                    );
                                    // 5️⃣ Navigate
                                    navigateTo(
                                      context,
                                      GetStartedScreen(),
                                      isReplacement: true,
                                    );
                                  },
                                  child: Text(
                                    "Log Out",
                                    style: TextStyle(color: ColorManager.red),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text(
                          "Log Out",
                          style: style(18.0, color: ColorManager.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
