import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class PlayPage extends StatefulWidget {
  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  bool finished = false;
  bool firstPlayed = true;
  var mode;
  String player;
  List<Color> colors = List.filled(9, null);
  List<String> xo = List.filled(9, '');
  List<List<int>> position = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  @override
  Widget build(BuildContext context) {
    mode = ModalRoute.of(context).settings.arguments;
    if (mode is List) {
      player = mode[2] ? 'X' : 'O';
      if (firstPlayed && !mode[0]) {
        Timer(Duration(milliseconds: 700), () {
          xo[Random().nextInt(9)] = player == 'X' ? 'O' : 'X';
          setState(() {});
        });
        firstPlayed = false;
      }
    }
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        title: Text(mode is List ? 'Solo Player' : mode),
      ),
      floatingActionButton: finished
          ? FloatingActionButton(
              child: Icon(Icons.replay),
              onPressed: () => Navigator.pushReplacementNamed(context, 'play',
                  arguments: mode),
            )
          : null,
      body: Column(
        children: <Widget>[
          for (int i = 0; i < 3; i++)
            Expanded(
              child: Column(
                children: <Widget>[
                  Divider(
                    height: 0,
                    thickness: 15,
                    color: Colors.blueGrey,
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        makeButton(0 + i * 3),
                        Container(
                          width: 15,
                          color: Colors.blueGrey,
                        ),
                        makeButton(1 + i * 3),
                        Container(
                          width: 15,
                          color: Colors.blueGrey,
                        ),
                        makeButton(2 + i * 3),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  Widget makeButton(int index) {
    return Expanded(
      child: FlatButton(
        color: colors[index],
        child: Text(
          xo[index],
          style: TextStyle(fontSize: MediaQuery.of(context).size.width / 4),
        ),
        onPressed: () {
          if (!finished && xo[index] == '')
            setState(() {
              if (mode is List) {
                mode[1] ? soloPlayerEasy(index) : soloPlayerHard(index);
              } else {
                multiPlayer(index);
              }
            });
        },
      ),
    );
  }

  void soloPlayerEasy(int index) {
    xo[index] = player;
    if (isFinishedAll()) {
      finished = true;
    }
    Timer(Duration(milliseconds: 500), () {
      player = (player == 'X') ? 'O' : 'X';
      while (!finished) {
        int rand = Random().nextInt(9);
        if (xo[rand] == '') {
          xo[rand] = player;
          if (isFinishedAll()) {
            finished = true;
          }
          break;
        }
      }
      setState(() {});
    });
  }

  void soloPlayerHard(int index) {
    xo[index] = player;
    if (isFinishedAll()) {
      finished = true;
    }
    if (!finished)
      Timer(Duration(milliseconds: 500), () {
        player = (player == 'X') ? 'O' : 'X';
        hardPlayer();
        if (isFinishedAll()) {
          finished = true;
        }
        setState(() {});
      });
  }

  void hardPlayer() {
    bool played = false;

    for (int i = 0; i < position.length; i++) {
      if (hardWin(position[i][0], position[i][1], position[i][2])) {
        played = true;
        break;
      }
    }
    if (!played) {
      for (int i = 0; i < position.length; i++) {
        if (hardDefence(position[i][0], position[i][1], position[i][2])) {
          played = true;
          break;
        }
      }
    }

    while (!played) {
      int rand = Random().nextInt(9);
      if (xo[rand] == '') {
        xo[rand] = player;
        break;
      }
    }
  }

  bool hardWin(int x, int y, int z) {
    if (xo[x] == xo[y] && xo[y] == player && xo[z] == '') {
      xo[z] = player;
      return true;
    } else if (xo[y] == xo[z] && xo[z] == player && xo[x] == '') {
      xo[x] = player;
      return true;
    } else if (xo[x] == xo[z] && xo[z] == player && xo[y] == '') {
      xo[y] = player;
      return true;
    } else
      return false;
  }

  bool hardDefence(int x, int y, int z) {
    if (xo[x] == xo[y] && xo[y] != player && xo[y] != '' && xo[z] == '') {
      xo[z] = player;
      return true;
    } else if (xo[y] == xo[z] &&
        xo[z] != player &&
        xo[z] != '' &&
        xo[x] == '') {
      xo[x] = player;
      return true;
    } else if (xo[x] == xo[z] &&
        xo[z] != player &&
        xo[z] != '' &&
        xo[y] == '') {
      xo[y] = player;
      return true;
    } else
      return false;
  }

  void multiPlayer(int index) {
    player = (player == 'X') ? 'O' : 'X';
    xo[index] = player;
    if (isFinishedAll()) {
      finished = true;
    }
  }

  bool isFinishedAll() {
    if (isWin(0, 1, 2))
      return true;
    else if (isWin(3, 4, 5))
      return true;
    else if (isWin(6, 7, 8))
      return true;
    else if (isWin(0, 3, 6))
      return true;
    else if (isWin(1, 4, 7))
      return true;
    else if (isWin(2, 5, 8))
      return true;
    else if (isWin(0, 4, 8))
      return true;
    else if (isWin(2, 4, 6))
      return true;
    else if (!xo.contains(''))
      return true;
    else
      return false;
  }

  bool isWin(int x, int y, int z) {
    if (xo[x] == xo[y] && xo[y] == xo[z] && xo[z] != '') {
      colors[x] = Colors.blueGrey[700];
      colors[y] = Colors.blueGrey[700];
      colors[z] = Colors.blueGrey[700];
      return true;
    } else
      return false;
  }
}
