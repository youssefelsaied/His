import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/menu_provider.dart';
import '../../../Routes/routes.dart';

class MarketCartWidget extends StatelessWidget {
  const MarketCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var menuProvider = Provider.of<MenuProvider>(context);

    return Badge(
      position: BadgePosition(isCenter: false, end: 2.5, top: 5),

      // position: BadgePosition.topEnd(),
      showBadge: menuProvider.calculateTotalCount() > 0,
      elevation: 2,
      badgeContent: Text(
        menuProvider.calculateTotalCount().toString(),
        // "9",
        style: TextStyle(fontSize: 11, color: Colors.white),
      ),
      // badgeColor: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(5),
      alignment: Alignment.center,
      child: IconButton(
          icon: Icon(
            Icons.shopping_cart,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushNamed(context, PageRoutes.myCartPage);
          }),
    );
  }
}
