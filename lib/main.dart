import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PSO2es Tweaker',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MainPage(title: 'PSO2es Tweaker'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    Padding padThis(Widget kid){
      return Padding(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: kid,
      );
    }

    Text whiteThis(String text){
      return Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0
        )
      );
    }

    ArksButton patch = ArksButton(buttonText: "Apply English Patch", size: 150, fontSize: 15,);
    ArksButton update = ArksButton(buttonText: "Install Game Update", size: 150, fontSize: 15,);
    ArksButton start = ArksButton(buttonText: "Start PSO2es", size: 200, fontSize: 20);

    return Scaffold(
      body: Container(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            BGM(),
            Container(
              height: MediaQuery.of(context).size.height / 12,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              foregroundDecoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/banner.png"),
                  fit: BoxFit.contain
                ),
              ),
              child: Container(
                child: BannerCarousal()
              )
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2.9,
              width: MediaQuery.of(context).size.width / 1.05,
              child: Column(children: <Widget>[
                padThis(whiteThis('Game Version: N/A')),
                padThis(whiteThis('English Patch Version: N/A')),
                padThis(Divider(color: Colors.white,)),
                padThis(patch),
                padThis(update),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/outline.png"),
                  fit: BoxFit.fill
                )
              ),
            ),          
            padThis(Divider(color: Colors.blueGrey,)),
            padThis(start),
          ],
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/form.png"),
          fit: BoxFit.cover
        ),
        
      ),
    ));
  }
}

class BGM extends StatefulWidget {
  @override
  _BGMState createState() => _BGMState();
}

class _BGMState extends State<BGM> {
  AudioCache audioPlayer;
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioCache(prefix: 'audio/');
    audioPlayer.load('crossing.mp3').whenComplete((){
      audioPlayer.loop('crossing.mp3');
    });
  }

  @override
  void dispose() {
    audioPlayer.clearCache();
    audioPlayer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//(WIP) include parameter for function to perform tasks (update client, patch client, start game)
class ArksButton extends StatefulWidget {
  ArksButton({@required this.buttonText, @required this.size, @required this.fontSize});
  final String buttonText;
  final double fontSize;
  final double size;
  @override
  _ArksButtonState createState() => _ArksButtonState(buttonText: buttonText, size: size, fontSize: fontSize);
}

class _ArksButtonState extends State<ArksButton> {
  _ArksButtonState({@required this.buttonText, @required this.size, @required this.fontSize});
  final String buttonText;
  final double size;
  final double fontSize;
  final String notPress = "assets/images/button_normal.png";
  final String isPress = "assets/images/button_press.png";
  bool doChange = false;

  @override
  Widget build(BuildContext context) {

    return FlatButton(
      child: Stack(
        children: <Widget>[
          Image.asset(doChange ? isPress : notPress,
            width: size,
            fit: BoxFit.fitHeight
          ),
          Text('$buttonText', style: TextStyle(color: Colors.white, fontSize: fontSize))
        ],
        alignment: AlignmentDirectional.center,
      ),
      onPressed: () {},
      onHighlightChanged: (value){
        setState(() {
          doChange = value;
        });
      },
    );
  }
}

class BannerCarousal extends StatefulWidget {
  @override
  _BannerCarousalState createState() => _BannerCarousalState();
}

//(WIP) replace default info images with PSO2 tweaker pages 
List<String> bannerList = [
  'assets/images/info1.png',
  'assets/images/info2.png',
  'assets/images/info3.png',
  'assets/images/info4.png',
  'assets/images/info5.png'
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
