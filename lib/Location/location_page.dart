import 'dart:async';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_phoenix/generated/i18n.dart';
import 'package:geocoding/geocoding.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:m3ak_user/data/city.dart';
import 'package:provider/provider.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Components/entry_field.dart';
import '../../../../Locale/locale.dart';
import '../../../../OrderMapBloc/order_map_bloc.dart';
import '../../../../OrderMapBloc/order_map_state.dart';
import '../../../../map_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as Loc;

import '../Providers/map_provider.dart';
import 'address_type_button.dart';

TextEditingController _addressTitleController = TextEditingController();
TextEditingController _buildingController = TextEditingController();
TextEditingController _floorController = TextEditingController();
TextEditingController _doorController = TextEditingController();

// class LocationPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<OrderMapBloc>(
//       create: (context) => OrderMapBloc()..loadMap(),
//       child: SetLocation(),
//     );
//   }
// }

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  bool isCard = true;
  bool isLoading = false;
  Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController? mapStyleController;
  static const LatLng _center = const LatLng(45.343434, -122.545454);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;

  // void _getUserLocation() async {
  //   await Permission.locationAlways.request();
  // }

  @override
  void initState() {
    rootBundle.loadString('assets/map_style.txt').then((string) {
      mapStyle = string;
    });
    // getUserLocation();
    city = null;
    area = null;
    _addressTitleController.clear();
    _buildingController.clear();
    _floorController.clear();
    _doorController.clear();
    super.initState();
  }

  void getUserLocation() async {
    print('geting location');
    Loc.Location location = Loc.Location();

    bool _serviceEnabled;
    Loc.PermissionStatus _permissionGranted;
    Loc.LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        // activegps = false;
        return;
      }
    }
    // activegps = true;
    Loc.LocationData position = await location.getLocation();
    setState(() {
      _lastMapPosition = LatLng(position.latitude!, position.longitude!);
    });
    mapStyleController!.moveCamera(CameraUpdate.newLatLng(_lastMapPosition));

    // _Controller;
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final auth = Provider.of<Auth>(context, listen: true);
    // final provMaps = Provider.of<MapProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left),
          iconSize: 25,
        ),
        title: Text(
          locale.addNewAddress!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        textTheme: Theme.of(context).textTheme,
        actions: [
          // CustomButton(
          //   textColor: Theme.of(context).primaryColor,
          //   color: Theme.of(context).scaffoldBackgroundColor,
          //   textSize: 22,
          // ),
        ],
      ),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 8.0,
                ),
                Expanded(
                  // height: 200,
                  child: Stack(
                    children: <Widget>[
                      GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: kGooglePlex,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        markers: _markers,
                        onMapCreated: (GoogleMapController controller) async {
                          _mapController.complete(controller);
                          getUserLocation();
                          mapStyleController = controller;
                          mapStyleController!.setMapStyle(mapStyle);
                        },
                        onCameraMove: (CameraPosition position) {
                          print('changinnnng ........');
                          _lastMapPosition = position.target;
                          print(_lastMapPosition.latitude);
                          print(_lastMapPosition.longitude);
                          // });
                        },
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 36.0),
                            child: Image.asset('assets/map_pin.png', scale: 4),
                          )),
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: FloatingActionButton(
                          onPressed: getUserLocation,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(
                            Icons.gps_fixed,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   color: Theme.of(context).cardColor,
                //   padding:
                //       EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                //   child: Row(
                //     children: <Widget>[
                //       Image.asset('assets/map_pin.png', scale: 5),
                //       // SizedBox(width: 16.0),
                //       // Expanded(
                //       //   child: Text(
                //       //     'Paris, France',
                //       //     overflow: TextOverflow.ellipsis,
                //       //     style: Theme.of(context).textTheme.caption,
                //       //   ),
                //       // ),
                //       Spacer(),
                //       isCard
                //           ? InkWell(
                //               child: Icon(
                //                 Icons.close,
                //                 size: 20,
                //                 color: Theme.of(context).hintColor,
                //               ),
                //               onTap: () {
                //                 setState(() {
                //                   isCard = !isCard;
                //                 });
                //               },
                //             )
                //           : SizedBox.shrink()
                //     ],
                //   ),
                // ),
                isCard ? SaveAddressCard() : Container(),
                Container(
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(vertical: isLoading ? 16 : 10),
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : CustomButton(
                          radius: 0,
                          label: locale.saveAddress,
                          onTap: () async {
                            if (isCard == false) {
                              setState(() {
                                isCard = true;
                              });
                            } else {
                              if (city == null ||
                                  area == null ||
                                  _addressTitleController.text.isEmpty) {
                                print('you should enter empty fields');
                              } else {
                                setState(() {
                                  isLoading = true;
                                });
                                List<Placemark> placemarks =
                                    await placemarkFromCoordinates(
                                  _lastMapPosition.latitude,
                                  _lastMapPosition.longitude,
                                );
                                var address = "${placemarks[0].street}" +
                                    "," +
                                    "${placemarks[0].subLocality!}" +
                                    "," +
                                    "${placemarks[0].locality!}" +
                                    "," +
                                    "${placemarks[0].country!}" +
                                    "," +
                                    "${placemarks[0].postalCode!}";

                                // var result = await auth.AddAddressRequests(
                                //   title: _addressTitleController.text,
                                //   latitude: _lastMapPosition.latitude,
                                //   longitude: _lastMapPosition.longitude,
                                //   address: address,
                                //   city_id: city!.id,
                                //   area_id: area!.id,
                                //   building: _buildingController.text.isEmpty
                                //       ? 0
                                //       : double.parse(_buildingController.text)
                                //           .toInt(),
                                //   floor: _floorController.text.isEmpty
                                //       ? 0
                                //       : double.parse(_floorController.text)
                                //           .toInt(),
                                //   door: _doorController.text.isEmpty
                                //       ? 0
                                //       : double.parse(_doorController.text)
                                //           .toInt(),
                                // );
                                setState(() {
                                  isLoading = false;
                                });
                                // if (result) {
                                //   Navigator.pop(context);
                                // }
                              }
                            }
                          }),
                )
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

enum AddressType {
  Home,
  Office,
  Other,
}

AddressType selectedAddress = AddressType.Other;

class SaveAddressCard extends StatefulWidget {
  @override
  _SaveAddressCardState createState() => _SaveAddressCardState();
}

City? city;
Area? area;

class _SaveAddressCardState extends State<SaveAddressCard> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final auth = Provider.of<Auth>(context);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: FadedSlideAnimation(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              locale.selectAddressType!,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(fontSize: 12, color: Color(0xffc0c0c0)),
            ),
            SizedBox(
              height: 10,
            ),
            EntryField(
              controller: _addressTitleController,
              // label: locale.enterAddressDetails,
              hint: locale.expText,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .03),
                  width: size.width * .38,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).primaryColor.withOpacity(.1)),
                  child: DropdownButton<dynamic>(
                    isExpanded: true,
                    items: auth.avialableCites.map((dynamic value) {
                      return DropdownMenuItem<dynamic>(
                        value: value,
                        child: AutoSizeText(
                          value.title!,
                          maxLines: 1,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        city = value;
                        area = null;
                      });
                    },
                    underline: Text(''),
                    value: city,
                    hint: AutoSizeText(
                      locale.chooseCity!,
                      style: TextStyle(color: Colors.grey),
                      maxLines: 1,
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * .05,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .03),
                  width: size.width * .38,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: city == null
                          ? Colors.grey.withOpacity(.4)
                          : Theme.of(context).primaryColor.withOpacity(.1)),
                  child: DropdownButton<dynamic>(
                    isExpanded: true,
                    items: city == null
                        ? []
                        : city!.areas.map((dynamic value) {
                            return DropdownMenuItem<dynamic>(
                              value: value,
                              child: AutoSizeText(
                                value.title!,
                                maxLines: 1,
                              ),
                            );
                          }).toList(),
                    onChanged: (value) {
                      setState(() {
                        area = value;
                      });
                    },
                    underline: Text(''),
                    value: area,
                    hint: AutoSizeText(
                      locale.chooseArea!,
                      style: TextStyle(color: Colors.grey),
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: <Widget>[
            //     AddressTypeButton(
            //       label: AppLocalizations.of(context)!.home,
            //       icon: Icons.home,
            //       onPressed: () {
            //         setState(() {
            //           selectedAddress = AddressType.Home;
            //         });
            //       },
            //       isSelected: selectedAddress == AddressType.Home,
            //     ),
            //     AddressTypeButton(
            //       label: AppLocalizations.of(context)!.office,
            //       icon: Icons.business,
            //       onPressed: () {
            //         setState(() {
            //           selectedAddress = AddressType.Office;
            //         });
            //       },
            //       isSelected: selectedAddress == AddressType.Office,
            //     ),
            //     AddressTypeButton(
            //       label: AppLocalizations.of(context)!.other,
            //       icon: Icons.assistant,
            //       onPressed: () {
            //         setState(() {
            //           selectedAddress = AddressType.Other;
            //         });
            //       },
            //       isSelected: selectedAddress == AddressType.Other,
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Text(
            //   locale.enterAddressDetails!,
            //   style: Theme.of(context)
            //       .textTheme
            //       .subtitle2!
            //       .copyWith(fontSize: 12, color: Color(0xffc0c0c0)),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // EntryField(
            //   controller: _addressController,
            //   // label: locale.enterAddressDetails,
            //   hint: locale.address,
            // ),
            Container(
              width: size.width * .9,
              // height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    // height: 100,
                    width: size.width * .28,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          locale.enterBuildingNumber!,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontSize: 12, color: Color(0xffc0c0c0)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        EntryField(
                          controller: _buildingController,
                          // label: locale.enterAddressDetails,
                          hint: locale.building,
                          numbersOnly: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    // height: 100,
                    width: size.width * .28,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          locale.enterFloorNumber!,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontSize: 12, color: Color(0xffc0c0c0)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        EntryField(
                          controller: _floorController,
                          // label: locale.enterAddressDetails,
                          hint: locale.floor,
                          numbersOnly: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    // height: 100,
                    width: size.width * .28,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          locale.enteraptNumber!,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontSize: 12, color: Color(0xffc0c0c0)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        EntryField(
                          controller: _doorController,
                          // label: locale.enterAddressDetails,
                          hint: locale.apt,
                          numbersOnly: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
