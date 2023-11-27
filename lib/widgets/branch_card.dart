import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:m3ak_user/data/branches_by_brand.dart';
import 'package:m3ak_user/data/brands_by_category.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Locale/locale.dart';
import '../Theme/colors.dart';
import '../data/map_util.dart';

class BranchCard extends StatelessWidget {
  final Brand brand;
  final Branch branch;
  const BranchCard({Key? key, required this.brand, required this.branch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 2.0,
            bottom: 10.0,
            // left: width * .025,
            // right: width * .025,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FadedScaleAnimation(
                  brand.image == ''
                      ? Image.asset(
                          // 'assets/img_orderplaced.png',
                          'assets/SellerImages/1a.png',
                          height: width * .1,
                          width: width * .1,
                        )
                      : Image.network(
                          brand.image!,
                          height: width * .1,
                          width: width * .1,
                        ),
                  durationInMilliseconds: 400,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: width * .02),
                  width: width * .7,
                  child: RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.subtitle2,
                          children: <TextSpan>[
                        TextSpan(
                            text: branch.name.toString() + "\n",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: black2, fontSize: 17)),
                        TextSpan(
                            text: branch.address,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 11.2,
                                      color: Color(0xff999999),
                                    )),
                      ])),
                ),
                SizedBox(
                    width: width * .1,
                    child: Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              final Uri launchUri = Uri(
                                scheme: 'tel',
                                path: branch.phoneNumber,
                              );
                              launchUrl(launchUri);
                            },
                            icon: Icon(
                              Icons.phone,
                              // size: 30,
                            )),
                        SizedBox(
                          height: 0,
                        ),
                        IconButton(
                            onPressed: () {
                              MapUtils.openMap(double.parse(branch.latitude),
                                  double.parse(branch.longitude));
                            },
                            icon: Icon(
                              Icons.location_on_outlined,
                              size: 30,
                            )),
                      ],
                    ))
              ],
            ),
          ),
        ),
        Divider(
          height: 2,
          thickness: 2,
          color: Theme.of(context).backgroundColor,
        ),
      ],
    );
  }
}
