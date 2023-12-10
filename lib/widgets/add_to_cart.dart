import 'package:flutter/material.dart';

Widget addToCart(BuildContext context, Color textColor, Color containerColor,
    double height, Color borderColor) {
  return Container(
      alignment: Alignment.center,
      height: height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: containerColor,
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Text(
        'Add To Cart',
        style: TextStyle(color: textColor),
      ));
}
