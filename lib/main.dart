import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:m3ak_user/Providers/global_provider.dart';
import 'package:m3ak_user/Providers/menu_provider.dart';
import 'package:m3ak_user/UserDetailsCheck/main_check.dart';
import 'package:m3ak_user/wrappers/wrapper_auth.dart';
import 'package:provider/provider.dart';

import '../../../../Auth/login_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'Locale/locale.dart';
import 'Routes/routes.dart';
import 'Theme/style.dart';
import 'Locale/language_cubit.dart';
import 'map_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // ByteData data =
  //     await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  // SecurityContext.defaultContext
  //     .setTrustedCertificatesBytes(data.buffer.asUint8List());
  MapUtils.getMarkerPic();

  // MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(Phoenix(child: Docto()));
  });
  // runApp(Phoenix(child: Docto()));
}

class Docto extends StatefulWidget {
  @override
  State<Docto> createState() => _DoctoState();
}

class _DoctoState extends State<Docto> {
  String? _token;

  @override
  void initState() {
    WidgetsBinding.instance!.renderView.automaticSystemUiAdjustment =
        false; //<--

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    super.initState();
  }

  // Future<void> onActionSelected(String value) async {
  //   switch (value) {
  //     case 'subscribe':
  //       {
  //         print(
  //           'FlutterFire Messaging Example: Subscribing to topic "fcm_test".',
  //         );
  //         await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
  //         print(
  //           'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.',
  //         );
  //       }
  //       break;
  //     case 'unsubscribe':
  //       {
  //         print(
  //           'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".',
  //         );
  //         await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
  //         print(
  //           'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.',
  //         );
  //       }
  //       break;
  //     case 'get_apns_token':
  //       {
  //         if (defaultTargetPlatform == TargetPlatform.iOS ||
  //             defaultTargetPlatform == TargetPlatform.macOS) {
  //           print('FlutterFire Messaging Example: Getting APNs token...');
  //           String? token = await FirebaseMessaging.instance.getAPNSToken();
  //           print('FlutterFire Messaging Example: Got APNs token: $token');
  //         } else {
  //           print(
  //             'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.',
  //           );
  //         }
  //       }
  //       break;
  //     default:
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('The user tries to pop()');
        return false;
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Auth(),
          ),
          ChangeNotifierProvider(
            create: (context) => MenuProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => GlobalProvider(),
          ),
        ],
        child: BlocProvider<LanguageCubit>(
          create: (context) => LanguageCubit(),
          child: BlocBuilder<LanguageCubit, Locale>(
            builder: (_, locale) {
              return MaterialApp(
                localizationsDelegates: [
                  const AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: [
                  const Locale('en'),
                ],
                locale: locale,
                theme: appTheme,
                // home: LoginNavigator(),
                home: WrapperAuth(),
                routes: PageRoutes().routes(),
                debugShowCheckedModeBanner: false,
              );
            },
          ),
        ),
      ),
    );
  }
}
