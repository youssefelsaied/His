// import 'dart:developer';
// import 'dart:io';
// import 'dart:ui';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:m3ak_user/Providers/auth.dart';
// import 'package:m3ak_user/widgets/custom_dialog.dart';
// import 'package:provider/provider.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// import '../Locale/locale.dart';
// import '../Providers/menu_provider.dart';
// import '../Routes/routes.dart';
// import '../widgets/error_dialog.dart';

// class ScanQr extends StatefulWidget {
//   @override
//   State<ScanQr> createState() => _ScanQrState();
// }

// class _ScanQrState extends State<ScanQr> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

//   Barcode? result;

//   QRViewController? controller;

//   // In order to get hot reload to work we need to pause the camera if the platform
//   // is android, or resume the camera if the platform is iOS.
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller!.pauseCamera();
//     }
//     controller!.resumeCamera();
//   }

//   bool loading = false;
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final notch = MediaQuery.of(context).padding.top;
//     final width = size.width;
//     final height = size.height - notch;
//     var locale = AppLocalizations.of(context)!;

//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Container(
//             height: notch,
//             alignment: Alignment.bottomCenter,
//             color: Color(0xff1D2D35),
//             width: MediaQuery.of(context).size.width,
//           ),
//           Container(
//             height: height * .1,
//             alignment: Alignment.bottomCenter,
//             color: Color(0xff1D2D35),
//             width: MediaQuery.of(context).size.width,
//             child: Row(
//               children: [
//                 Container(
//                   // color: Colors.red,
//                   alignment: Alignment.center,
//                   width: 60,
//                   child: IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: Icon(
//                         Icons.arrow_back_ios,
//                         color: Colors.white,
//                       )),
//                 ),
//                 Container(
//                   alignment: Alignment.center,
//                   width: MediaQuery.of(context).size.width - 120,
//                   child: Text(
//                     locale.scanQrCode!,
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 60,
//                 )
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Container(
//               alignment: Alignment.center,
//               width: MediaQuery.of(context).size.width,
//               color: Color(0xff0E1C24),
//               child: Text(
//                 locale.scanText!,
//                 style: TextStyle(color: Color(0xff707E86), fontSize: 16),
//               ),
//             ),
//           ),
//           Expanded(
//               flex: 5,
//               child: Stack(
//                 children: [
//                   // ignore: dead_code
//                   loading
//                       ? Container(
//                           color: Color(0xff0E1C24),
//                           child: Center(child: CircularProgressIndicator()))
//                       : _buildQrView(context),
//                 ],
//               )),
//         ],
//       ),
//     );
//   }

//   Widget _buildQrView(BuildContext context) {
//     // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//             MediaQuery.of(context).size.height < 400)
//         ? 250.0
//         : 300.0;
//     // To ensure the Scanner view is properly sizes after rotation
//     // we need to listen for Flutter SizeChanged notification and update controller
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//           borderColor: Colors.red,
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: scanArea),
//       onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     final menu = Provider.of<MenuProvider>(context, listen: false);
//     final auth = Provider.of<Auth>(context, listen: false);
//     var locale = AppLocalizations.of(context)!;

//     setState(() {
//       this.controller = controller;
//     });
//     bool scaned = false;
//     controller.scannedDataStream.listen((scanData) async {
//       if (!scaned) {
//         setState(() {
//           scaned = true;
//           loading = true;
//         });
//         final result =
//             await menu.ScanBranch(auth.theUser!.token, scanData.code);
//         if (result) {
//           Navigator.pop(context);
//           print("success");
//           showDialog(
//             context: context,
//             barrierDismissible: true,
//             builder: (BuildContext context) {
//               return CustomDialog(
//                 title: "Scaned Successfully",
//                 msg: "Your Request saved successfully",
//                 icon: Icon(Icons.check),
//                 secondAction: TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text(
//                       locale.cancel!,
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyText1!
//                           .copyWith(color: Theme.of(context).primaryColor),
//                     )),
//               );
//             },
//           );
//         } else {
//           setState(() {
//             scaned = false;
//             loading = false;
//           });
//         }
//       }
//       // setState(() {
//       //   result = scanData;
//       // });
//     });
//   }

//   void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//     log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
//     if (!p) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('No Permission')),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
