import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BannerCarousal extends StatefulWidget {
  @override
  _BannerCarousalState createState() => _BannerCarousalState();
}

// WIP: replace default info images with PSO2 tweaker pages 
List<String> bannerList = [
  'assets/images/discord2.png',
  'assets/images/donations2.png',
  'assets/images/github2.png',
  'assets/images/PSO2es2.png',
  'assets/images/skillsim.png',
  'assets/images/visiphone.png'
];

class _BannerCarousalState extends State<BannerCarousal> {
  final CarouselSlider bannerPlay = CarouselSlider(
    viewportFraction: 1.0,
    aspectRatio: 2.0,
    autoPlay: true,
    enlargeCenterPage: true,
    items: bannerList.map(
      (infoPage) {
          return Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Image.asset(
              infoPage,
              fit: BoxFit.cover,
              width: 1000.0,
            ),
          ),
        );
      },
    ).toList(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: bannerPlay
    );
  }
}
