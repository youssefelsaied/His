import 'dart:async';
import 'dart:ui';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:m3ak_user/Auth/Verification/UI/verifiaction_page.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:m3ak_user/UserDetailsCheck/verification_check.dart';
import 'package:provider/provider.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Components/entry_field.dart';
import '../../../../Locale/locale.dart';
import 'package:flutter/material.dart';

import '../../../UserDetailsCheck/main_check.dart';
import '../../../widgets/error_dialog.dart';
import 'registration_interactor.dart';

class RegistrationUI extends StatefulWidget {
  final RegistrationInteractor registrationInteractor;

  RegistrationUI(this.registrationInteractor);

  @override
  _RegistrationUIState createState() => _RegistrationUIState();
}

class _RegistrationUIState extends State<RegistrationUI> {
  bool obscure = true;
  // @override
  // void dispose() {
  //   _firstNameController.dispose();
  //   _lastNameController.dispose();
  //   _lastNameController.dispose();
  //   _passwordController.dispose();
  //   _confirmPasswordController.dispose();
  //   super.dispose();
  // }

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

  var _loading = false;
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

        // final res = await auth.checkPhoneAndEmail();
        final res = await auth.signUp();

        if (res) {
          Phoenix.rebirth(context);
          // auth.setOtpReason("signup");
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => VerificationCheck(
          //               mobileNumber: auth.phoneNumberController.text,
          //             )));
        } else {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return ErrorDialog(
                title: "Sign Up",
                msg: "Some thing went wrong try again Later",
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
              title: "Sign Up",
              msg: errorMessage.toString(),
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

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final auth = Provider.of<Auth>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.registerNow!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
      ),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            // height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),

                  EntryField(
                    onValidate: (value) {
                      return value!.isEmpty ? "you must enter a vlaue" : null;
                    },
                    controller: auth.signUpUserNameController,
                    prefixIcon: Icons.person,
                    hint: "user name",
                  ),
                  SizedBox(height: 10.0),
                  EntryField(
                    onValidate: (value) {
                      return value!.isEmpty ? "you must enter a vlaue" : null;
                    },
                    controller: auth.signUpDateController,
                    prefixIcon: Icons.person,
                    hint: "Date of Birth",
                  ),
                  SizedBox(height: 10.0),
                  EntryField(
                    onValidate: (value) {
                      return value!.isEmpty ? "you must enter a vlaue" : null;
                    },
                    controller: auth.signUpGenderController,
                    prefixIcon: Icons.person,
                    hint: "Gender",
                  ),
                  SizedBox(height: 10.0),
                  EntryField(
                    onValidate: (value) {
                      return value!.isEmpty ? "you must enter a vlaue" : null;
                    },
                    controller: auth.signUpPhoneController,
                    prefixIcon: Icons.person,
                    hint: "Phone",
                  ),
                  SizedBox(height: 10.0),
                  EntryField(
                    onValidate: (value) {
                      return value!.isEmpty ? "you must enter a vlaue" : null;
                    },
                    controller: auth.signUpEmailController,
                    prefixIcon: Icons.person,
                    hint: "Email",
                  ),
                  SizedBox(height: 10.0),

                  // EntryField(
                  //   onValidate: (value) {
                  //     if (!(value!.contains('@')) || !(value.contains('.'))) {
                  //       if (locale.locale.toString() == 'en') {
                  //         return locale.youMustEnter.toString() +
                  //             ' ' +
                  //             locale.valid.toString() +
                  //             ' ' +
                  //             locale.emailAddress.toString().toLowerCase();
                  //       } else {
                  //         return locale.youMustEnter.toString() +
                  //             ' ' +
                  //             locale.emailAddress.toString().toLowerCase() +
                  //             ' ' +
                  //             locale.valid.toString();
                  //       }
                  //     } else if ((value.contains(' '))) {
                  //       return locale.please_remove_spaces;
                  //     }

                  //     return null;
                  //   },
                  //   controller: auth.emailController,
                  //   // onchanged: (value) {
                  //   //   print(value);
                  //   //   setState(() {
                  //   //     auth.emailController.text = auth.emailController.text
                  //   //         .replaceAll(RegExp(r' '), '')
                  //   //         .split('')
                  //   //         .reversed
                  //   //         .join();
                  //   //     // auth.emailController.text = auth.emailController.text
                  //   //     //     .replaceAll(RegExp(r' '), '');
                  //   //     // auth.notifyListeners();
                  //   //   });
                  //   // },
                  //   prefixIcon: Icons.mail,
                  //   hint: locale.emailAddress,
                  //   allowSpace: false,
                  // ),
                  // SizedBox(height: 10.0),

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
                    controller: auth.signUpPasswordController,
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
                  SizedBox(height: 30.0),

                  _loading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : CustomButton(
                          onTap: () async {
                            onSubmit();
                          },
                        ),
                  SizedBox(height: 5),
                  CustomButton(
                    label: locale.backToSignIn,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    textColor: Theme.of(context).hintColor,
                    onTap: widget.registrationInteractor.goBack,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Text(
                  //   locale.wellSendAnOTP!,
                  //   textAlign: TextAlign.center,
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .bodyText1!
                  //       .copyWith(color: Theme.of(context).disabledColor),
                  // ),
                  // Spacer(flex: 4,),
                ],
              ),
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
