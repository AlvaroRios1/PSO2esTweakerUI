import 'package:flutter/material.dart';

import 'package:arks_ui/arks_button.dart';
import 'package:arks_ui/bgm_module.dart';
import 'package:arks_ui/banner_module.dart';

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
      debugShowCheckedModeBanner: false,
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
              height: MediaQuery.of(context).size.height / 35
            ),
            Container(
              height: MediaQuery.of(context).size.height / 12,
              child: padThis(
                  Row(children: <Widget>[
                    Image.asset("assets/images/logo.png"),
                    whiteThis('PSO2es Tweaker'),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  )

                ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3.3,
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
              height: MediaQuery.of(context).size.height / 2.6,
              width: MediaQuery.of(context).size.width / 1.05,
              child: Column(children: <Widget>[
                padThis(
                  Row(children: <Widget>[
                    whiteThis('Game Version: '),
                    CircularProgressIndicator()
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  )

                ),
                padThis(
                  Row(children: <Widget>[
                    whiteThis('English Patch Version: '),
                    CircularProgressIndicator()
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  )

                ),
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

