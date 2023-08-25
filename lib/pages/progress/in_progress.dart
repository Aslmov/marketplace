import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../functions/functions.dart';
import '../../styles/styles.dart';
import '../../translations/translation.dart';
import '../../widgets/widgets.dart';
import '../NavigatorPages/walletpage.dart';
import '../loadingPage/loading.dart';
import '../noInternet/nointernet.dart';

class InProgress extends StatefulWidget {
  const InProgress({Key? key}) : super(key: key);

  @override
  State<InProgress> createState() => _InProgressState();
}

class _InProgressState extends State<InProgress> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
      child: ValueListenableBuilder(
          valueListenable: valueNotifierHome.value,
          builder: (context, value, child) {
            return Directionality(
                textDirection: (languageDirection == 'rtl')
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: Scaffold(
                  body: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(media.width * 0.05,
                            media.width * 0.05, media.width * 0.05, 0),
                        height: media.height * 1,
                        width: media.width * 1,
                        color: page,
                        child: Column(
                          children: [
                            SizedBox(
                                height: MediaQuery.of(context).padding.top),
                            SizedBox(
                              height: media.width * 0.5,
                            ),
                            Container(
                              height: media.width * 0.7,
                              width: media.width * 0.7,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/inprogress.png'),
                                      fit: BoxFit.contain)),
                            ),
                            Text(
                              languages[choosenLanguage]['text_in_progress'],
                              style: GoogleFonts.robotoCondensed(
                                  fontSize: media.width * twenty,
                                  fontWeight: FontWeight.w600,
                                  color: textColor),
                            ),
                          ],
                        ),
                      ),
                      // TextButton(
                      //   onPressed: () => throw Exception(),
                      //   child: const Text("Throw Test Exception"),
                      // ),
                    ],
                  ),
                ));
          }),
    );
  }
}
