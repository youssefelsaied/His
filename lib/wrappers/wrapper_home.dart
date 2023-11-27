import 'package:flutter/material.dart';
import 'package:m3ak_user/BottomNavigation/bottom_navigation_doctor.dart';
import 'package:m3ak_user/Locale/locale.dart';
import 'package:m3ak_user/Pages/splash_screen.dart';
import 'package:m3ak_user/Providers/menu_provider.dart';

import 'package:provider/provider.dart';

import '../BottomNavigation/bottom_navigation_patient.dart';
import '../Providers/auth.dart';

class WrapperHome extends StatefulWidget {
  @override
  _WrapperHomeState createState() => _WrapperHomeState();
}

class _WrapperHomeState extends State<WrapperHome> {
  late Future<void> hasData;

  @override
  void initState() {
    super.initState();
    hasData = _getData();
  }

  Future _getData() async {
    // final locale = AppLocalizations.of(
    //   context,
    // )!;

    final auth = Provider.of<Auth>(context, listen: false);
    final menu = Provider.of<MenuProvider>(context, listen: false);
    // var getOffers = menu.fetchOffers(auth.theUser!.token);
    // var getHighlightsOffers = menu.fetchHighlightsOffers(auth.theUser!.token);
    // var getFavourites = menu.fetchFavourites(auth.theUser!.token);
    var getRecords = auth.getRecords();
    var getBilling = auth.getBilling();
    var getDoctors = auth.getDoctors();
    var getAppoinments = auth.getAppoinments();
    var getDoctorAppoinments = auth.getDoctorAppoinments();
    var getDoctorPatients = auth.getDoctorPatients();
    // var fetchPaymentToken = auth.getFirstToken(200);
    // var fetchNotifications = auth.getNotifications();
    // var getAddressRequests = auth.getAddressRequests();
    // var getOrders = auth.getOrders();
    // var getFamilyChildren = auth.getFamilyChildren();
    // var getFamilyMembers = auth.getFamilyMembers();
    // var getPendingFamilyRequests = auth.getPendingFamilyRequests();
    // var getMyPackage = auth.getMyPackage();
    // var getTransactions = auth.getTransactions();
    // var getSubscriptions = auth.getSubscriptions();
    // var getPaymentMethods = auth.getPaymentMethods();
    // var wallet = auth.getWallet();
    // var getMenu = menu.fetchMenu(auth.theUser!.token);
    // var fetchMarketOrders = menu.fetchMarketOrders(auth.theUser!.token);
    // var getMarketHome = menu.fetchMarketHome(auth.theUser!.token);

    try {
      List responses = await Future.wait([
        getRecords,
        getBilling,
        getDoctors,
        getAppoinments,
        getDoctorAppoinments,
        getDoctorPatients
      ]);
      return responses;
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    return FutureBuilder(
        future: hasData,
        builder: (ctx, authSnapshot) {
          switch (authSnapshot.connectionState) {
            case ConnectionState.waiting:
              return SplashScreen();
            case ConnectionState.done:
              return auth.theUser!.role.toLowerCase() == "patient"
                  ? BottomNavigationPatient()
                  : BottomNavigationDoctor();
            default:
              return SplashScreen();
          }
        }
        // authsnapshot.connectionState==ConnectionState.waiting ? SplashScreen() : authsnapshot.data ? WrapperChooseCity():AuthScreen(),
        );
  }
}
