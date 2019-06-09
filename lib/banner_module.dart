import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

// WIP: replace default info images with PSO2 tweaker pages 
List<String> bannerList = [
  'assets/images/discord2.png',
  'assets/images/donations2.png',
  'assets/images/github2.png',
  'assets/images/PSO2es2.png',
  'assets/images/skillsim.png',
  'assets/images/visiphone.png'
];

class BannerCarousal extends StatefulWidget {
  @override
  _BannerCarousalState createState() => _BannerCarousalState();
}

class _BannerCarousalState extends State<BannerCarousal> {
  String link = "";

  _launchURL(String link) async {
    String url = 'https://flutter.io';
    switch (link) {
      case 'assets/images/discord2.png':
        url = "https://discord.gg/PSO2";
        break;
      case 'assets/images/donations2.png':
        url = "https://www.patreon.com/PSO2";
        break;
      case 'assets/images/github2.png':
        url = "https://github.com/Arks-Layer/PSO2ENPatchCSV#pso2-english-patch";
        break;
      case 'assets/images/PSO2es2.png':
        url = "https://github.com/PolCPP/PSO2es-Translation#phantasy-star-online-2-es-english-translation-project";
        break;
      case 'assets/images/skillsim.png':
        url = "https://arks-layer.com/skillsim/";
        break;
      case 'assets/images/visiphone.png':
        url = "https://pso2.arks-visiphone.com/";
        break;
      default:
        print("Not valid");
        return;
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    CarouselSlider bannerPlay = CarouselSlider(
      viewportFraction: 1.0,
      aspectRatio: 2.0,
      autoPlay: true,
      enlargeCenterPage: false,
      items: bannerList.map(
        (infoPage) {
            return GestureDetector(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Image.asset(
                    infoPage,
                    fit: BoxFit.fill,
                    width: 1000.0,
                    //height: 400.0,
                  ),
                ),
              ),
              onTap: (){
                _launchURL(infoPage);
              }
            );
        },
      ).toList(),
    );

    return Container(
      child: bannerPlay
    );
  }
}
