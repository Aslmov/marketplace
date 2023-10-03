import 'package:banner_carousel/banner_carousel.dart';

class BannerImages {
  static const String banner1 =
      "lib/models/marketPlaceModels/testFolder/images/champion.jpg";
  static const String banner2 =
      "lib/models/marketPlaceModels/testFolder/images/dauphine.jpeg";
  static const String banner3 =
      "lib/models/marketPlaceModels/testFolder/images/ramco.png";
  static const String banner4 =
      "lib/models/marketPlaceModels/testFolder/images/téléchargement.png";

  static List<BannerModel> listBanners = [
    BannerModel(imagePath: banner1, id: "1"),
    BannerModel(imagePath: banner2, id: "2"),
    BannerModel(imagePath: banner3, id: "3"),
    BannerModel(imagePath: banner4, id: "4"),
  ];
}
