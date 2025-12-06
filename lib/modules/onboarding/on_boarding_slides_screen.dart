import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/onboarding_model.dart';
import '../../shared/components/cards/build_onboarding_card.dart';
import '../../shared/components/utils/function.dart';
import '../../shared/cubit/movies_cubit.dart';
import '../../shared/cubit/movies_states.dart';
import '../../shared/styles/colors.dart';
import 'get_started_screen.dart';

class OnBoardingSlidesScreen extends StatelessWidget {
  const OnBoardingSlidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = MoviesCubit.get(context);
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Scaffold(
            body: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Stack(
                    children: [
                      Image(
                        image: AssetImage('images/auth-background.png'),
                        height: 550.0,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                      Container(
                        height: 550.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              ColorManager.baseColor,
                              ColorManager.baseColor.withOpacity(0.38),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 550.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              ColorManager.baseColor,
                              ColorManager.baseColor.withOpacity(0.0),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                          child: Container(
                            color: Colors.black.withOpacity(0.15),
                          ),
                        ),
                      ),
                      PageView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        controller: cubit.pageController,
                        itemBuilder: (context, index) => BuildOnboardingCard(
                          image: slidesData[index].image,
                          label: slidesData[index].label,
                        ),
                        onPageChanged: (index) {
                          cubit.changeOnBoardingPage(index);
                        },
                        itemCount: slidesData.length,
                        scrollDirection: Axis.horizontal,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 50.0,
                            horizontal: 25.0,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              navigateTo(context, GetStartedScreen());
                            },
                            child: Text('skip', style: style(15.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 30.0,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SmoothPageIndicator(
                            count: slidesData.length,
                            effect: ExpandingDotsEffect(
                              dotColor: ColorManager.white,
                              activeDotColor: ColorManager.red,
                              dotHeight: 15,
                              dotWidth: 15,
                            ),
                            controller: cubit.pageController,
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 70.0,
                          width: 70.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.red,
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: MaterialButton(
                            onPressed: () {
                              if (cubit.isLast) {
                                navigateTo(context, GetStartedScreen());
                              } else {
                                cubit.pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              color: ColorManager.white,
                              size: 27.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
