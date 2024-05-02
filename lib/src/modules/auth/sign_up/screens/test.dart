// import 'package:flutter/material.dart';
// import 'package:jancargo_app/src/modules/auth/sign_up/screens/capcha.dart';
//
// class Test extends StatefulWidget {
//   const Test({super.key});
//
//   @override
//   State<Test> createState() => _TestState();
// }
//
// class _TestState extends State<Test> {
//   String verifyResult = "";
//
//   // RecaptchaV2Controller recaptchaV2Controller = RecaptchaV2Controller();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('jancargo'),
//       ),
//       body: Stack(
//         children: <Widget>[
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 GestureDetector(
//                   child: Text("SHOW ReCAPTCHA"),
//                   onTap: () {
//                     recaptchaV2Controller.show();
//                   },
//                 ),
//                 Text(verifyResult),
//               ],
//             ),
//           ),
//           RecaptchaV2(
//             apiKey: "6LcjfAspAAAAAKVPiKATYvdeUL4lTWDN7Zx118G2",
//             apiSecret: "6LcjfAspAAAAAIAVYbGW--cojPnKr9Ij_SbxBO2S",
//             autoVerify: true,
//             controller: recaptchaV2Controller,
//             onVerifiedError: (err) {
//               print(err);
//             },
//             onVerifiedSuccessfully: (success) {
//               setState(() {
//                 if (success) {
//                   verifyResult = "You've been verified successfully.";
//                 } else {
//                   verifyResult = "Failed to verify.";
//                 }
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
