import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:intl/intl.dart' as intl;
import 'package:m3ak_user/Auth/Login/UI/login_page.dart';
import 'package:m3ak_user/Auth/Login/UI/login_ui.dart';
import 'package:m3ak_user/Auth/Registration/UI/registration_page.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:m3ak_user/UserDetailsCheck/phone_check.dart';
import 'package:provider/provider.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Components/entry_field.dart';
import '../../../../Locale/locale.dart';
import 'package:flutter/material.dart';

import '../../../Locale/language_cubit.dart';
import '../../../widgets/error_dialog.dart';
import '../../../widgets/toggle.dart';

class ChooseAuthMethod extends StatefulWidget {
  @override
  _ChooseAuthMethodState createState() => _ChooseAuthMethodState();
}

class _ChooseAuthMethodState extends State<ChooseAuthMethod> {
  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: AlertDialog(
                backgroundColor: Colors.black45,
                title: Text(
                  'An Error Occurred! try again Later!',
                  style: TextStyle(color: Colors.white),
                ),
                content: Text(
                  message,
                  style: TextStyle(color: Colors.white),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'Okay',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              ),
            ));
  }

  void showToast(message, Color color) {
    print(message);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            // style: TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      duration: Duration(seconds: 1),
    ));
  }

  var _loading = false;
  bool _connectionStatus = false;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late LanguageCubit _languageCubit;

  @override
  void initState() {
    _languageCubit = BlocProvider.of<LanguageCubit>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final auth = Provider.of<Auth>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: FadedSlideAnimation(
        SizedBox(
          height: height,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                              color: Theme.of(context).splashColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              )),

                          // padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Spacer(),
                              // Expanded(
                              //     flex: 4,
                              //     child: Image.asset('assets/logo_ma3ak.png')),
                              Spacer(),
                              Expanded(
                                  flex: 3,
                                  child: Image.asset('assets/hero_image.png')),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: height * .01),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * .02,
                                ),
                                CustomButton(
                                  // shrink: true,
                                  onTap: () {
                                    // onSubmit();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            RegistrationPage(),
                                      ),
                                    );
                                  },
                                  label: locale.new_user!,
                                  // shrink: false,
                                ),
                                // Spacer(),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * .01),
                                  child: Text(
                                    locale.or.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                CustomButton(
                                  // shrink: true,

                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            LoginPage(),
                                      ),
                                    );
                                  },
                                  label: locale.old_user!,

                                  // shrink: false,
                                ),

                                Container(
                                  alignment: Alignment.center,
                                  // color: Theme.of(context).backgroundColor,
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    locale.version! +
                                        (Platform.isIOS
                                            ? auth.iosVersionNumber
                                            : auth.iosVersionNumber),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                // Spacer(),
                                // Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
