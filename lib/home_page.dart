import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[400],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'XO',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 3,
                    color: Colors.blueGrey[900],
                    fontFamily: 'Purisa'),
              ),
              HomeButtons('Solo Player'),
              HomeButtons('Multi Players'),
              SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

class HomeButtons extends StatelessWidget {
  final String title;
  HomeButtons(this.title);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => Navigator.pushNamed(
          context, title == 'Solo Player' ? 'choise' : 'play',
          arguments: title),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.blueGrey[700],
    );
  }
}
