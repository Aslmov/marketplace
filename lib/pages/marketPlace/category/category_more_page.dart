import 'package:flutter/material.dart';

import '../../../models/marketPlaceModels/testFolder/Categorie_Data.dart';

class MoreCategoryPage extends StatelessWidget {
  MoreCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 500,
          width: 500,
          child: ListView.builder(
              itemCount: categoriesList.length,
              itemBuilder: (BuildContext context, int index) {
                Categories category = categoriesList[index];
                return ListTile(
                  leading: Image.asset(
                    category.strCategoryThumb!,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(category.strCategory ?? ''),
                  subtitle: Text(category.strCategoryDescription ?? ''),
                );
              }),
        ),
      ],
    );
  }

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
      isTop: false,
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
      isTop: false,
      idCategory: "6",
      strCategory: "Liqueur",
      strCategoryThumb:
          "lib/models/marketPlaceModels/testFolder/images/Liqueur.jpg",
      strCategoryDescription: "Description 2",
    ),
    Categories(
      isTop: false,
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
      isTop: false,
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
}
