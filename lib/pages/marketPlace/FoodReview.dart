
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../models/marketPlaceModels/FoodModel.dart';
import 'FoodRestaurantsDescription.dart';
import 'utils/FoodDataGenerator.dart';
import 'utils/FoodString.dart';
import 'utils/FoodWidget.dart';

class FoodReview extends StatefulWidget {
  static String tag = '/FoodReview';

  @override
  FoodReviewState createState() => FoodReviewState();
}

class FoodReviewState extends State<FoodReview> {
  late List<ReviewModel> mReviewList;

  @override
  void initState() {
    super.initState();
    mReviewList = addReviewData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context, food_lbl_reviews),
        body: Column(
          children: <Widget>[
            16.height,
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: mReviewList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Review(mReviewList[index], index);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
