import 'dart:io';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Locale/locale.dart';
import '../Providers/auth.dart';
import 'package:provider/provider.dart';

class SaveLoading extends StatefulWidget {
  final String title;
  const SaveLoading({Key? key, required this.title}) : super(key: key);

  @override
  State<SaveLoading> createState() => _SaveLoadingState();
}

class _SaveLoadingState extends State<SaveLoading> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: true);
    String _loadingTxt = "";
    var locale = AppLocalizations.of(context)!;

    final size = MediaQuery.of(context).size;
    final notch = MediaQuery.of(context).padding.top;
    final height = size.height - notch;
    final width = size.width;
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Dialog(
          backgroundColor: Colors.white70,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Container(
//        color: Colors.black45,
            width: width,
            height: height * .3,
            // padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width,
                  height: height * .08,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: Text(
                    locale.editing_profile!,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: width * .05),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: width,
                  height: height * .22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: AutoSizeText(
                          _loadingTxt,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: width * .05),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      "auth.saveLoadingTxt" == 'Some error Occurred'
                          ? Container()
                          : Center(
                              child: Platform.isAndroid
                                  ? CircularProgressIndicator()
                                  : CupertinoActivityIndicator(),
                            ),
                      "auth.saveLoadingTxt" == 'Some error Occurred'
                          ? TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        horizontal: width * .1)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                    side: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                              child: Text(
                                "Ok",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            )
                          : Container()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
