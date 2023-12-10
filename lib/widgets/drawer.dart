import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thebasiclook/bloc/auth/auth_bloc.dart';
import 'package:thebasiclook/screens/Home.dart';
import 'package:thebasiclook/screens/address.dart';
import 'package:thebasiclook/screens/cartScreen.dart';
import 'package:thebasiclook/screens/contact.dart';
import 'package:thebasiclook/screens/loginScreen.dart';
import 'package:thebasiclook/screens/productsScreen.dart';
import 'package:thebasiclook/services/auth.dart';
import 'package:thebasiclook/services/cart.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('ThebasicLook'),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Pages(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return HomePage();
                    }));
                  },
                  title: 'HOMEPAGE'),
              SizedBox(
                height: 20,
              ),
              Pages(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ProductScreen();
                    }));
                  },
                  title: 'ALL PRODUCTS'),
             
              SizedBox(
                height: 20,
              ),
              Pages(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return CartScreen(
                        selectedSize: '',
                      );
                    }));
                  },
                  title: 'CART'),
              SizedBox(
                height: 20,
              ),
              Pages(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ContactScreen();
                    }));
                  },
                  title: 'Contact Us'),
              SizedBox(
                height: 20,
              ),
              Pages(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return AddressScreen();
                    }));
                  },
                  title: 'Address'),
              Divider(
                thickness: 1,
                endIndent: 50,
                indent: 50,
              ),
              SizedBox(
                height: 20,
              ),
              BlocConsumer<AuthBloc, AuthState>(
              
                listener: (context, state) {
                  if (state is SignOutSuccessState) {
                    
                     Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  })); 
                  }
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is SignOutLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Pages(
                      onTap: () async {
                        BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                      },
                      title: 'Sign Out');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Pages extends StatelessWidget {
  Pages({super.key, required this.onTap, required this.title});
  void Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Text(
          title,
          style: TextStyle(color: Colors.grey, fontSize: 20),
        ));
  }
}
