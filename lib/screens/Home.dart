import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:thebasiclook/models/data_model.dart';
import 'package:thebasiclook/screens/collection.dart';
import 'package:thebasiclook/screens/search.dart';
import 'package:thebasiclook/widgets/carousel_card.dart';
import 'package:thebasiclook/widgets/customAppBar.dart';
import 'package:thebasiclook/widgets/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
          title: 'HomePage',
        ),
        backgroundColor: Colors.white,
        drawer: CustomDrawer(), //
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showSearch(context: context, delegate: Search());
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.symmetric(
                          horizontal:
                              BorderSide(color: Colors.grey.withOpacity(0.5)))),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Winter Collection Coming Very Soon!',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(
                height: 30,
              ),
              CarouselSlider(
                options: CarouselOptions(
                    aspectRatio: 1,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    viewportFraction: 0.6,
                    enlargeStrategy: CenterPageEnlargeStrategy.scale),
                items: dataList
                    .map((data) => CarouselCard(
                          data: data,
                        ))
                    .toList(),
              ),
            ],
          ),
        ));
  }
}
