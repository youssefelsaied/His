import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_phoenix/generated/i18n.dart';
import 'package:m3ak_user/BottomNavigation/Medicine/shop_by_category_page.dart';
import 'package:m3ak_user/BottomNavigation/More/wallet_page.dart';
import 'package:m3ak_user/BottomNavigation/marketplace_page.dart';
import 'package:m3ak_user/BottomNavigation/medical_records.dart';
import 'package:m3ak_user/Dialogs/expire_dialog.dart';
import 'package:m3ak_user/Dialogs/update_dialog.dart';
import 'package:m3ak_user/Pages/notification_page.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:m3ak_user/Providers/global_provider.dart';
import 'package:m3ak_user/data/wallet.dart';
import 'package:m3ak_user/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';

import '../../../../BottomNavigation/doctors_page.dart';
import '../../../../BottomNavigation/hospitals_page.dart';
import '../../../../Locale/locale.dart';
import 'package:flutter/material.dart';

// import 'Medicine/medicines.dart';
import 'More/Order/recent_orders_page.dart';
import 'More/subscreption_page.dart';
import 'appoinments.dart';
import 'home_page.dart';
import 'more_options.dart';

class BottomNavigationAdmin extends StatefulWidget {
  @override
  _BottomNavigationAdminState createState() => _BottomNavigationAdminState();
}

class _BottomNavigationAdminState extends State<BottomNavigationAdmin> {
  double start = 0;

  final List<Widget> _children = [
    HomePage(),
    // RecentOrdersPage(),
    MedicalRecordsPage(),
    // MarketplacePage(),
    AppoinmentPage(),
    MoreOptions(),
  ];

  void handleNotification(int type, String msg, String title) async {
    print("handling notififcations");
    var locale = AppLocalizations.of(context)!;
    final auth = Provider.of<Auth>(context, listen: false);

    if (type == 1) {
      // auth.getFamilyMembers();
      // auth.getPendingFamilyRequests();
    }
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CustomDialog(
          title: title,
          icon:
              Icon(type == 1 ? Icons.group_add_outlined : Icons.notifications),
          msg: msg,
          mainAction: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => NotificationPage(),
                  ),
                );
                // Navigator.pushNamed(context, PageRoutes.confirmOrderPage);
              },
              child: Text(
                locale.check!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).scaffoldBackgroundColor),
              )),
          secondAction: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                locale.cancel!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).primaryColor),
              )),
        );
      },
    );
  }

  void myBackgroundMessageHandler(Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  Future<void> sync() async {
    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  @override
  void initState() {
    bool update = false;
    bool soft = true;
    final global = Provider.of<GlobalProvider>(context, listen: false);
    global.initaial();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final auth = Provider.of<Auth>(context, listen: false);
      // print();
      if (auth.myPackage == null) {
      } else {
        if (
            // auth.myPackage!.endDate!.isAfter(DateTime.now()) &&
            (auth.myPackage!.endDate!.difference(DateTime.now()).inDays) < 30) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return ExpireDialog();
            },
          );
        }
      }
      if (update) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return UpdateDialog(
              soft: soft,
            );
          },
        );
      }
    });
    final _fcm = FirebaseMessaging.instance;
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (!kIsWeb) {
      sync();
    }
    if (Platform.isIOS) {
      // _fcm.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false));
      _fcm.requestPermission();
    }

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        // Navigator.pushNamed(
        //   context,
        //   '/message',
        //   arguments: MessageArguments(message, true),
        // );
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final auth = Provider.of<Auth>(context, listen: false);
      // auth.getNotifications();
      print('onMessage');
      print(message.notification!.title);
      print(message.notification!.body);
      print(message.data['case']);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      handleNotification(
        double.parse(message.data['case']).toInt(),
        message.notification!.body.toString(),
        message.notification!.title.toString(),
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // handleNotification(double.parse(message.data['type']).toInt(),
      //     message.notification!.body.toString());
      final auth = Provider.of<Auth>(context, listen: false);
      // auth.getNotifications();
      Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => NotificationPage(),
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final global = Provider.of<GlobalProvider>(context, listen: true);
    final List<BottomNavigationBarItem> _bottomBarItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home),
        label: locale.home,
      ),

      // BottomNavigationBarItem(
      //   icon: Icon(Icons.sticky_note_2_outlined),
      //   activeIcon: Icon(Icons.sticky_note_2_outlined),
      //   label: locale.myOrders,
      // ),
      BottomNavigationBarItem(
        icon: Icon(Icons.medical_services_outlined),
        activeIcon: Icon(Icons.medical_services_rounded),
        label: "Medical Records",
      ),

      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage('assets/FooterIcons/ic_appointmentsact.png'),
          size: 25,
        ),
        activeIcon: ImageIcon(
          AssetImage(
            'assets/FooterIcons/ic_appointmentsact.png',
          ),
          size: 25,
        ),
        label: "Appoinments",
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/FooterIcons/ic_more.png')),
        activeIcon: ImageIcon(AssetImage('assets/FooterIcons/ic_moreact.png')),
        label: locale.more,
      ),
    ];
    return WillPopScope(
      onWillPop: () async {
        print('The user tries to pop()');
        var index = global.popTheTop();
        setState(() {
          start = MediaQuery.of(context).size.width *
              index /
              _bottomBarItems.length;
        });
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _children[global.currentIndex],
            AnimatedPositionedDirectional(
              bottom: 0,
              start: start,
              child: Container(
                color: Theme.of(context).primaryColor,
                height: 2,
                width: MediaQuery.of(context).size.width / 5,
              ),
              duration: Duration(milliseconds: 200),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: global.currentIndex,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 20.0,
          type: BottomNavigationBarType.fixed,
          iconSize: 22.0,
          selectedItemColor: Theme.of(context).primaryColor,
          selectedFontSize: 12,
          unselectedFontSize: 10,
          unselectedItemColor: Theme.of(context).disabledColor,
          items: _bottomBarItems,
          onTap: (int index) {
            setState(() {
              // _currentIndex = index;
              global.addToTheTop(index);
              start = MediaQuery.of(context).size.width *
                  index /
                  _bottomBarItems.length;
            });
          },
        ),
      ),
    );
  }
}
