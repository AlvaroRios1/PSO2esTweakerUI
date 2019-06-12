import 'package:flutter/material.dart';
import 'package:arks_ui/bgm_module.dart';

//(WIP) include parameter for function to perform tasks (update client, patch client, start game)
class ArksButton extends StatefulWidget {
  ArksButton({@required this.buttonText, @required this.size, @required this.fontSize, @required this.callback});
  final String buttonText;
  final double fontSize;
  final double size;
  final Function (bool) callback;
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
          widget.callback(value);
        });
      },
    );
  }
}