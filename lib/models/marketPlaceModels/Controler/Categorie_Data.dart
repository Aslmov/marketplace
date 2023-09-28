// ignore_for_file: file_names, non_constant_identifier_names, unused_local_variable
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import '../BeneficiaryCategorie_Model.dart';
import '../Categorie_Modal.dart'; 
import '../BeneficiaryCategorie_Model.dart';
class CategorieData {
  static Future<List<BeneficiaryCategorie>> GetCategories() async {
    var response = await Dio()
        .get('https://www.themealdb.com/api/json/v1/1/categories.php');

    return (response.data['categories'] as List)
        .map((e) => BeneficiaryCategorie.fromJson(e))
        .toList();
  }

  static Future<List<String>> GetCategorieTitle() async {
    var response = await Dio()
        .get('Get: http://wari:5050/api/Marketplace/BeneficiaryCategories');

    List<String> CategorieTitleList = [];
    for (int i = 0; i < response.data['categories'].length; i++) {
      CategorieTitleList.add(response.data['categories'][i]['strCategory']);
    }

    return CategorieTitleList;
  }
}



// class Categorie{
//   static Future<List<BeneficiaryCategorie>> GetCategories() async {
//     Response  response = await Dio()
//         .get('http://wari:5050/api/Marketplace/BeneficiaryCategories');
//
//     return (response.data['categories'] as List)
//         .map((e) => BeneficiaryCategorie.fromJson(e))
//         .toList();
//   }
//
//   static Future<List<String>> GetCategorieTitle() async {
//     Response response = await Dio()
//         .get('Get: http://wari:5050/api/Marketplace/BeneficiaryCategories');
//
//     List<String> CategorieTitleList = [];
//     for (int i = 0; i < response.data['categories'].length; i++) {
//       CategorieTitleList.add(response.data['categories'][i]['strCategory']);
//     }
//
//     return CategorieTitleList;
//   }
// }