import 'dart:async';
import 'dart:ui';

import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m3ak_user/UserDetailsCheck/verification_check.dart';
import 'package:m3ak_user/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';

import '../Components/custom_button.dart';
import '../Components/entry_field.dart';
import '../Locale/locale.dart';
import '../Providers/auth.dart';
import '../Providers/global_provider.dart';
import '../widgets/error_dialog.dart';

class ResetPasswordPage extends StatefulWidget {
  final String phoneNumber;
  const ResetPasswordPage({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool obscure = true;
  bool loading = false;
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
      content: Text(message),
      duration: Duration(seconds: 1),
    ));
  }

  bool _connectionStatus = false;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
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
    final size = MediaQuery.of(context).size;

    final width = size.width;

    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    if (!_connectionStatus) {
      print("No iternet");
      showToast("Check internet Conniction", Colors.red);
      return;
    } else {
      _formKey.currentState!.save();

      try {
        setState(() {
          loading = true;
        });
        final auth = Provider.of<Auth>(context, listen: false);

        final res = await auth.forgetPassword(widget.phoneNumber,
            _passwordController.text, _confirmPasswordController.text);
        setState(() {
          loading = false;
        });
        if (res) {
          Navigator.pop(context);
          Navigator.pop(context);
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              var locale = AppLocalizations.of(context)!;

              return CustomDialog(
                title: auth.otpReason == 'reset password'
                    ? locale.forgetPassword!
                    : auth.otpReason.toUpperCase(),
                msg: locale.passwordChangedSuccessfully!,
                icon: Icon(
                  Icons.check,
                  color: Theme.of(context).primaryColor,
                  size: width * .15,
                ),
                // mainAction: TextButton(
                //     style: TextButton.styleFrom(
                //       padding:
                //           EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                //       backgroundColor: Theme.of(context).primaryColor,
                //     ),
                //     onPressed: () {
                //       // Navigator.pushNamed(context, PageRoutes.confirmOrderPage);
                //     },
                //     child: Text(
                //       locale.uploadPrescription!,
                //       style: Theme.of(context).textTheme.bodyText1!.copyWith(
                //           color: Theme.of(context).scaffoldBackgroundColor),
                //     )),
                secondAction: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      locale.ok!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Theme.of(context).primaryColor),
                    )),
              );
            },
          );
          // Navigator.push<void>(
          //   context,
          //   MaterialPageRoute<void>(
          //     builder: (BuildContext context) =>
          //         VerificationCheck(
          //       mobileNumber: _phoneController.text,
          //     ),
          //   ),
          // );
        } else {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return ErrorDialog(
                title: auth.otpReason.toUpperCase(),
                msg: auth.error,
              );
            },
          );
        }
      } catch (error) {
        var errorMessage = error.toString();
        _showErrorDialog(errorMessage.toString());
      }
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final notch = MediaQuery.of(context).padding.top;
    final height = size.height - notch;
    final width = size.width;
    var locale = AppLocalizations.of(context)!;
    var global = Provider.of<GlobalProvider>(context);

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.red,
        // toolbarHeight:  ,
        title: Text(
          locale.forgetPassword!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
        // leading: IconButton(
        //     onPressed: () => global.previousPage(),
        //     icon: Icon(Icons.chevron_left)),
      ),
      body: Form(
        key: _formKey,
        child: FadedSlideAnimation(
          SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              height: height,
              padding: EdgeInsets.symmetric(horizontal: width * .05),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Spacer(),
                Text(
                  locale.yourPhoneNumberNotRegistered!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).disabledColor, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                Spacer(flex: 2),
                EntryField(
                  onValidate: (value) {
                    if (value!.length < 6) {
                      return locale.password_validation;
                    }
                    return null;
                  },
                  hint: locale.password,
                  prefixIcon: Icons.lock,
                  // color: Theme.of(context).scaffoldBackgroundColor,
                  controller: _passwordController,
                  suffixIcon: obscure
                      ? Icons.visibility_off_rounded
                      : Icons.remove_red_eye,
                  obscure: obscure,
                  onsuffixIconTap: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                EntryField(
                  onValidate: (value) {
                    if (_passwordController.text != value!) {
                      return locale.password.toString().toLowerCase() +
                          ' ' +
                          locale.noMatch.toString();
                    }
                    return null;
                  },
                  hint: locale.confirmPassword,
                  prefixIcon: Icons.lock,
                  // color: Theme.of(context).scaffoldBackgroundColor,
                  controller: _confirmPasswordController,
                  suffixIcon: obscure
                      ? Icons.visibility_off_rounded
                      : Icons.remove_red_eye,

                  obscure: obscure,
                  onsuffixIconTap: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                loading
                    ? CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      )
                    : CustomButton(
                        label: locale.continuee,
                        onTap: () async {
                          onSubmit();
                        },
                      ),
                Spacer(flex: 12),
              ]),
            ),
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }
}
