import 'package:tagxisuperuser/models/marketPlaceModels/testFolder/Categorie_Data.dart';

void main() {
  // Créez une liste d'objets Categories
  List<Categories> categoriesList = [
    Categories(
      isTop: true,
      idCategory: "1",
      strCategory: "Restaurant",
      strCategoryThumb:
          "lib/models/marketPlaceModels/testFolder/images/Restaurant.jpg",
      strCategoryDescription: "Description 1",
    ),
    Categories(
      isTop: false,
      idCategory: "2",
      strCategory: "Supermarché",
      strCategoryThumb:
          "lib/models/marketPlaceModels/testFolder/images/Supermarché.jpg",
      strCategoryDescription: "Description 2",
    ),
    Categories(
      isTop: true,
      idCategory: "3",
      strCategory: "Electronique",
      strCategoryThumb:
          "lib/models/marketPlaceModels/testFolder/images/Electronique.jpg",
      strCategoryDescription: "Description 2",
    ),
    Categories(
      isTop: false,
      idCategory: "4",
      strCategory: "Produits Bio",
      strCategoryThumb:
          "lib/models/marketPlaceModels/testFolder/images/ProduitsBio.jpg",
      strCategoryDescription: "Description 2",
    ),
    Categories(
      isTop: false,
      idCategory: "5",
      strCategory: "Cosmétique",
      strCategoryThumb:
          "lib/models/marketPlaceModels/testFolder/images/Cosmétique.jpg",
      strCategoryDescription: "Description 2",
    ),
    Categories(
      isTop: true,
      idCategory: "6",
      strCategory: "Liqueur",
      strCategoryThumb:
          "lib/models/marketPlaceModels/testFolder/images/Liqueur.jpg",
      strCategoryDescription: "Description 2",
    ),
    Categories(
      isTop: true,
      idCategory: "7",
      strCategory: "Parfumerie",
      strCategoryThumb:
          "lib/models/marketPlaceModels/testFolder/images/Outillage.jpg",
      strCategoryDescription: "Description 2",
    ),
    Categories(
      isTop: false,
      idCategory: "8",
      strCategory: "Outillage",
      strCategoryThumb:
          "lib/models/marketPlaceModels/testFolder/images/Outillage.jpg",
      strCategoryDescription: "Description 2",
    ),
    Categories(
      isTop: true,
      idCategory: "9",
      strCategory: "Animalerie",
      strCategoryThumb:
          "lib/models/marketPlaceModels/testFolder/images/Animalerie.jpg",
      strCategoryDescription: "Description 2",
    ),
    Categories(
      isTop: false,
      idCategory: "10",
      strCategory: "Téléphonie",
      strCategoryThumb:
          "lib/models/marketPlaceModels/testFolder/images/Téléphonie.jpg",
      strCategoryDescription: "Description 2",
    ),
  ];

  List<Map<String, dynamic>> jsonList =
      categoriesList.map((category) => category.toJson()).toList();

  print(jsonList);
}
