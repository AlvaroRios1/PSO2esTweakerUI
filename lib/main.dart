import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:arks_ui/arks_button.dart';
import 'package:arks_ui/bgm_module.dart';
import 'package:arks_ui/banner_module.dart';
import 'package:arks_ui/helper_functions.dart';

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
  BGM soundController = BGM();
  String target = "http://pso2es.10nub.es/";
  String apkLink = "";
  String patchLink = "";
  String apkVer = "";
  String patchVer = "";
  bool verFetchComplete = false;
  http.Response response;
  File data;
  void callbackButton(bool change) async {
    if(change == true) {
      soundController.playBing();
    }
  }

  Future fetchVer() async {
    response = await http.get(target);
    print(response.body);
    data = await localFile;
    data.writeAsString(response.body);
    data.readAsLines().then(process);
  }

  //TODO: WE CAN'T BE SURE THAT THE LINKS WILL BE ON THESE SPECIFIC LINES,
  //     SO FIND A BETTER WAY TO FEED THROUGH IT.  FOR NOW, ARKS-LAYERS 
  //     PLEASE NEVER CHANGE UP YOUR HTML DOC A LOT K THNX.
  //TODO: IF FAIL TO SUCCESSFULLY PROCESS DATA THEN EXIT OUT AND USE CIRCULAR
  //     LOADING WIDGET IN PLACE OF TEXT
  //Prints are for debugging purposes
  Future process(List<String> linesOfHTML) async {
    int index = 0;
    String sizeOfApk = "http://pso2es.10nub.es/PSO2es_";
    String sizeOfPatch = "http://pso2es.10nub.es/patch";

    for (var i in linesOfHTML){
      //if (index == 69 || index == 70) print(i);
      if (index == 69) apkLink = i.toString();
      if (index == 70) patchLink = i.toString();
      index++;
    }

    int apkIndex = apkLink.indexOf(sizeOfApk) + sizeOfApk.length;
    int patchIndex = patchLink.indexOf(sizeOfPatch) + sizeOfPatch.length; 
    //print(apkIndex);
    //print(patchIndex);

    int i = apkIndex;
    int j = patchIndex;
    while(true){
      if((apkLink[i] + apkLink[i + 1])== ".a") break;
      if(i > 75) break; //fail safe in case html doc in PSO2es.nub website ever changes
      apkVer += apkLink[i];
      i++;
    }
    while(true){
      if(patchLink[j] == '.') break;
      if(j > 75) break; //fail safe in case html doc in PSO2es.nub website ever changes
      patchVer += patchLink[j];
      j++;
    }

    apkLink = sizeOfApk + apkVer + ".apk";
    patchLink = sizeOfPatch +  patchVer + ".zip";
    //print(apkLink);
    //print(patchLink);
    await sleepFetch();
    setState(() {
      verFetchComplete = true;
    });
    //print(apkVer);
    //print(patchVer);
  }

  @override
  void initState() {
    super.initState();
    //Fetch from pso2es.nub html document and then process it
    //TODO: COMPARE STORED VER NUMBERS WITH FETCHED NUMBERS
    //      NOTIFY USER IF THEY NEED TO UPDATE
    precacheImage(AssetImage('assets/images/button_press.png'), context);
    fetchVer();
  }

  //TODO: ON DISPOSE STORE VERSION NUMBERS INTO APPLICATION
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ArksButton patch = ArksButton(buttonText: "Apply English Patch", size: 150, fontSize: 15, callback: callbackButton,);
    ArksButton update = ArksButton(buttonText: "Install Game Update", size: 150, fontSize: 15, callback: callbackButton,);
    ArksButton start = ArksButton(buttonText: "Start PSO2es", size: 200, fontSize: 20, callback: callbackButton,);

    return Scaffold(
      body: Container(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            soundController,
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
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.3,
                  foregroundDecoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/banner.png"),
                      fit: BoxFit.contain
                    ),
                  ),
                ),
                Container(
                  child: BannerCarousal(),
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 3.55,
                ),
              ],
              alignment: AlignmentDirectional.center,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width / 1.05,
              child: Column(children: <Widget>[
                padThis(
                  Row(children: <Widget>[
                    whiteThis('Game Version: '),
                    verFetchComplete ? whiteThis('$apkVer') : CircularProgressIndicator()
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  )
                ),
                verFetchComplete ? Container(height: MediaQuery.of(context).size.height * .0155,) : Container(),
                padThis(
                  Row(children: <Widget>[
                    whiteThis('English Patch Version: '),
                    verFetchComplete ? whiteThis('$patchVer') : CircularProgressIndicator()
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  )
                ),
                verFetchComplete ? Container(height: MediaQuery.of(context).size.height * .0155,) : Container(),
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

