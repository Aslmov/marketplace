import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../models/marketPlaceModels/Categorie_Modal.dart';
import 'package:http/http.dart' as http;

class Categorie with ChangeNotifier {
  List<Categories> _categories = [];

  List<Categories> get categories {
    return [..._categories];
  }

  Future<void> fecthCategories() async {
    try {
      final url =
          Uri.https('www.themealdb.com', '/api/json/v1/1/categories.php');
      final response = await http.get(url);
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      List<Categories> loadedCategories = [];
      if (jsonResponse == null) {
        return;
      }

      (jsonResponse['categories'] as List<dynamic>)
          .map((e) => {
                loadedCategories.add(Categories(
                    idCategory: e['idCategory'],
                    strCategory: e['strCategory'],
                    strCategoryDescription: e['strCategoryDescription'],
                    strCategoryThumb: e['strCategoryThumb']))
              })
          .toList();
      _categories = loadedCategories.reversed.toList();
      notifyListeners();
    } catch (e) {
      print("e.toString() " + e.toString());
      throw (e);
    }
  }
}