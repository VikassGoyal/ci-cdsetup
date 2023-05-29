// import 'package:conet/utils/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
// class GoogleMapForLocation extends StatefulWidget {
//   const GoogleMapForLocation({Key? key}) : super(key: key);
//
//   @override
//   _GoogleMapForLocationState createState() => _GoogleMapForLocationState();
// }
//
// class _GoogleMapForLocationState extends State<GoogleMapForLocation> {
//   final LatLng _initialcameraposition = const LatLng(20.5937, 78.9629);
//   GoogleMapController? _controller;
//   final Location _location = Location();
//
//   void _onMapCreated(GoogleMapController cntlr) {
//     _controller = cntlr;
//     _location.onLocationChanged.listen((l) {
//       _controller?.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
//         ),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColor.primaryColor,
//         elevation: 0.0,
//         leading: InkWell(
//           onTap: () {
//             Navigator.of(context).pop();
//           },
//           child: Row(
//             children: [
//               const Icon(
//                 Icons.arrow_back_sharp,
//                 color: AppColor.whiteColor,
//               ),
//               const SizedBox(
//                 width: 2,
//               ),
//               Text(
//                 "Back",
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyText2!
//                     .apply(color: AppColor.whiteColor),
//               )
//             ],
//           ),
//         ),
//         centerTitle: true,
//         title: Text(
//           "Edit Profile",
//           style: Theme.of(context)
//               .textTheme
//               .headline4!
//               .apply(color: AppColor.whiteColor),
//         ),
//       ),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Stack(
//           children: const [
//             // GoogleMap(
//             //   initialCameraPosition:
//             //       CameraPosition(target: _initialcameraposition),
//             //   mapType: MapType.normal,
//             //   onMapCreated: _onMapCreated,
//             //   myLocationEnabled: true,
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
