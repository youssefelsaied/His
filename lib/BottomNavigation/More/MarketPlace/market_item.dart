import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:m3ak_user/data/market_home.dart' as mk;

import '../../../Components/custom_add_item_button.dart';
import '../../Medicine/medicine_info.dart';

class MarketItem extends StatefulWidget {
  final mk.Item item;
  const MarketItem({Key? key, required this.item}) : super(key: key);

  @override
  State<MarketItem> createState() => _MarketItemState();
}

class _MarketItemState extends State<MarketItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, PageRoutes.medicineInfo);
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => ProductInfo(widget.item)),
        );
      },
      child: Stack(
        children: [
          Container(
            // margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    FadedScaleAnimation(
                      widget.item.images.isEmpty
                          ? Image.asset('assets/Medicines/11.png')
                          : Image.network(widget.item.images[0]),
                      durationInMilliseconds: 400,
                    ),
                    // _myItems[index].prescription
                    //     ? Align(
                    //         alignment: Alignment.topRight,
                    //         child: FadedScaleAnimation(
                    //           Image.asset(
                    //             'assets/ic_prescription.png',
                    //             scale: 3,
                    //           ),
                    //           durationInMilliseconds: 400,
                    //         ),
                    //       )
                    //     : SizedBox.shrink(),
                  ],
                ),
                Spacer(),
                Text(
                  widget.item.title,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 11.5,
                      color: Color(0xff5b5b5b),
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      widget.item.price + ' L.E ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: CustomAddItemButton(
              item: widget.item,
            ),
          ),
        ],
      ),
    );
  }
}
