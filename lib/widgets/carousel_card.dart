import 'package:thebasiclook/bloc/product/product_bloc.dart';
import 'package:thebasiclook/models/data_model.dart';

import 'package:flutter/material.dart';
import 'package:thebasiclook/screens/collection.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({super.key, required this.data});
  final DataModel data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(
              20,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return CollectionScreen(
                    title: data.title,
                  );
                }));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        color: Colors.black26)
                  ],
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage(data.image), fit: BoxFit.fill),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 20,
          ),
          child: Text(
            data.title,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
