import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class GameDetailsCarousel extends StatelessWidget {
  final List screenshots;

  GameDetailsCarousel({this.screenshots});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: CarouselSlider(
        height: 300.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        items: screenshots.map((screenshot) {
          return Builder(
            builder: (BuildContext _context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                ),
                child: Image.network(
                  screenshot["image"],
                  fit: BoxFit.cover,
                )
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
