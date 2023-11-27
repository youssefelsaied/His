import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Image.asset(
            'assets/hero_image.png',
            // color: Colors.white,
            scale: 4,
            width: deviceSize.width,
            height: deviceSize.height * .5,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
