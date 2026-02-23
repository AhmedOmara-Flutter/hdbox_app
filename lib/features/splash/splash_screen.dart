import 'dart:ui';

import 'package:hdbox_app/core/helpers/app_imports.dart';

class SplashScreen extends StatefulWidget {
  final String uId;
  final bool isSeen ;

  const SplashScreen({super.key, required this.uId, required this.isSeen});

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var cubit = MoviesCubit.get(context);
       Future.wait([
        cubit.getTrendingData(),
        cubit.getPopularData(),
        cubit.getUpComingData(),
        cubit.getTopRatedData(),
        if (widget.uId.isNotEmpty) cubit.getWatchList(),
      ]);
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
