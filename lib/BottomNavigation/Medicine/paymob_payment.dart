import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Providers/auth.dart';

class PaymobPayment extends StatefulWidget {
  @override
  PaymobPaymentState createState() => PaymobPaymentState();
}

class PaymobPaymentState extends State<PaymobPayment> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    print(
      "https://accept.paymob.com/api/acceptance/iframes/406739?payment_token=${auth.LastToken}",
    );
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: WebView(
          initialUrl:
              "https://accept.paymob.com/api/acceptance/iframes/406739?payment_token=${auth.LastToken}",
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (url) {
            print(url);
          },
        ),
      ),
    );
  }
}
