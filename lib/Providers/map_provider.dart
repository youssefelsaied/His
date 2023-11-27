import 'package:flutter/material.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as Loc;
import 'package:flutter/services.dart';

class MapProvider with ChangeNotifier {
  String? addressName;
  String? streetName;
  String? neighborhoodName;
  LatLng? _gpsactual;
  LatLng _initialposition = LatLng(31.209686461112465, 29.93540107269514);
  bool activegps = true;
  TextEditingController locationController = TextEditingController();
  GoogleMapController? _mapController;
  LatLng? get gpsPosition => _gpsactual;
  LatLng get initialPos => _initialposition;
  final Set<Marker> _markers = Set();
  Set<Marker> get markers => _markers;
  GoogleMapController? get mapController => _mapController;

  void getMoveCamera() async {
    var addresses = await GeocodingPlatform.instance.placemarkFromCoordinates(
        _initialposition.latitude, _initialposition.longitude,
        localeIdentifier: "en_US");
    var first = addresses.first;
    locationController.text = first.name!;
    addressName = first.name;
    streetName = first.administrativeArea;
    neighborhoodName = first.subAdministrativeArea;
    notifyListeners();

    // print(first.featureName);
    // print(first.locality);
  }

  void getUserLocation() async {
    Loc.Location location = Loc.Location();

    bool _serviceEnabled;
    Loc.PermissionStatus _permissionGranted;
    Loc.LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        activegps = false;
        return;
      }
    }
    activegps = true;
    Loc.LocationData position = await location.getLocation();

    _initialposition = LatLng(position.latitude!, position.longitude!);

    var addresses = await GeocodingPlatform.instance.placemarkFromCoordinates(
        _initialposition.latitude, _initialposition.longitude,
        localeIdentifier: "en_US");
    var first = addresses.first;
    locationController.text = first.name.toString();
    addressName = first.name;
    _addMarker(_initialposition, first.name);
    _mapController!.moveCamera(CameraUpdate.newLatLng(_initialposition));
    // print("initial position is : ${first.addressLine}");
    notifyListeners();
  }

  void onCreated(GoogleMapController controller) {
    _mapController = controller;
    changeMapMode();
    notifyListeners();
  }

  changeMapMode() {
    if (true) {
      getJsonFile("assets/dark.json").then(setMapStyle);
    } else {
      getJsonFile("assets/dark.json").then(setMapStyle);
    }
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _mapController!.setMapStyle(mapStyle);
  }

  void _addMarker(LatLng location, String? address) {
    _markers.add(Marker(
        markerId: MarkerId(location.toString()),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "go here"),
        icon: BitmapDescriptor.defaultMarker));
    notifyListeners();
  }

  void onCameraMove(CameraPosition position) async {
    _initialposition = position.target;
    notifyListeners();
  }
}
