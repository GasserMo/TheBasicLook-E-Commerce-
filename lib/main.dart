import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebasiclook/bloc/auth/auth_bloc.dart';
import 'package:thebasiclook/bloc/contact/contact_bloc.dart';
import 'package:thebasiclook/bloc/product/product_bloc.dart';
import 'package:thebasiclook/constants.dart';
import 'package:thebasiclook/screens/cartScreen.dart';
import 'package:thebasiclook/screens/loginScreen.dart';
import 'package:thebasiclook/screens/productsScreen.dart';
import 'package:thebasiclook/screens/registerScreen.dart';
import 'package:thebasiclook/screens/splash_Screen.dart';

void main() async {
  /* WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs=await SharedPreferences.getInstance(); */
  await GetStorage.init();
  Stripe.publishableKey=publishableKey;
/*   FlutterStripe.publishableKey = 'your_publishable_key';
 */
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ContactBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
