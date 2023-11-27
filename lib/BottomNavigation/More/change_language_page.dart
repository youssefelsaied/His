import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:m3ak_user/Pages/splash_screen.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:m3ak_user/Providers/request.dart';
import 'package:m3ak_user/wrappers/wrapper_auth.dart';
import 'package:provider/provider.dart';
import '../../../../Auth/login_navigator.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Locale/language_cubit.dart';
import '../../../../Locale/locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeLanguagePage extends StatefulWidget {
  final bool fromRoot;

  ChangeLanguagePage([this.fromRoot = true]);

  @override
  _ChangeLanguagePageState createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  late LanguageCubit _languageCubit;
  int? _selectedLanguage = -1;

  @override
  void initState() {
    super.initState();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    var locale = AppLocalizations.of(context)!;

    final List<String> _languages = [
      'English',
      'عربى',
      // 'français',
      // 'bahasa Indonesia',
      // 'português',
      // 'Español',
      // 'italiano',
      // 'Türk',
      // 'Kiswahili'
    ];
    _selectedLanguage = getCurrentLanguage(locale.locale);

    return loading
        ? SplashScreen()
        : Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Text(
                AppLocalizations.of(context)!.changeLanguage!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              textTheme: Theme.of(context).textTheme,
            ),
            body: FadedSlideAnimation(
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ListView.builder(
                    padding: EdgeInsets.only(bottom: 80),
                    itemCount: _languages.length,
                    itemBuilder: (ctx, index) => RadioListTile(
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (dynamic value) async {
                        setState(() {
                          _selectedLanguage = value;
                          // loading = true;
                        });
                        if (_selectedLanguage == 0) {
                          setState(() {
                            loading = true;
                          });
                          _languageCubit.selectEngLanguage();
                          // await auth.updateLanguage('en');
                          // Request().code = 'en';
                          setState(() {
                            loading = false;
                          });
                          Navigator.pop(context);
                          Navigator.pushReplacement<void, void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => WrapperAuth(),
                            ),
                          );
                        } else if (_selectedLanguage == 1) {
                          setState(() {
                            loading = true;
                          });
                          _languageCubit.selectArabicLanguage();
                          // await auth.updateLanguage('ar');
                          // Request().code = 'ar';
                          setState(() {
                            loading = false;
                          });
                          Navigator.pop(context);
                          Navigator.pushReplacement<void, void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => WrapperAuth(),
                            ),
                          );
                        } else if (_selectedLanguage == 2) {
                          _languageCubit.selectFrenchLanguage();
                        } else if (_selectedLanguage == 3) {
                          _languageCubit.selectIndonesianLanguage();
                        } else if (_selectedLanguage == 4) {
                          _languageCubit.selectPortugueseLanguage();
                        } else if (_selectedLanguage == 5) {
                          _languageCubit.selectSpanishLanguage();
                        } else if (_selectedLanguage == 6) {
                          _languageCubit.selectItalianLanguage();
                        } else if (_selectedLanguage == 7) {
                          _languageCubit.selectTurkishLanguage();
                        } else if (_selectedLanguage == 8) {
                          _languageCubit.selectSwahiliLanguage();
                        }
                        if (widget.fromRoot) {
                          Navigator.pushNamed(context, LoginRoutes.loginRoot);
                        } else {
                          // Navigator.pop(context);
                        }
                      },
                      groupValue: _selectedLanguage,
                      value: index,
                      title: Text(
                        _languages[index],
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 15,
                            ),
                      ),
                    ),
                  ),
                  CustomButton(
                    radius: 0,
                    label: 'Submit',
                    onTap: () {
                      _languageCubit.selectEngLanguage();
                      if (widget.fromRoot) {
                        Navigator.pushNamed(context, LoginRoutes.loginRoot);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
          );
  }

  int getCurrentLanguage(Locale locale) {
    if (locale == Locale('en'))
      return 0;
    else if (locale == Locale('ar'))
      return 1;
    else if (locale == Locale('fr'))
      return 2;
    else if (locale == Locale('id'))
      return 3;
    else if (locale == Locale('pt'))
      return 4;
    else if (locale == Locale('es'))
      return 5;
    else if (locale == Locale('it'))
      return 6;
    else if (locale == Locale('tr'))
      return 7;
    else if (locale == Locale('sw'))
      return 8;
    else
      return -1;
  }
}
