import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tagxisuperuser/models/marketPlaceModels/testFolder/Categorie_Data.dart';
import 'package:tagxisuperuser/styles/styles.dart';
import '../../functions/functions.dart';
import '../../models/marketPlaceModels/FoodModel.dart';
import '../../translations/translation.dart';
import 'FoodAddAddress.dart';
import 'FoodBookCart.dart';
import 'FoodDescription.dart';
import 'FoodFavourite.dart';
import 'FoodOrder.dart';
import 'FoodProfile.dart';
import 'FoodSignIn.dart';
import 'FoodViewRestaurants.dart';
import 'utils/FoodColors.dart';
import 'utils/FoodDataGenerator.dart';
import 'utils/FoodImages.dart';
import 'utils/FoodString.dart';
import 'utils/FoodWidget.dart';

class FoodDashboard extends StatefulWidget {
  static String tag = '/FoodDashboard';

  @override
  FoodDashboardState createState() => FoodDashboardState();
}

class FoodDashboardState extends State<FoodDashboard> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late List<DashboardCollections> mCollectionList;
  late List<Restaurants> mBakeryList;
  late List<Restaurants> mDeliveryList;
  late List<Restaurants> mDineOutList;
  late List<DashboardCollections> mExperienceList;
  late List<Restaurants> mCafeList;

  @override
  void initState() {
    super.initState();
    mCollectionList = addCollectionData();
    mBakeryList = addBakeryData();
    mDeliveryList = addDeliveryRestaurantsData();
    mDineOutList = addDineOutRestaurantsData();
    mExperienceList = addCuisineData();
    mCafeList = addCafeData();
  }

  @override
  Widget build(BuildContext context) {
    final FloatingSearchBarController controller =
        FloatingSearchBarController();
    changeStatusColor(isDarkTheme ? black : white);

    Widget topGradient(var gradientColor1, var gradientColor2, var icon,
        var heading, var subHeading) {
      var width = MediaQuery.of(context).size.width;
      return GestureDetector(
        onTap: () {
          FoodViewRestaurants().launch(context);
        },
        child: Container(
          decoration: gradientBoxDecoration(
              showShadow: true,
              gradientColor1: gradientColor1,
              gradientColor2: gradientColor2),
          padding: EdgeInsets.all(10),
          child: (Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SvgPicture.asset(icon,
                  color: food_white, width: width * 0.06, height: width * 0.06),
              Text(heading, style: primaryTextStyle(color: food_white)),
              Text(
                subHeading,
                style: primaryTextStyle(color: food_white, size: 12),
              ),
            ],
          )),
        ),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              // Market place header
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(food_app_name, style: boldTextStyle(size: 18)),
                    IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        FoodBookCart().launch(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Intégration de la FloatingSearchBar
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                height: 54,
                child: FloatingSearchBar(
                  controller: controller,
                  hint: 'Recherchez : Ramco, Slatpizz ...',
                  openAxisAlignment: 0.0,
                  width: 600,
                  axisAlignment: 0.0,
                  scrollPadding: EdgeInsets.only(top: 16, bottom: 20),
                  elevation: 4.0,
                  physics: BouncingScrollPhysics(),
                  onQueryChanged: (query) {},
                  actions: [
                    FloatingSearchBarAction.searchToClear(),
                  ],
                  builder: (context, transition) {
                    return Container(
                      margin: EdgeInsets.only(top: 65),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 4,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: Text('Résultat de la recherche 1'),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text('Résultat de la recherche 2'),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: defaultBoxShadow(),
                          color: context.cardColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          heading(
                              languages[choosenLanguage]
                                  ['text_front_page_resto'],
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Voir Tout',
                                  style: TextStyle(
                                    color: Color(0xffC3211A),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 250,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: mCollectionList.length,
                              padding: EdgeInsets.only(right: 10),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Collection(
                                    mCollectionList[index], index);
                              },
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: defaultBoxShadow(),
                          color: context.cardColor),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          //mAddress(context),
                          SizedBox(height: 16),
                          //AdsBox(revere: false),
                          _showCategoryCards(context),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Catégories'),
          content: Container(
            height: 400,
            width: 600,
            child: ListView.builder(
              itemCount: categoriesList.length,
              itemBuilder: (BuildContext context, int index) {
                Categories category = categoriesList[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(550),
                    child: Image.asset(
                      category.strCategoryThumb!,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  title: Text(category.strCategory ?? ''),
                  subtitle: Text(category.strCategoryDescription ?? ''),
                );
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  Widget _showCategoryCards(BuildContext context) {
    final topCategories =
        categoriesList.where((category) => category.isTop == true).toList();
    final cardWidth = 160.0; // Largeur fixe de chaque carte
    final cardSpacing = 16.0; // Espacement entre les cartes

    return Container(
      height: 200, // Ajustez la hauteur selon vos besoins
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  _showCategoryDialog(context);
                },
                child: const Text(
                  'Voir Tout',
                  style: TextStyle(
                    color: Color(0xffC3211A),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 8, // Ajoutez de l'espace entre le bouton et les cartes
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: topCategories.asMap().entries.map((entry) {
                final index = entry.key;
                final category = entry.value;

                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 0 : cardSpacing),
                  child: SizedBox(
                    width: cardWidth,
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10.0),
                            ),
                            child: Image.asset(
                              category.strCategoryThumb!,
                              width: cardWidth,
                              height: 64,
                              fit: BoxFit.cover,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              category.strCategory ?? '',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Item extends StatelessWidget {
  late Restaurants model;

  Item(Restaurants model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FoodDescription().launch(context);
      },
      child: Container(
        width: width * 0.4,
        margin: EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
            boxShadow: defaultBoxShadow(),
            color: isDarkTheme ? scaffoldDarkColor : white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              child: Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    placeholder: placeholderWidgetFn() as Widget Function(
                        BuildContext, String)?,
                    imageUrl: model.image,
                    height: width * 0.2,
                    width: width * 0.4,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.favorite_border,
                        color: food_white, size: 18),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(model.name, style: primaryTextStyle(), maxLines: 2),
                  4.height,
                  Row(
                    children: <Widget>[
                      mRating(model.rating.toString()),
                      Text(
                        model.review,
                        style: primaryTextStyle(
                            color: food_textColorSecondary, size: 14),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Collection extends StatelessWidget {
  late DashboardCollections model;

  Collection(DashboardCollections model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FoodViewRestaurants().launch(context);
      },
      child: Container(
        margin: EdgeInsets.only(left: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                placeholder: placeholderWidgetFn() as Widget Function(
                    BuildContext, String)?,
                imageUrl: model.image,
                width: width * 0.5,
                height: 250,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(model.name,
                      style: primaryTextStyle(
                          size: 20, fontFamily: 'Andina', color: white)),
                  SizedBox(height: 4),
                  Text(model.info,
                      style: primaryTextStyle(size: 14, color: food_white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodSideMenu extends StatefulWidget {
  @override
  FoodSideMenuState createState() => FoodSideMenuState();
}

class FoodSideMenuState extends State<FoodSideMenu> {
  Widget mOption(
      var gradientColor1, var gradientColor2, var icon, var value, var tags) {
    return GestureDetector(
      onTap: () {
        finish(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => tags));
//         launchScreen(context, tags);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [gradientColor1, gradientColor2]),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(icon, size: 18, color: food_white),
              ),
            ),
            SizedBox(width: 16),
            Text(
              value,
              style: primaryTextStyle(),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var mView = Container(
        width: MediaQuery.of(context).size.width,
        height: 0.5,
        color: food_view_color);

    return SafeArea(
      child: SizedBox(
        width: width * 0.85,
        height: MediaQuery.of(context).size.height,
        child: Drawer(
          elevation: 8,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  width: width,
                  decoration: gradientBoxDecoration(
                      gradientColor1: food_colorPrimary,
                      gradientColor2: food_colorPrimary,
                      radius: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(food_ic_user1),
                          radius: 40),
                      Text(food_username,
                          style: primaryTextStyle(color: food_white)),
                      Text(food_user_email,
                          style: primaryTextStyle(color: white))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 24, 16),
                  child: Column(
                    children: <Widget>[
                      mOption(
                          food_color_blue_gradient1,
                          food_color_blue_gradient2,
                          Icons.favorite_border,
                          food_lbl_favourite,
                          FoodFavourite()),
                      mOption(
                          food_color_orange_gradient1,
                          food_color_orange_gradient2,
                          Icons.add,
                          food_lbl_add_address,
                          FoodAddAddress()),
                      mOption(
                          food_color_yellow_gradient1,
                          food_color_yellow_gradient2,
                          Icons.insert_drive_file,
                          food_lbl_orders,
                          FoodOrder()),
                      mOption(
                          food_color_blue_gradient1,
                          food_color_blue_gradient2,
                          Icons.person_outline,
                          food_lbl_profile,
                          FoodProfile()),
                      Container(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          food_color_orange_gradient1,
                                          food_color_orange_gradient2
                                        ]),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Image.asset('images/ic_theme.png',
                                        height: 24,
                                        width: 24,
                                        color: food_white),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Text(
                                  'Dark Mode',
                                  style: primaryTextStyle(),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      mOption(
                          food_color_yellow_gradient1,
                          food_color_yellow_gradient2,
                          Icons.settings_power,
                          food_lbl_logout,
                          FoodSignIn()),
                    ],
                  ),
                ),
                mView,
                Container(
                  width: width,
                  padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(food_lbl_quick_searches, style: primaryTextStyle()),
                      Text(food_lbl_cafe,
                          style:
                              primaryTextStyle(color: food_textColorSecondary)),
                      Text(food_hint_search_restaurants,
                          style:
                              primaryTextStyle(color: food_textColorSecondary)),
                      Text(food_lbl_bars,
                          style:
                              primaryTextStyle(color: food_textColorSecondary)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
