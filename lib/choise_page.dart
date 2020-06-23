import 'package:flutter/material.dart';

class ChoisePage extends StatelessWidget {
  static bool playAs = true, difficulty = true, playWith = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[300],
      appBar: AppBar(title: Text('Solo Player')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SoloItem('Play as', 'First', 'Second', playAs),
            Divider(endIndent: 50, indent: 50, color: Colors.blueGrey[700]),
            SoloItem('Difficulty', 'Easy', 'Hard', difficulty),
            Divider(endIndent: 50, indent: 50, color: Colors.blueGrey[700]),
            SoloItem('With', 'X', 'O', playWith),
            RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('Start'),
                textColor: Colors.white,
                color: Colors.blueGrey[900],
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'play',
                      arguments: [playAs, difficulty, playWith]);
                }),
          ],
        ),
      ),
    );
  }
}

class SoloItem extends StatefulWidget {
  final String title, text1, text2;
  bool val;
  SoloItem(this.title, this.text1, this.text2, this.val);
  @override
  _SoloItemState createState() => _SoloItemState();
}

class _SoloItemState extends State<SoloItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          widget.title,
          style: TextStyle(fontSize: 18, fontFamily: 'Purisa'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              children: <Widget>[
                Radio(
                    value: true,
                    groupValue: widget.val,
                    onChanged: (v) {
                      setState(() {
                        widget.val = v;
                      });
                      getState();
                    }),
                Text(
                  widget.text1,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Radio(
                    value: false,
                    groupValue: widget.val,
                    onChanged: (v) {
                      setState(() {
                        widget.val = v;
                      });
                      getState();
                    }),
                Text(
                  widget.text2,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void getState() {
    if (widget.text1 == 'First') {
      ChoisePage.playAs = widget.val;
    } else if (widget.text1 == 'Easy') {
      ChoisePage.difficulty = widget.val;
    } else if (widget.text1 == 'X') {
      ChoisePage.playWith = widget.val;
    }
  }
}
