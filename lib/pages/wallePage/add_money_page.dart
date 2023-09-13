import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'package:tagxisuperuser/functions/functions.dart';
import 'package:tagxisuperuser/models/recharge.dart';
import 'package:tagxisuperuser/pages/loadingPage/loading.dart';
import 'package:tagxisuperuser/services/paiement_sevice.dart';
import 'package:tagxisuperuser/translations/translation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagxisuperuser/styles/styles.dart';
import 'package:tagxisuperuser/widgets/widgets.dart';
import '../noInternet/noInternet.dart';

class AddMoneyPage extends StatefulWidget {
  const AddMoneyPage({super.key});

  @override
  State<AddMoneyPage> createState() => _AddMoneyPageState();
}

class _AddMoneyPageState extends State<AddMoneyPage> {
  bool _isLoading = false;

  addPayementMethodView() {
    const double height = 70;
    const double width = 100;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: 100,
      child: Row(
        // This next line does the trick.
        // scrollDirection: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Card(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color:
                    selecteMethod == "TMONEY" ? starColor : Colors.transparent,
                width: 1.5,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: InkWell(
              splashColor: starColor,
              onTap: () {
                setState(() {
                  selecteMethod = "TMONEY";
                });
              },
              child: Container(
                width: width,
                height: height,
                child: Image.asset(
                  "assets/images/TMoney.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Card(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.5,
                color:
                    selecteMethod == "Flooz" ? starColor : Colors.transparent,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: InkWell(
              splashColor: starColor,
              onTap: () {
                setState(() {
                  selecteMethod = "Flooz";
                });
              },
              child: Container(
                width: width,
                height: height,
                child: Image.asset(
                  "assets/images/Flooz.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  PaiementService paiement = new PaiementService();
  sendRequest() async {
    setState(() {
      _isLoading = true;
    });
   var rep = await paiement.addRecharge(new Recharge(
          number: selectedNumber, method: selecteMethod, price: selectePrice));
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       content: Text(rep ? "Confirmez le rechargement avec votre code secret." : "Erreur lors du rechargement.") ,
     ));
    setState(() {
      _isLoading = false;
    });
  }

  Map<int, List<String>> Prices = {};
  String selectedNumber = "";
  String selectePrice = "";
  String selecteMethod = "TMONEY";

  Future<void> _dialogBuilder(BuildContext context) async {
    var media = MediaQuery.of(context).size;
    var data = await paiement.getUserNumber();
    List<String> entries = data;
    return showDialog(
      context: context,
      barrierLabel: "Number dialog",
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selectionner un numéro',
              style: GoogleFonts.robotoCondensed(
                  fontSize: media.width * twenty,
                  color: textColor,
                  fontWeight: FontWeight.normal)),
          content: SingleChildScrollView(
            child: Container(
              height: 110,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedNumber = entries[index];
                          numberController.text = selectedNumber;
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                        height: 35,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Center(child: Text(entries[index])),
                      ),
                    );
                  }),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  TextEditingController numberController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
      child: Directionality(
        textDirection: (languageDirection == 'rtl')
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(media.width * 0.05),
                  height: media.height * 1,
                  width: media.width * 1,
                  color: page,
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: MediaQuery.of(context).padding.top),
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: media.width * 0.05),
                                  width: media.width * 1,
                                  alignment: Alignment.center,
                                  child: Text(
                                    languages[choosenLanguage]["text_paiement_title"],
                                    style: GoogleFonts.robotoCondensed(
                                        fontSize: media.width * twenty,
                                        fontWeight: FontWeight.w600,
                                        color: textColor),
                                  ),
                                ),
                                Positioned(
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child:
                                            Icon(Icons.arrow_back, color: textColor)))
                              ],
                            ),
                            SizedBox(
                              height: media.width * 0.05,
                            ),
                            SingleChildScrollView(
                              child: Positioned(
                                  top: 1,
                                  child: SingleChildScrollView(
                                    child: Container(
                                      height: media.height * 0.8,
                                      //color: Colors.red,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Row(children: [
                                                  Text(
                                                      languages[choosenLanguage]
                                                          ["text_paiement_min"],
                                                      style:
                                                          GoogleFonts.robotoCondensed(
                                                              fontSize:
                                                                  media.width *
                                                                      eighteen,
                                                              fontWeight:
                                                                  FontWeight.normal,
                                                              color: textColor)),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text("2050 Fcfa",
                                                      style:
                                                          GoogleFonts.robotoCondensed(
                                                              fontSize:
                                                                  media.width * twenty,
                                                              fontWeight:
                                                                  FontWeight.normal,
                                                              color: textColor)),
                                                ]),
                                              ),
                                              Container(
                                                child: Row(children: [
                                                  Text(
                                                      languages[choosenLanguage]
                                                          ["text_paiement_max"],
                                                      style:
                                                          GoogleFonts.robotoCondensed(
                                                              fontSize:
                                                                  media.width *
                                                                      eighteen,
                                                              fontWeight:
                                                                  FontWeight.normal,
                                                              color: textColor)),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text("2050 Fcfa",
                                                      style:
                                                          GoogleFonts.robotoCondensed(
                                                              fontSize:
                                                                  media.width * twenty,
                                                              fontWeight:
                                                                  FontWeight.normal,
                                                              color: textColor)),
                                                ]),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  languages[choosenLanguage]
                                                      ["text_paiement_from"],
                                                  style: GoogleFonts.robotoCondensed(
                                                      fontSize: media.width * eighteen,
                                                      fontWeight: FontWeight.w200,
                                                      color: textColor)),
                                            ],
                                          ),
                                          addPayementMethodView(),
                                          Row(
                                            children: [
                                              Text(
                                                languages[choosenLanguage]
                                                    ["text_paiement_number"],
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: TextField(
                                                  keyboardType: TextInputType.number,
                                                  controller: numberController,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedNumber = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  _dialogBuilder(context);
                                                },
                                                child: Text(languages[choosenLanguage]
                                                    ["text_paiement_number_choice"]),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                languages[choosenLanguage]
                                                    ["text_paiement_price"],
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: TextField(
                                                  keyboardType: TextInputType.number,
                                                  controller: priceController,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectePrice = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Card(
                                                clipBehavior: Clip.hardEdge,
                                                child: InkWell(
                                                  splashColor: starColor,
                                                  onTap: () {
                                                    selectePrice = "300 Fcfa";
                                                    priceController.text = selectePrice
                                                        .replaceAll(" Fcfa", "");
                                                  },
                                                  child: SizedBox(
                                                    width: media.width / 3.8,
                                                    height: 60,
                                                    child: Center(
                                                        child: Text("300 Fcfa",
                                                            style: GoogleFonts
                                                                .robotoCondensed(
                                                                    fontSize:
                                                                        media.width *
                                                                            eighteen,
                                                                    fontWeight:
                                                                        FontWeight.w200,
                                                                    color: textColor))),
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                clipBehavior: Clip.hardEdge,
                                                child: InkWell(
                                                  splashColor: starColor,
                                                  onTap: () {
                                                    selectePrice = "500 Fcfa";
                                                    priceController.text = selectePrice
                                                        .replaceAll(" Fcfa", "");
                                                  },
                                                  child: SizedBox(
                                                    width: media.width / 3.8,
                                                    height: 60,
                                                    child: Center(
                                                        child: Text("500 Fcfa",
                                                            style: GoogleFonts
                                                                .robotoCondensed(
                                                                    fontSize:
                                                                        media.width *
                                                                            eighteen,
                                                                    fontWeight:
                                                                        FontWeight.w200,
                                                                    color: textColor))),
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                clipBehavior: Clip.hardEdge,
                                                child: InkWell(
                                                  splashColor: starColor,
                                                  onTap: () {
                                                    selectePrice = "1000 Fcfa";
                                                    priceController.text = selectePrice
                                                        .replaceAll(" Fcfa", "");
                                                  },
                                                  child: SizedBox(
                                                    width: media.width / 3.8,
                                                    height: 60,
                                                    child: Center(
                                                        child: Text("1000 Fcfa",
                                                            style: GoogleFonts
                                                                .robotoCondensed(
                                                                    fontSize:
                                                                        media.width *
                                                                            eighteen,
                                                                    fontWeight:
                                                                        FontWeight.w200,
                                                                    color: textColor))),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Card(
                                                clipBehavior: Clip.hardEdge,
                                                child: InkWell(
                                                  splashColor: starColor,
                                                  onTap: () {
                                                    selectePrice = "2000 Fcfa";
                                                    priceController.text = selectePrice
                                                        .replaceAll(" Fcfa", "");
                                                  },
                                                  child: SizedBox(
                                                    width: media.width / 3.8,
                                                    height: 60,
                                                    child: Center(
                                                        child: Text("2000 Fcfa",
                                                            style: GoogleFonts
                                                                .robotoCondensed(
                                                                    fontSize:
                                                                        media.width *
                                                                            eighteen,
                                                                    fontWeight:
                                                                        FontWeight.w200,
                                                                    color: textColor))),
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                clipBehavior: Clip.hardEdge,
                                                child: InkWell(
                                                  splashColor: starColor,
                                                  onTap: () {
                                                    selectePrice = "5000 Fcfa";
                                                    priceController.text = selectePrice
                                                        .replaceAll(" Fcfa", "");
                                                  },
                                                  child: SizedBox(
                                                    width: media.width / 3.8,
                                                    height: 60,
                                                    child: Center(
                                                        child: Text("5000 Fcfa",
                                                            style: GoogleFonts
                                                                .robotoCondensed(
                                                                    fontSize:
                                                                        media.width *
                                                                            eighteen,
                                                                    fontWeight:
                                                                        FontWeight.w200,
                                                                    color: textColor))),
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                clipBehavior: Clip.hardEdge,
                                                child: InkWell(
                                                  splashColor: starColor,
                                                  onTap: () {
                                                    selectePrice = "10000 Fcfa";
                                                    priceController.text = selectePrice
                                                        .replaceAll(" Fcfa", "");
                                                  },
                                                  child: SizedBox(
                                                    width: media.width / 3.8,
                                                    height: 60,
                                                    child: Center(
                                                        child: Text("10000 Fcfa",
                                                            style: GoogleFonts
                                                                .robotoCondensed(
                                                                    fontSize:
                                                                        media.width *
                                                                            eighteen,
                                                                    fontWeight:
                                                                        FontWeight.w200,
                                                                    color: textColor))),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Button(
                                              onTap: () {
                                                sendRequest();
                                                },
                                              text: languages[choosenLanguage]
                                                  ["text_paiement_btn"])
                                        ],
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                      //no internet
                      (internet == false)
                          ? Positioned(
                              top: 0,
                              child: NoInternet(
                                onTap: () {
                                  setState(() {
                                    internetTrue();
                                  });
                                },
                              ))
                          : Container(),
                    ],
                  ),
                ),
                (_isLoading == true)
                    ? const Positioned(child: Loading())
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
