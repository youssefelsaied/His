import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:intl/intl.dart' as intl;
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
import 'login_interactor.dart';

class LoginUI extends StatefulWidget {
  final LoginInteractor loginInteractor;

  LoginUI(this.loginInteractor);

  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _numberController.dispose();
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

  Future<void> onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    {
      _formKey.currentState!.save();
      setState(() {
        _loading = true;
      });
      try {
        final auth = Provider.of<Auth>(context, listen: false);

        final res = await auth.signIn();
        setState(() {
          _loading = false;
        });
        if (res) {
          Phoenix.rebirth(context);

          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => MainCheck()));
        } else {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return ErrorDialog(
                title: "Sign In",
                msg: "this phone number is used",
              );
            },
          );
        }
      } catch (error) {
        var errorMessage = error.toString();
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return ErrorDialog(
              title: "Sign In",
              msg: "credentials is not valid",
            );
          },
        );
        // _showErrorDialog(errorMessage.toString());
      }
      setState(() {
        _loading = false;
      });
    }
  }

  int _toggleValue = 0;

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
                          color: Theme.of(context).splashColor,
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
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // SizedBox(
                                //     height: MediaQuery.of(context).size.height *
                                //         0.46),
                                EntryField(
                                  hint: "User Name",
                                  prefixIcon: Icons.phone_iphone,
                                  textInputType: TextInputType.text,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  controller: auth.signInUserNameController,
                                  onValidate: (value) {
                                    // print(""locale.locale);
                                    if (value!.isEmpty) {
                                      return locale.youMustEnter.toString() +
                                          " " +
                                          locale.mobileNumber
                                              .toString()
                                              .toLowerCase();
                                    } else if ((value.contains(' '))) {
                                      return locale.please_remove_spaces;
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10.0),
                                EntryField(
                                  onValidate: (value) {
                                    // print(""locale.locale);
                                    if (value!.length < 6) {
                                      if (locale.locale.toString() == 'en') {
                                        print("english");
                                        return locale.youMustEnter.toString() +
                                            ' ' +
                                            locale.valid.toString() +
                                            ' ' +
                                            locale.password
                                                .toString()
                                                .toLowerCase();
                                      } else {
                                        return locale.youMustEnter.toString() +
                                            ' ' +
                                            locale.password
                                                .toString()
                                                .toLowerCase() +
                                            ' ' +
                                            locale.valid.toString();
                                      }
                                    }
                                    return null;
                                  },
                                  obscure: true,
                                  hint: locale.password,
                                  prefixIcon: Icons.lock,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  controller: auth.signInPasswordController,
                                ),
                                SizedBox(height: 10.0),
                                _loading
                                    ? CircularProgressIndicator(
                                        color: Theme.of(context).primaryColor,
                                      )
                                    : CustomButton(
                                        onTap: () {
                                          onSubmit();
                                        },
                                        // shrink: false,
                                      ),
                                // Spacer(),
                                // Spacer(),
                                Center(
                                  child: Text(
                                    locale.or.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                // Spacer(),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            RegistrationPage(),
                                      ),
                                    );
                                    // widget.loginInteractor
                                    //     .loginWithMobile('', _numberController.text);
                                  },
                                  child: Text(
                                    locale.registerNow!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 18),
                                  ),
                                ),
                                // Spacer(flex: 4,),

                                // Container(
                                //   alignment: Alignment.center,
                                //   // color: Theme.of(context).backgroundColor,
                                //   margin: EdgeInsets.symmetric(vertical: 10),
                                //   padding: EdgeInsets.symmetric(vertical: 10),
                                //   child: Text(
                                //     locale.version! +
                                //         (Platform.isIOS
                                //             ? auth.iosVersionNumber
                                //             : auth.iosVersionNumber),
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .bodyText1!
                                //         .copyWith(fontWeight: FontWeight.bold),
                                //   ),
                                // ),
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
