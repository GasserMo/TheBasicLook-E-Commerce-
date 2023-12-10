import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:thebasiclook/screens/Home.dart';
import 'package:thebasiclook/screens/loginScreen.dart';
import 'package:thebasiclook/screens/productsScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) => {_checkAccess()});
  }

  void _checkAccess() async {
    var token = await GetStorage().read('token');
    if (token != null) {
      bool isExpired = JwtDecoder.isExpired(token);
      if (isExpired == true) {
        Future.delayed(Duration.zero).then((value) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return LoginScreen();
          }), (route) => false);
        });
      } else {
        Future.delayed(Duration.zero).then((value) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return HomePage();
          }), (route) => false);
        });
      }
    } else {
      Future.delayed(Duration.zero).then((value) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return LoginScreen();
        }), (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final token = GetStorage().read('role');
    return Scaffold(
      body: Center(
        child: Text(
          token ?? '',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
