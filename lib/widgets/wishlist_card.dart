import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thebasiclook/widgets/add_to_cart.dart';

class WishlistProductCard extends StatelessWidget {
  const WishlistProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Image.asset(
              'assets/basic.webp',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'LinenF',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
          Text(
            'EGP 200',
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {},
                child: addToCart(context, Colors.black, Colors.white,
                    MediaQuery.of(context).size.height * 0.04, Colors.black)),
          )
        ],
      ),
    );
  }
}
