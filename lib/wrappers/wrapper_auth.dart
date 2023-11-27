import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m3ak_user/Auth/Login/UI/login_page.dart';
import 'package:m3ak_user/Auth/choose_auth_method.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:m3ak_user/wrappers/wrapper_home.dart';
import 'package:m3ak_user/wrappers/wrapper_main_check.dart';

import 'package:provider/provider.dart';

import '../Locale/language_cubit.dart';
import '../Pages/splash_screen.dart';
import '../Providers/menu_provider.dart';
import '../Providers/request.dart';
import '../UserDetailsCheck/main_check.dart';
import '../data/menu.dart';
// import '../providers/auth.dart';

class WrapperAuth extends StatefulWidget {
  static const routeName = '/wrapper_auth';

  @override
  _WrapperAuthState createState() => _WrapperAuthState();
}

class _WrapperAuthState extends State<WrapperAuth> {
  late LanguageCubit _languageCubit;

  late Future<bool> isAuth;
  @override
  void initState() {
    _languageCubit = BlocProvider.of<LanguageCubit>(context);

    super.initState();
    isAuth = _getAuth();
  }

  Future<bool> _getAuth() async {
    final auth = Provider.of<Auth>(context, listen: false);
    print("iam here get auth");

    return await auth.tryAutoLogin();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();

    precacheImage(AssetImage('assets/logo_user.png'), context);
  }

  @override
  Widget build(BuildContext ctx) {
    final auth = Provider.of<Auth>(context, listen: true);

    return FutureBuilder(
        future: isAuth,
        builder: (context, authSnapshot) {
          // print(authSnapshot.data);

          switch (authSnapshot.connectionState) {
            case ConnectionState.waiting:
              return SplashScreen();
            case ConnectionState.done:
              return auth.theUser != null ? WrapperHome() : ChooseAuthMethod();
            default:
              return ChooseAuthMethod();
          }
        }
        // authsnapshot.connectionState==ConnectionState.waiting ? SplashScreen() : authsnapshot.data ? WrapperChooseCity():AuthScreen(),
        );
  }
}
