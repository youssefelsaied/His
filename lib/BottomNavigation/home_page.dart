import 'dart:async';
import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:m3ak_user/BottomNavigation/patient_screems/patiennt_doctor_appointment_screen.dart';
import 'package:m3ak_user/Components/custom_button.dart';
import 'package:m3ak_user/Dialogs/change_city_dialog.dart';
import 'package:m3ak_user/Pages/notification_page.dart';
import 'package:m3ak_user/Pages/offer_detail.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:m3ak_user/Providers/menu_provider.dart';
import 'package:m3ak_user/widgets/category_item.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../BottomNavigation/Data/data.dart';
import '../../../../Components/entry_field.dart';
import '../../../../Components/title_row.dart';
import '../../../../Locale/locale.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../Routes/routes.dart';
import '../Pages/brand_info_page.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loadingAnchoredBanner = false;
  bool delay = false;
  Future<void> del() async {
    await Future.delayed(Duration(milliseconds: 300));
    // delay = false;
    setState(() {
      delay = false;
    });
  }

  bool _connectionStatus = true;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    delay = true;
    del();

    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    print("result changed is $result");
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        setState(() => _connectionStatus = true);
        break;
      case ConnectivityResult.none:
        setState(() => _connectionStatus = false);
        break;
      default:
        setState(() => _connectionStatus = true);
        break;
    }
  }

  double _kItemExtent = 32.0;

  void _showDialog(Widget child) {
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom;
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: height * .2,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: true);

    int notifications = auth.currentNotifications - auth.lastSeenNotifications;
    // int notifications = 72;

    if (notifications > 99) {
      notifications = 99;
    }
    var locale = AppLocalizations.of(context)!;
    final menu = Provider.of<MenuProvider>(context, listen: true);
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom;
    final width = MediaQuery.of(context).size.width;
    String? value = 'Wallington';
    print("interenet connection is $_connectionStatus");
    return Builder(builder: (BuildContext context) {
      if (!_loadingAnchoredBanner) {
        _loadingAnchoredBanner = true;
        // _createAnchoredBanner(context);
      }
      return Scaffold(
        appBar: AppBar(
            titleSpacing: 0,
            centerTitle: true,
            title: Container(
              // color: Colors.red,
              padding: const EdgeInsets.only(
                  left: 10.0, top: 0, right: 10, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    locale.hello!.toString() + ', ' + auth.theUser!.username!,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: kMainColor, fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return ChangeCityDialog();
                        },
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          auth.theUser!.role,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: lightGreyColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[]),
        body: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: () async {
            return;
          },
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  "My Billings",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: auth.myBillings.isEmpty
                    ? Center(
                        child: Text("No Billings yet"),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: auth.myBillings
                            .map((e) => Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  children: [
                                    Text(
                                      e.billingAmount + "\$",
                                      style: TextStyle(color: kMainColor),
                                    ),
                                    Text(
                                      e.billingDate.toString(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ],
                                )))
                            .toList(),
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  "Avilable Doctors",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: auth.avilableDoctors
                      .map((e) => InkWell(
                            onTap: () {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      PatientDoctorAppoinmentScreen(e),
                                ),
                              );
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.doctorName + "\$",
                                      style: TextStyle(color: kMainColor),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      e.description.toString(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      e.specialization.toString(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ],
                                )),
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget quickGrid(BuildContext context, String image) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PageRoutes.sellerProfile);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FadedScaleAnimation(
            Image(
              image: AssetImage(image),
              height: 54,
            ),
            durationInMilliseconds: 300,
          ),
          SizedBox(width: 13.3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Well Life Store',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 15, color: black2)),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Color(0xff999999),
                    size: 12,
                  ),
                  Text(' ' + 'Willington Bridge',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Theme.of(context).disabledColor,
                          fontSize: 10.0)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
