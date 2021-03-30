import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_app/Pages/MainPage.dart';
import 'package:password_app/animation/constant.dart';

class FingerAuthPage extends StatefulWidget {
  @override
  _FingerAuthPageState createState() => _FingerAuthPageState();
}

class _FingerAuthPageState extends State<FingerAuthPage> {
  final LocalAuthentication auth = LocalAuthentication();
  // bool _canCheckBiometric = false;
  // List<BiometricType> _availableBiometric;

  String autherized = " Not autherized";

// //Now the functions check biometric sensor

  // Future<void> _checkBiometric() async {
  //   bool canCheckBiometric;
  //   try {
  //     canCheckBiometric = await auth.canCheckBiometrics;
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  //   if (!mounted) return;

  //   setState(() {
  //     _canCheckBiometric = canCheckBiometric;
  //   });
  // }

  Future<void> _authorizeNow() async {
    bool isAuthorized = false;
    try {
      isAuthorized = await auth.authenticateWithBiometrics(
        localizedReason: "Please authenticate to complete your transaction",
        useErrorDialogs: true,
        stickyAuth: true,
        androidAuthStrings: AndroidAuthMessages(
          fingerprintSuccess: "Authenticated",
          cancelButton: "Cancel",
        ),
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (isAuthorized) {
        autherized = "Authorized";
      } else {
        autherized = "Not Authorized";
      }
      if (isAuthorized) {
        isAuthorized = false;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgcolor,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Auth",
                  style: TextStyle(
                    color: appbar,
                    fontSize: 49.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 50.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/fingerprint.png',
                      width: 120.0,
                      color: appbar,
                    ),
                    Text(
                      "FingerPrint",
                      style: TextStyle(
                        color: appbar,
                        fontSize: 20.0,
                        letterSpacing: 7.0,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    // Text("Authorized : $autherized"),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 35.0),
                      width: double.infinity,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        color: card2,
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            30.0,
                          ),
                        ),
                        onPressed: _authorizeNow,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 18.0,
                            horizontal: 25.0,
                          ),
                          child: Text(
                            "Authenticate",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
