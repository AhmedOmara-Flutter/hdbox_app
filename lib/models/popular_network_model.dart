class PopularNetworkModel {
  final String image;
  final String title;
  final int networkId;

  PopularNetworkModel({
    required this.networkId,
    required this.image,
    required this.title,
  });
}

List<PopularNetworkModel> popularNetworkModel = [
  PopularNetworkModel(
    image: 'images/netflix.jpg',
    title: 'Netflix',
    networkId: 213,
  ),
  PopularNetworkModel(
    image: 'images/apple_tv.jpg',
    title: 'Apple TV+',
    networkId: 2552,
  ),
  PopularNetworkModel(
    image: 'images/prime_video.jpg',
    title: 'Amazon',
    networkId: 1024,
  ),
  PopularNetworkModel(image: 'images/hulu.jpg', title: 'Hulu', networkId: 453),
  PopularNetworkModel(
    image: 'images/disney.jpg',
    title: 'Disney+',
    networkId: 2739,
  ),
  PopularNetworkModel(image: 'images/hbo.jpg', title: 'HBO', networkId: 49),
];
