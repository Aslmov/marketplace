import 'package:flutter/material.dart';
import 'package:tagxisuperuser/functions/functions.dart';
import 'package:tagxisuperuser/models/recharge.dart';
import 'package:tagxisuperuser/pages/loadingPage/loading.dart';
import 'package:tagxisuperuser/pages/onTripPage/map_page.dart';
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
  bool showError = false;
  bool numCheck = false;

  String telIndicator = "TMONEY";

  @override
  void initState() {
    getCountryCode();
    countryCode();
    super.initState();
  }

  countryCode() async {
    await getCountryCode();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  addPayementMethodView() {
    const double height = 62;
    const double width = 72;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      height: 72,
      child: Row(
        // This next line does the trick.
        // scrollDirection: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Card(
            child: InkWell(
              splashColor: starColor,
              onTap: () {
                setState(() {
                  telIndicator = "TMONEY";
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
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: starColor,
              onTap: () {
                setState(() {
                  telIndicator = "FLOOZ";
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

  sendRequest() async {
    setState(() {
      _isLoading = true;
    });

    var rep = await paiement.addRecharge(new Recharge(
        number: selectedNumber, method: telIndicator, price: selectePrice));

    setState(() {
      _isLoading = false;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(rep
              ? languages[choosenLanguage]
                  ["text_wallet_loading_confirmation_title"]
              : languages[choosenLanguage]["text_wallet_loading_error_title"]),
          content: Text(rep
              ? languages[choosenLanguage]["text_wallet_loading_confirmation"]
              : languages[choosenLanguage]),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Maps()));
              },
            ),
          ],
        );
      },
    );
  }

  PaiementService paiement = new PaiementService();

  /* sendRequest() async {
    setState(() {
      _isLoading = true;
    });
    var rep = await paiement.addRecharge(new Recharge(
        number: selectedNumber, method: "Moov", price: selectePrice));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(rep
          ? "Confirmez le rechargement avec votre code secret."
          : "Erreur lors du rechargement."),
    ));
    setState(() {
      _isLoading = false;
    });
  }
*/
  Map<int, List<String>> Prices = {};
  String selectedNumber = "";
  String selectePrice = "";
  String selecteMethod = "TMONEY";

//Selectionner un numero enregistrer
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
              child: Text(languages[choosenLanguage]["text_cancel"]),
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
                            SizedBox(
                                height: MediaQuery.of(context).padding.top),
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      bottom: media.width * 0.02),
                                  width: media.width * 1,
                                  alignment: Alignment.center,
                                  child: Text(
                                    languages[choosenLanguage]
                                        ["text_paiement_title"],
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
                                        child: Icon(Icons.arrow_back,
                                            color: textColor)))
                              ],
                            ),
                            SizedBox(
                              height: media.width * 0.05,
                            ),
                            SingleChildScrollView(
                              child: SingleChildScrollView(
                                child: Container(
                                  height: media.height * 0.8,
                                  //color: Colors.red,
                                  child: Column(
                                    children: [
                                      Center(
                                        child: SizedBox(
                                          width: 280,
                                          height: 150,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                      languages[choosenLanguage]
                                                          [
                                                          "text_paiement_from"],
                                                      style: GoogleFonts
                                                          .robotoCondensed(
                                                              fontSize:
                                                                  media.width *
                                                                      eighteen,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  textColor)),
                                                ),
                                                addPayementMethodView(),
                                              ]),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                languages[choosenLanguage]
                                                    ["text_paiement_number"],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: textColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 240, 240, 240),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    prefixIcon: Image.network(
                                                      "https:\/\/gochap.app\/images\/country\/flags\/TG.png",
                                                    ),
                                                  ),
                                                  controller: numberController,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      if (value.length > 8) {
                                                        numberController.text =
                                                            value.substring(
                                                                0, 8);
                                                        numberController
                                                                .selection =
                                                            TextSelection
                                                                .fromPosition(
                                                          TextPosition(
                                                              offset: 8),
                                                        );
                                                      }
                                                      selectedNumber = value;
                                                      showError =
                                                          value.length < 8;
                                                    });
                                                    if (value.length == 8) {
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (showError) 
                                            Text(
                                              'La longueur doit être de 8 chiffres',
                                              style: TextStyle(
                                                color: Colors.red,
                                                // Autres styles de texte si nécessaire
                                              ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                languages[choosenLanguage]
                                                    ["text_paiement_price"],
                                                textAlign: TextAlign.start,
                                                style:
                                                    TextStyle(color: textColor),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 240, 240, 240),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0), // Border radius
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: priceController,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectePrice = value;
                                                  });
                                                },
                                              ),
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
                                            color: page,
                                            clipBehavior: Clip.hardEdge,
                                            child: InkWell(
                                              splashColor: starColor,
                                              onTap: () {
                                                selectePrice = "300 Fcfa";
                                                priceController.text =
                                                    selectePrice.replaceAll(
                                                        " Fcfa", "");
                                              },
                                              child: SizedBox(
                                                width: media.width / 3.8,
                                                height: 60,
                                                child: Center(
                                                    child: Text("300 Fcfa",
                                                        style: GoogleFonts
                                                            .robotoCondensed(
                                                                fontSize: media
                                                                        .width *
                                                                    eighteen,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200,
                                                                color:
                                                                    textColor))),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            color: page,
                                            clipBehavior: Clip.hardEdge,
                                            child: InkWell(
                                              splashColor: starColor,
                                              onTap: () {
                                                selectePrice = "500 Fcfa";
                                                priceController.text =
                                                    selectePrice.replaceAll(
                                                        " Fcfa", "");
                                              },
                                              child: SizedBox(
                                                width: media.width / 3.8,
                                                height: 60,
                                                child: Center(
                                                    child: Text("500 Fcfa",
                                                        style: GoogleFonts
                                                            .robotoCondensed(
                                                                fontSize: media
                                                                        .width *
                                                                    eighteen,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200,
                                                                color:
                                                                    textColor))),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            color: page,
                                            clipBehavior: Clip.hardEdge,
                                            child: InkWell(
                                              splashColor: starColor,
                                              onTap: () {
                                                selectePrice = "1000 Fcfa";
                                                priceController.text =
                                                    selectePrice.replaceAll(
                                                        " Fcfa", "");
                                              },
                                              child: SizedBox(
                                                width: media.width / 3.8,
                                                height: 60,
                                                child: Center(
                                                    child: Text("1000 Fcfa",
                                                        style: GoogleFonts
                                                            .robotoCondensed(
                                                                fontSize: media
                                                                        .width *
                                                                    eighteen,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200,
                                                                color:
                                                                    textColor))),
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
                                            color: page,
                                            clipBehavior: Clip.hardEdge,
                                            child: InkWell(
                                              splashColor: starColor,
                                              onTap: () {
                                                selectePrice = "2000 Fcfa";
                                                priceController.text =
                                                    selectePrice.replaceAll(
                                                        " Fcfa", "");
                                              },
                                              child: SizedBox(
                                                width: media.width / 3.8,
                                                height: 60,
                                                child: Center(
                                                    child: Text("2000 Fcfa",
                                                        style: GoogleFonts
                                                            .robotoCondensed(
                                                                fontSize: media
                                                                        .width *
                                                                    eighteen,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200,
                                                                color:
                                                                    textColor))),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            color: page,
                                            clipBehavior: Clip.hardEdge,
                                            child: InkWell(
                                              splashColor: starColor,
                                              onTap: () {
                                                selectePrice = "5000 Fcfa";
                                                priceController.text =
                                                    selectePrice.replaceAll(
                                                        " Fcfa", "");
                                              },
                                              child: SizedBox(
                                                width: media.width / 3.8,
                                                height: 60,
                                                child: Center(
                                                    child: Text("5000 Fcfa",
                                                        style: GoogleFonts
                                                            .robotoCondensed(
                                                                fontSize: media
                                                                        .width *
                                                                    eighteen,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200,
                                                                color:
                                                                    textColor))),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            color: page,
                                            clipBehavior: Clip.hardEdge,
                                            child: InkWell(
                                              splashColor: starColor,
                                              onTap: () {
                                                selectePrice = "10000 Fcfa";
                                                priceController.text =
                                                    selectePrice.replaceAll(
                                                        " Fcfa", "");
                                              },
                                              child: SizedBox(
                                                width: media.width / 3.8,
                                                height: 60,
                                                child: Center(
                                                    child: Text("10000 Fcfa",
                                                        style: GoogleFonts
                                                            .robotoCondensed(
                                                                fontSize: media
                                                                        .width *
                                                                    eighteen,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200,
                                                                color:
                                                                    textColor))),
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
                              ),
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
