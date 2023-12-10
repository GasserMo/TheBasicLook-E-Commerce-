import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(
    {required String title,
    void Function()? onPressed, // Add this parameter
    Icon? leadingIcon}) {
  return AppBar(
    scrolledUnderElevation: 0,
    elevation: 0,
    backgroundColor: Colors.white, // Set a background color
    actions: [
      Icon(
        Icons.shopping_bag_outlined,
      ),
    ],
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
      ],
    ),
  );
}
