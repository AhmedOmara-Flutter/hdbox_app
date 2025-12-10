import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hdbox_app/models/user_model.dart';
import 'package:hdbox_app/shared/components/layout/build_full_back.dart';
import 'package:hdbox_app/shared/cubit/movies_cubit.dart';
import 'package:hdbox_app/shared/cubit/movies_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = MoviesCubit.get(context);
    cubit.getUserFromFirebase();
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final model = cubit.userModel;
        return Scaffold(
          body: SingleChildScrollView(
            child: ConditionalBuilder(
              condition: model != null,
              builder: (context) => Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 60, bottom: 15),
                    child: Column(
                      children: [
                        // Profile Image
                        CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage('${model!.image}'),
                        ),
                        const SizedBox(height: 15),
                        // Username
                        Text(
                          "${model.name}",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // Email
                        Text(
                          "${model.email}",
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      _buildOption(icon: Icons.settings, title: "Settings"),
                      _buildOption(icon: Icons.lock, title: "Privacy"),
                      _buildOption(icon: Icons.movie, title: "My Watchlist"),
                      _buildOption(
                        icon: Icons.notifications,
                        title: "Notifications",
                      ),
                      _buildOption(
                        icon: Icons.help_outline,
                        title: "Help & Support",
                      ),
                      const SizedBox(height: 20),
                      // Logout Button
                      Center(
                        child: TextButton(
                          onPressed: () {},
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
              fallback: (context) => BuildFullBack(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOption({required IconData icon, required String title}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xff1a1a1a),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 15),
          Text(
            title,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
          ),
          const Spacer(),
          Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 16),
        ],
      ),
    );
  }
}
