import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../models/marketPlaceModels/BeneficiaryCategorie_Model.dart';
import '../../models/marketPlaceModels/Controler/Categorie_Data.dart';



class CategorieBox extends StatelessWidget {
  const CategorieBox({
    Key? key,
    required this.BoxTitle,
    required this.onPressed,
  }) : super(key: key);

  final String BoxTitle;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BeneficiaryCategorie>>(
      future: CategorieData.GetCategories(),
      builder: (context, snapshot) {
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
                    snapshot.hasData
                        ? Text(BoxTitle, style: boldTextStyle(size: 25)
                            // style: const TextStyle(
                            //   color: Colors.black,
                            //   fontSize: 18,
                            //   fontWeight: FontWeight.w900,
                            //
                            // ),

                            )
                        : Container(
                            height: 15,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.grey.shade300,
                            ),
                          ),
                    snapshot.hasData
                        ? TextButton(
                            onPressed: onPressed,
                            child: const Text(
                              'Voir Tout',
                              style: TextStyle(
                                color: Color(0xffC3211A),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : Container(
                            height: 15,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.grey.shade300,
                            ),
                          )
                  ],
                ),
              ),
              SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 11,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => MealsByCategotrieScreen(
                        //         categoryname:
                        //             snapshot.data![index].strCategory!,
                        //         filterType: 'Categorie',
                        //       ),
                        //     ));
                      },
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
                                // decoration: BoxDecoration(
                                //   color: snapshot.hasData
                                //       ? Colors.white
                                //       : Colors.grey.shade300,
                                //   borderRadius: BorderRadius.circular(7),
                                //   image: snapshot.hasData
                                //       ? DecorationImage(
                                //           // image: NetworkImage(
                                //           //  // snapshot.data![index].strCategoryThumb!,
                                //           // ),
                                //           fit: BoxFit.contain)
                                //       : null,
                                // ),
                              ),
                            ),
                            /* Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: snapshot.hasData
                                  ? Text(
                                      snapshot.data![index].value!,
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
                            ),*/
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
