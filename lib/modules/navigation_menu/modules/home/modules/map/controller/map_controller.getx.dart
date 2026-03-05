import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class ImportantPlace {
  final String name;
  final String type;
  final double lat;
  final double lng;
  final String description;

  ImportantPlace({
    required this.name,
    required this.type,
    required this.lat,
    required this.lng,
    required this.description,
  });
}

final List<ImportantPlace> importantPlaces = [
  ImportantPlace(
    name: "Lidl",
    type: "shopping",
    lat: 50.044749,
    lng: 4.332076,
    description: "importantPlacesLidl".tr,
  ),
  ImportantPlace(
    name: "Action",
    type: "shopping",
    lat: 50.044706,
    lng: 4.333087,
    description: "importantPlacesAction".tr,
  ),
  ImportantPlace(
    name: "Aldi",
    type: "shopping",
    lat: 50.0463808,
    lng: 4.3262819,
    description: "importantPlacesAldi".tr,
  ),
  ImportantPlace(
    name: "Hubo",
    type: "shopping",
    lat: 50.0454782,
    lng: 4.3302141,
    description: "importantPlacesHubo".tr,
  ),
  ImportantPlace(
    name: "Bancontact",
    type: "bank",
    lat: 50.044745,
    lng: 4.333048,
    description: "importantPlacesBancontact".tr,
  ),
  ImportantPlace(
    name: "BNP Paribas",
    type: "bank",
    lat: 50.0479152,
    lng: 4.3167129,
    description: "importantPlacesBNPParibas".tr,
  ),
  ImportantPlace(
    name: "Belfius",
    type: "bank",
    lat: 50.0490587,
    lng: 4.316693,
    description: "importantPlacesBelfius".tr,
  ),
  ImportantPlace(
    name: "Administration Communale",
    type: "government",
    lat: 50.046928,
    lng: 4.317538,
    description: "importantPlacesAdministrationCommunale".tr,
  ),
  ImportantPlace(
    name: "Chimay Gare",
    type: "busStation",
    lat: 50.0484126,
    lng: 4.3197627,
    description: "importantPlacesChimayGare".tr,
  ),
];

class ImportantPlacesController extends GetxController {
  BitmapDescriptor? shoppingIcon;
  BitmapDescriptor? bankIcon;
  BitmapDescriptor? governmentIcon;
  BitmapDescriptor? busIcon;

  static const CameraPosition initialPosition = CameraPosition(
    target: LatLng(50.048328, 4.31183),
    zoom: 14,
  );

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  final Location location = Location();

  var selectedCategory = "all".obs;
  var selectedPlace = Rxn<ImportantPlace>();
  var userPosition = Rxn<LatLng>();

  RxBool isNormalType = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCustomMarkers();
    _getUserLocation();
  }

  // فلترة الماركر
  Set<Marker> get markers {
    return importantPlaces
        .where(
          (place) =>
              selectedCategory.value == "all" ||
              place.type == selectedCategory.value,
        )
        .map(
          (place) => Marker(
            markerId: MarkerId(place.name),
            position: LatLng(place.lat, place.lng),
            icon: _getMarkerIcon(place.type),
            onTap: () => selectedPlace.value = place,
          ),
        )
        .toSet();
  }

  BitmapDescriptor _getMarkerIcon(String type) {
    switch (type) {
      case "shopping":
        return shoppingIcon ?? BitmapDescriptor.defaultMarker;
      case "bank":
        return bankIcon ?? BitmapDescriptor.defaultMarker;
      case "government":
        return governmentIcon ?? BitmapDescriptor.defaultMarker;
      case "busStation":
        return busIcon ?? BitmapDescriptor.defaultMarker;
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    final currentLocation = await location.getLocation();
    userPosition.value = LatLng(
      currentLocation.latitude!,
      currentLocation.longitude!,
    );
  }

  double? calculateDistance(ImportantPlace place) {
    if (userPosition.value == null) return null;

    final distance = Geolocator.distanceBetween(
      userPosition.value!.latitude,
      userPosition.value!.longitude,
      place.lat,
      place.lng,
    );

    return distance;
  }

  Future<void> goToMyLocation() async {
    if (userPosition.value == null) return;

    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(userPosition.value!, 16),
    );
  }

  Future<void> openNavigation(ImportantPlace place) async {
    final url = Uri.parse(
      "google.navigation:q=${place.lat},${place.lng}&mode=d",
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  var markersLoaded = false.obs;

  Future<void> _loadCustomMarkers() async {
    shoppingIcon = await _createColoredMarker(
      "assets/icons/bag.png",
      Colors.orange.shade300,
    );

    bankIcon = await _createColoredMarker(
      "assets/icons/bank.png",
      Colors.indigo.shade300,
    );

    governmentIcon = await _createColoredMarker(
      "assets/icons/government.png",
      Colors.purple.shade300,
    );

    busIcon = await _createColoredMarker(
      "assets/icons/bus.png",
      Colors.green.shade300,
    );
    markersLoaded.value = true;
    update();
  }

  Future<BitmapDescriptor> _createColoredMarker(
    String assetPath,
    Color borderColor,
  ) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Uint8List bytes = data.buffer.asUint8List();

    final ui.Codec codec = await ui.instantiateImageCodec(
      bytes,
      targetWidth: 80,
    );
    final ui.FrameInfo fi = await codec.getNextFrame();
    final ui.Image image = fi.image;

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    const double size = 120;
    const double center = size / 2;

    final Paint whitePaint = Paint()..color = borderColor;
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    // ظل
    canvas.drawShadow(
      Path()
        ..addOval(Rect.fromCircle(center: Offset(center, center), radius: 45)),
      Colors.black,
      6,
      true,
    );

    // دائرة بيضاء
    canvas.drawCircle(Offset(center, center), 60, whitePaint);

    // بوردر ملون
    canvas.drawCircle(Offset(center, center), 60, borderPaint);

    // رسم الأيقونة داخل الدائرة
    canvas.drawImage(
      image,
      Offset(center - image.width / 2, center - image.height / 2),
      Paint(),
    );

    final ui.Image finalImage = await recorder.endRecording().toImage(
      size.toInt(),
      size.toInt(),
    );

    final ByteData? byteData = await finalImage.toByteData(
      format: ui.ImageByteFormat.png,
    );

    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }

  void switchMapType() {
    isNormalType.value = !isNormalType.value;
  }
}
