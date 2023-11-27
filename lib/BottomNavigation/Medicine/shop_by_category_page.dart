import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:m3ak_user/data/menu.dart';
import 'package:provider/provider.dart';
import '../../../../BottomNavigation/Data/category_data_list.dart';
import '../../../../BottomNavigation/Data/data.dart';
import '../../../../Locale/locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../Routes/routes.dart';
import '../../Components/custom_add_item_button.dart';
import '../../Providers/menu_provider.dart';
import '../../data/brands_by_category.dart';
import '../../widgets/category_item.dart';

class ShopByCategoryPage extends StatefulWidget {
  // var categoryId;
  // ShopByCategoryPage(this.categoryId);
  @override
  _ShopByCategoryPageState createState() => _ShopByCategoryPageState();
}

class _ShopByCategoryPageState extends State<ShopByCategoryPage> {
  // int? _currentIndex;
  // late List<Brand> subCategories;

  // @override
  // void initState() {
  //   super.initState();
  //   final menu = Provider.of<MenuProvider>(context, listen: false);
  //   final auth = Provider.of<Auth>(context, listen: false);
  //   menu.getBrandsByCategoryIdFirstTime(auth.theUser!.token, widget.categoryId);
  // }

  @override
  Widget build(BuildContext context) {
    final menu = Provider.of<MenuProvider>(context, listen: true);

    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          locale.shopByCategory!,
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        // color: Theme.of(context).backgroundColor,
        child: GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: menu.homeCategories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.82,
                crossAxisSpacing: 8,
                mainAxisSpacing: 12),
            itemBuilder: (context, index) {
              return FadedScaleAnimation(
                CategoryItem(
                  category: menu.homeCategories[index],
                  index: index,
                  home: false,
                ),
                durationInMilliseconds: 300,
              );
            }),
      ),
    );
  }
}
//done
