class OnBoardingModel {
  final String image;
  final String label;

  OnBoardingModel({required this.image, required this.label});
}

List<OnBoardingModel> slidesData = [
  OnBoardingModel(
    image: 'onboarding1-portrait.png',
    label: 'We have the best\n show always',
  ),
  OnBoardingModel(
    image: 'onboarding2-portrait.png',
    label: 'Stream the best\nshows instantly',
  ),
  OnBoardingModel(
    image: 'onboarding3-portrait.png',
    label: 'Discover and enjoy\n without limits',
  ),
];
