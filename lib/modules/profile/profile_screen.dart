import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hdbox_app/modules/onboarding/get_started_screen.dart';
import 'package:hdbox_app/shared/components/effects/build_shimmer.dart';
import 'package:hdbox_app/shared/components/utils/function.dart';
import 'package:hdbox_app/shared/cubit/movies_cubit.dart';
import 'package:hdbox_app/shared/cubit/movies_states.dart';
import 'package:hdbox_app/shared/styles/colors.dart';
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
                        CircleAvatar(
                          backgroundColor: Color(0xff131313),
                          backgroundImage: NetworkImage(model!.image!),
                          radius: 55.0,
                        ),
                        const SizedBox(height: 15),
                        // Username
                        Text(formatName(model.name??''), style: style(17.0)),
                        SizedBox(height: 5.0),
                        // Email
                        Text(model.email!.toLowerCase(), style: style(13.0)),
                      ],
                    ),
                  ),
                  fallback: (context) => Container(
                    margin: EdgeInsets.only(top: 20.0),
                    height: 200.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ClipOval(child: BuildShimmer(height: 110, width: 110)),
                        SizedBox(height: 15.0),
                        BuildShimmer(height: 12.0, width: 150.0),
                        SizedBox(height: 10.0),
                        BuildShimmer(height: 12.0, width: 200.0),
                      ],
                    ),
                  ),
                ),
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    _buildOption(
                      icon: Icons.settings,
                      title: "Settings",
                      onPressed: () {},
                    ),
                    _buildOption(
                      icon: Icons.lock,
                      title: "Privacy",
                      onPressed: () {},
                    ),
                    _buildOption(
                      icon: Icons.movie,
                      title: "My Watchlist",
                      onPressed: () {
                        navigateTo(context, WatchlistScreen());
                      },
                    ),
                    _buildOption(
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
                                  onPressed: () {
                                    CacheHelper.removeData(key: 'uId').then((
                                      value,
                                    ) {
                                      if (value == true) {
                                        showSnakeBar(
                                          context: context,
                                          label: 'Logout Successfully',
                                          color: Colors.green,
                                        );
                                      }
                                      cubit.resetCurrentIndex();
                                      cubit.resetUserModel();
                                      cubit.userModel = null;

                                      navigateTo(
                                        context,
                                        GetStartedScreen(),
                                        isReplacement: true,
                                      );
                                    });
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
                          style: GoogleFonts.poppins(
                            color: Colors.redAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
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

  Widget _buildOption({
    required IconData icon,
    required String title,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xff1a1a1a),
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 15),
            Text(
              title,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
            ),
            const Spacer(),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white38,
                size: 16,
              ),
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
