import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hdbox_app/shared/cubit/movies_cubit.dart';
import '../../layout/movies_homeLayout.dart';
import '../../shared/components/utils/function.dart';
import '../../shared/styles/colors.dart';
import '../onboarding/on_boarding_slides_screen.dart';

class SplashScreen extends StatefulWidget {
  final String uId;

  const SplashScreen({super.key, required this.uId});

  @override
  State<SplashScreen> createState() => _HDSplashScreenState();
}

class _HDSplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();

    //todo خلي بالك من دي
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var cubit = MoviesCubit.get(context);
       Future.wait([
        cubit.getTrendingData(),
        cubit.getPopularData(),
        cubit.getUpComingData(),
        cubit.getTopRatedData(),
        if(widget.uId.isNotEmpty)
        cubit.getWatchList(), // مهم جدا للـ My List icon
      ]);


      // todo ودي كمان من غيرها emulator مش هيشتغل
      if (!mounted) return;
      Future.delayed(Duration(milliseconds: 4000), () {
        if (widget.uId.isNotEmpty) {
          navigateTo(context, MoviesHomeLayout(), isReplacement: true);
        } else {
          navigateTo(context, OnBoardingSlidesScreen(), isReplacement: true);
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: ColorManager.baseColor,
        body: Center(
          child: FadeTransition(
            opacity: _animation,
            child: Stack(
              //mainAxisSize: MainAxisSize.min,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'images/auth-background.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(color: Colors.black.withOpacity(0.4)),
                  ),
                ),

                // Dark Overlay
                Container(color: Colors.black.withOpacity(0.6)),
                // App Logo
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/hd.png", width: 120, height: 120),
                      const SizedBox(height: 20),
                      // AnimatedTextKit(
                      //   animatedTexts: [
                      //     WavyAnimatedText(
                      //       'HD Box',
                      //       textStyle: TextStyle(
                      //         fontSize: 28.0,
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.white,
                      //         letterSpacing: 1.2,
                      //       ),
                      //       speed: Duration(milliseconds: 200),
                      //       // speed: Duration(milliseconds: 500),
                      //     ),
                      //   ],
                      // ),
                      Text(
                        'HD Box',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),

                      SizedBox(height: 8),

                      // Subtitle
                      FadeAnimatedTextKit(
                        text: ["Watch Anything.", "Anytime."],
                        textStyle: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                        repeatForever: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
