import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tagxisuperuser/styles/styles.dart';
import '../../functions/functions.dart';
import '../../models/marketPlaceModels/FoodModel.dart';
import '../../translations/translation.dart';
import 'Categorie_Box.dart';
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

    Widget buildFloatingSearchBar() {
      final isPortrait =
          MediaQuery.of(context).orientation == Orientation.portrait;

      return FloatingSearchBar(
        hint: 'Search...',
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        width: isPortrait ? 600 : 500,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: (query) {
          // Call your model, bloc, controller here.
        },
        // Specify a custom transition to be used for
        // animating between opened and closed stated.
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: CircularButton(
              icon: const Icon(Icons.place),
              onPressed: () {},
            ),
          ),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
        ],
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: Colors.accents.map((color) {
                  return Container(height: 112, color: color);
                }).toList(),
              ),
            ),
          );
        },
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: defaultBoxShadow(),
                          color: context.cardColor),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          //mAddress(context),
                          SizedBox(height: 16),
                          SizedBox(height: 16),
                          //AdsBox(revere: false),
                          CategorieBox(
                            BoxTitle: languages[choosenLanguage]
                                    ['text_categories_resto']
                                .toUpperCase(),
                            onPressed: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (BuildContext context) =>
                              //     const CategorieScreen()));
                            },
                          ),
                          // Row(
                          //   children: <Widget>[
                          //     Expanded(
                          //       child: topGradient(
                          //         food_color_blue_gradient1,
                          //         food_color_blue_gradient2,
                          //         food_cloche,
                          //         food_lbl_food_order,
                          //         food_lbl_find_near_by_restaurants,
                          //       ),
                          //       flex: 1,
                          //     ),
                          //     SizedBox(width: 10),
                          //     Expanded(
                          //       child: topGradient(
                          //         food_color_orange_gradient1,
                          //         food_color_orange_gradient2,
                          //         food_ic_table,
                          //         food_lbl_book_a_table,
                          //         food_lbl_may_take_upto_3_mins,
                          //       ),
                          //       flex: 1,
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: defaultBoxShadow(),
                          color: context.cardColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          heading(
                            languages[choosenLanguage]['text_front_page_resto'],
                          ),
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
                    SizedBox(height: 16),
                    // Container(
                    //   decoration: BoxDecoration(boxShadow: defaultBoxShadow(), color: context.cardColor),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: <Widget>[
                    //       heading(food_lbl_cake_ice_cream_and_bakery),
                    //       SizedBox(
                    //         height: 250,
                    //         child: ListView.builder(
                    //           scrollDirection: Axis.horizontal,
                    //           itemCount: mBakeryList.length,
                    //           padding: EdgeInsets.only(bottom: 4, right: 16),
                    //           shrinkWrap: true,
                    //           itemBuilder: (context, index) {
                    //             return Item(mBakeryList[index], index);
                    //           },
                    //         ),
                    //       ),
                    //       mViewAll(context, food_lbl_view_all_restaurants, onTap: () {
                    //         FoodViewRestaurants().launch(context);
                    //       }),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: defaultBoxShadow(),
                          color: context.cardColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          heading(
                            languages[choosenLanguage]['text_Restourants'],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: SizedBox(
                              height: 155,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.only(bottom: 4, right: 16),
                                itemCount: mDeliveryList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Item(mDeliveryList[index], index);
                                },
                              ),
                            ),
                          ),
                          mViewAll(context,
                              languages[choosenLanguage]['text_see_all_resto'],
                              onTap: () {
                            FoodViewRestaurants().launch(context);
                          }),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: defaultBoxShadow(),
                          color: context.cardColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          heading(
                              languages[choosenLanguage]['text_see_all_resto']),
                          SizedBox(
                            height: 155,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: mDineOutList.length,
                              padding: EdgeInsets.only(bottom: 4, right: 16),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Item(mDineOutList[index], index);
                              },
                            ),
                          ),
                          mViewAll(context,
                              languages[choosenLanguage]['text_see_all_resto'],
                              onTap: () {
                            FoodViewRestaurants().launch(context);
                          }),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: defaultBoxShadow(),
                          color: context.cardColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          heading(languages[choosenLanguage]
                              ['text_experience_your_favourite_cuisine_resto']),
                          SizedBox(
                            height: 250,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.only(right: 16),
                              itemCount: mExperienceList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Collection(
                                    mExperienceList[index], index);
                              },
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: defaultBoxShadow(),
                          color: context.cardColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          heading(
                              languages[choosenLanguage]['text_Cafe_resto']),
                          SizedBox(
                            height: 155,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.only(bottom: 4, right: 16),
                              itemCount: mCafeList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Item(mCafeList[index], index);
                              },
                            ),
                          ),
                          mViewAll(context,
                              languages[choosenLanguage]['text_see_all_resto'],
                              onTap: () {
                            FoodViewRestaurants().launch(context);
                          }),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      //drawer: FoodSideMenu(),
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
