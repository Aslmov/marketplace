class Categories {
  bool? isTop;
  String? idCategory;
  String? strCategory;
  String? strCategoryThumb;
  String? strCategoryDescription;

  Categories(
      {this.isTop,
      this.idCategory,
      this.strCategory,
      this.strCategoryThumb,
      this.strCategoryDescription});

  Categories.fromJson(Map<String, dynamic> json) {
    isTop = json["isTop"];
    idCategory = json['idCategory'];
    strCategory = json['strCategory'];
    strCategoryThumb = json['strCategoryThumb'];
    strCategoryDescription = json['strCategoryDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["isTop"] = this.isTop;
    data['idCategory'] = this.idCategory;
    data['strCategory'] = this.strCategory;
    data['strCategoryThumb'] = this.strCategoryThumb;
    data['strCategoryDescription'] = this.strCategoryDescription;
    return data;
  }
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
    isTop: true,
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
    isTop: true,
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
    isTop: true,
    idCategory: "10",
    strCategory: "Téléphonie",
    strCategoryThumb:
        "lib/models/marketPlaceModels/testFolder/images/Téléphonie.jpg",
    strCategoryDescription: "Description 2",
  ),
];
