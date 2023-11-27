import 'dart:async';

import 'package:animation_wrappers/animation_wrappers.dart';
import '../../../../Auth/Verification/UI/verification_interator.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Components/entry_field.dart';
import '../../../../Locale/locale.dart';
import 'package:flutter/material.dart';

class VerificationUI extends StatefulWidget {
  final VerificationInteractor verificationInteractor;

  @override
  _VerificationUIState createState() => _VerificationUIState();

  VerificationUI(this.verificationInteractor);
}

class _VerificationUIState extends State<VerificationUI> {
  final TextEditingController _controller = TextEditingController();
  int _counter = 20;
  late Timer _timer;

  _startTimer() {
    _counter = 20; //time counter
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter > 0 ? _counter-- : _timer.cancel();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
    widget.verificationInteractor.verifyNumber();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.red,
        title: Text(
          locale.phoneVerification!,
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
          child: Container(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.vertical,
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Spacer(),
                Text(
                  locale.weveSentAnOTP!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).disabledColor, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                Spacer(flex: 2),
                EntryField(
                  controller: _controller,
                  hint: locale.enter4DigitOTP,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                CustomButton(
                  onTap: () {
                    widget.verificationInteractor.verificationDone();
                  },
                  label: locale.submit,
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '0:${_counter.toString().padLeft(2, '0')} ' + "min left",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    CustomButton(
                        label: locale.resend!.toUpperCase(),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        textColor: Theme.of(context).hintColor,
                        padding: 0.0,
                        onTap: _counter < 1
                            ? () {
                                _startTimer();
                                widget.verificationInteractor.verifyNumber();
                              }
                            : null),
                  ],
                ),
                Spacer(flex: 12),
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
