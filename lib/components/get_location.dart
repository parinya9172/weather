// import 'package:geolocator/geolocator.dart';


// class Location {
//   double latitude;
//   double longitide;
//   String apiKey = '8b06f7a92d32f24e637b47f97a25ca06';
//   int status;

//   Future<void> getCurrentLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);

//       latitude = position.latitude;
//       longitide = position.longitude;
//     } catch (e) {
//       print(e);
//     }
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

// class GetLocation extends StatefulWidget {
//   const GetLocation({Key? key}) : super(key: key);

//   @override
//   State<GetLocation> createState() => _GetLocationState();
// }

// class _GetLocationState extends State<GetLocation> {
//   String? _currentAddress;
//   Position? _currentPosition;

//   Future<bool> _handleLocationPermission() async {
//   bool serviceEnabled;
//   LocationPermission permission;
  
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('Location services are disabled. Please enable the services'),),);
//     return false;
//   }
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {   
//       ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Location permissions are denied'),),);
//       return false;
//     }
//   }
//   if (permission == LocationPermission.deniedForever) {
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('Location permissions are permanently denied, we cannot request permissions.')));
//     return false;
//   }
//   return true;
// }

// Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handleLocationPermission();

//     if (!hasPermission) return;
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//       setState(() => _currentPosition = position);
//       _getAddressFromLatLng(_currentPosition!);
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }

//   Future<void> _getAddressFromLatLng(Position position) async {
//     await placemarkFromCoordinates(
//             _currentPosition!.latitude, _currentPosition!.longitude)
//         .then((List<Placemark> placemarks) {
//       Placemark place = placemarks[0];
//       setState(() {
//         _currentAddress =
//             '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
//       });
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }