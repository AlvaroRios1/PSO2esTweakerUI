import 'package:flutter/material.dart';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class BGM extends StatefulWidget {
  final _BGMState bgm = _BGMState();

  void playBing(){
    bgm.playBing();
  }

  @override
  _BGMState createState() => bgm;
}

class _BGMState extends State<BGM> with WidgetsBindingObserver{
  AudioCache audioPlayer;
  AudioPlayer player;
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    audioPlayer = AudioCache(prefix: 'audio/');
    audioPlayer.loadAll(['crossing.mp3', 'bing.wav']).whenComplete(() async {
      player = await audioPlayer.loop('crossing.mp3');
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    audioPlayer.clearCache();
    audioPlayer = null;
    player = null;
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    super.didChangeAppLifecycleState(state);
    switch(state){
      case AppLifecycleState.inactive:
        player.pause();
        break;
      case AppLifecycleState.resumed:
        player.resume();
        break;
      case AppLifecycleState.suspending:
        player.pause();
        break;
      case AppLifecycleState.paused:
        player.pause();
        break;
    }
  }

  void playBing(){
    audioPlayer.play('bing.wav');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}