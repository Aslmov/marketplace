import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:receive_intent/receive_intent.dart';
import 'package:tagxisuperuser/pages/loadingPage/loading.dart';
import 'package:tagxisuperuser/pages/onTripPage/booking_confirmation.dart';
import 'package:tagxisuperuser/pages/onTripPage/invoice.dart';
import 'package:tagxisuperuser/pages/language/languages.dart';
import 'package:tagxisuperuser/pages/login/login.dart';
import 'package:tagxisuperuser/pages/onTripPage/map_page.dart';
import 'package:tagxisuperuser/pages/noInternet/nointernet.dart';
import 'package:tagxisuperuser/widgets/widgets.dart';
import 'package:geolocator/geolocator.dart' as geolocs;
import '../../data/data.dart';
import '../../services/googleApiService.dart';
import '../../styles/styles.dart';
import '../../functions/functions.dart';
import 'package:http/http.dart' as http;

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  String dot = '.';
  bool updateAvailable = false;

  bool _isLoading = false;

  bool isReceivingData = false;

  Future<bool> LoadData() async {
    final receivedIntent = await ReceiveIntent.getInitialIntent();

    if (!mounted) return false;

    setState(() {
      // ignore: avoid_print
      if (receivedIntent != null) {
        if (receivedIntent.data != null) {
          if (receivedIntent.data!.isNotEmpty) {
            Repository.receiveLocationLinkData =
                LocationLinkData(data: receivedIntent.data!);
            isReceivingData = true;
          }
        }
      }
    });
    return isReceivingData;
  }

  Future<void> FillLocation() async {
    try {
      if (isReceivingData) {
        if (Repository.receiveLocationLinkData != null) {
          //home page
          var latLng = LatLng(
              double.parse(Repository.receiveLocationLinkData!.latitude),
              double.parse(Repository.receiveLocationLinkData!.longitude));
          if (addressList.length == 0) {
            var locs = await geolocs.Geolocator.getLastKnownPosition();
            if (locs != null) {
              currentLocation = LatLng(double.parse(locs.latitude.toString()),
                  double.parse(locs.longitude.toString()));
            }
            var address = await GoogleApiService.getAdressFromLocation(latLng);

            addressList.add(AddressList(
                id: "1",
                type: "pickup",
                address: address,
                latlng: currentLocation,
                number: userDetails['mobile'],
                name: userDetails['name']));
            addressList.add(AddressList(
              id: "2",
              type: "drop",
              address: address,
              latlng: latLng,
              // number: "+22892080770",
              // name: "Honyiglo"
            ));
          }
        }
      }
    } catch (e) {}
  }

  @override
  void initState() {
    LoadData();
    getLanguageDone();
    super.initState();
  }

  //navigate
  navigate() {
    if (!isReceivingData) {
      if (userRequestData.isNotEmpty && userRequestData['is_completed'] == 1) {
        //invoice page of ride
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Invoice()),
            (route) => false);
      } else if (userRequestData.isNotEmpty &&
          userRequestData['is_completed'] != 1) {
        //searching ride page
        if (userRequestData['is_rental'] == true) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => BookingConfirmation(
                        type: 1,
                      )),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BookingConfirmation()),
              (route) => false);
        }
      } else {
        //home page
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Maps()),
            (route) => false);
      }
    } else {
      FillLocation().then((value) {
        etaRequest();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BookingConfirmation()),
            (route) => false);
      });
    }
  }

//get language json and data saved in local (bearer token , choosen language) and find users current status
  getLanguageDone() async {
    await getDetailsOfDevice();
    if (internet == true) {
      var val = await getLocalData();

      if (val == '3') {
        navigate();
      } else if (val == '2') {
        Future.delayed(const Duration(seconds: 2), () {
          //login page
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Login()));
        });
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          //choose language page
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Languages()));
        });
      }
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Material(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: media.height * 1,
              width: media.width * 1,
              decoration: const BoxDecoration(
                color: Color(0xffF7F7F7),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(media.width * 0.01),
                    width: media.width * 0.7,
                    height: media.width * 0.7,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.contain)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CircularProgressIndicator(
                    backgroundColor: buttonColor,
                    valueColor: AlwaysStoppedAnimation<Color>(verifyPending),
                  )
                ],
              ),
            ),

            //update available

            (updateAvailable == true)
                ? Positioned(
                    top: 0,
                    child: Container(
                      height: media.height * 1,
                      width: media.width * 1,
                      color: Colors.transparent.withOpacity(0.6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: media.width * 0.9,
                              padding: EdgeInsets.all(media.width * 0.05),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: page,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                      width: media.width * 0.8,
                                      child: Text(
                                        'New version of this app is available in store, please update the app for continue using',
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * sixteen,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  SizedBox(
                                    height: media.width * 0.05,
                                  ),
                                  Button(
                                      onTap: () async {
                                        if (platform ==
                                            TargetPlatform.android) {
                                          openBrowser(
                                              'https://play.google.com/store/apps/details?id=${package.packageName}');
                                        } else {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          var response = await http.get(Uri.parse(
                                              'http://itunes.apple.com/lookup?bundleId=${package.packageName}'));
                                          if (response.statusCode == 200) {
                                            openBrowser(jsonDecode(
                                                    response.body)['results'][0]
                                                ['trackViewUrl']);

                                            // printWrapped(jsonDecode(response.body)['results'][0]['trackViewUrl']);
                                          }

                                          setState(() {
                                            _isLoading = false;
                                          });
                                        }
                                      },
                                      text: 'Update')
                                ],
                              ))
                        ],
                      ),
                    ))
                : Container(),

            //loader
            (_isLoading == true && internet == true)
                ? const Positioned(top: 0, child: Loading())
                : Container(),

            //no internet
            (internet == false)
                ? Positioned(
                    top: 0,
                    child: NoInternet(
                      onTap: () {
                        setState(() {
                          internetTrue();
                          getLanguageDone();
                        });
                      },
                    ))
                : Container(),
          ],
        ),
      ),
    );
  }
}
