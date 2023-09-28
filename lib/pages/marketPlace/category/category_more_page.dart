import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:tagxisuperuser/functions/functions.dart';
import 'package:tagxisuperuser/pages/marketPlace/utils/provider/category_data.dart';
import 'package:tagxisuperuser/translations/translation.dart';

class CategoryMorePage extends StatefulWidget {
  const CategoryMorePage({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryMorePage> createState() => _CategorieBoxState();
}

class _CategorieBoxState extends State<CategoryMorePage> {
  @override
  void didChangeDependencies() {
    context.read<Categorie>().fecthCategories();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final categorieData = context.watch<Categorie>();
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    categorieData.categories.isNotEmpty
                        ? Text(
                            languages[choosenLanguage]['text_categories_resto'],
                            style: boldTextStyle(size: 25))
                        : Container(
                            height: 15,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.grey.shade300,
                            ),
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categorieData.categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 100,
                        alignment: Alignment.center,
                        margin:
                            const EdgeInsets.only(left: 15, top: 5, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffC3211A),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 2),
                                blurRadius: 5,
                                color: Color.fromARGB(117, 0, 0, 0),
                              )
                            ]),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 3, left: 3, right: 3, bottom: 7),
                                decoration: BoxDecoration(
                                  color: categorieData.categories.isNotEmpty
                                      ? Colors.white
                                      : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(7),
                                  image: categorieData.categories.isNotEmpty
                                      ? DecorationImage(
                                          image: NetworkImage(
                                            categorieData.categories[index]
                                                .strCategoryThumb!,
                                          ),
                                          fit: BoxFit.contain)
                                      : null,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: categorieData.categories.isNotEmpty
                                  ? Text(
                                      categorieData
                                          .categories[index].strCategory!,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    )
                                  : Container(
                                      height: 15,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
