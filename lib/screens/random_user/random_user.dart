import 'dart:math';

import 'package:flutter/material.dart';
import 'package:imtihon/screens/quiz_app.dart';

class RandomUser extends StatefulWidget {
  Color? color, color2;
  String? username1, username2;
  RandomUser({this.color, this.color2, this.username1, this.username2});
  @override
  _RandomUserState createState() => _RandomUserState();
}

int randomSon = 0;
bool startGame = false;

class _RandomUserState extends State<RandomUser> {
  Widget _quraTashlash = Container(
    height: 150,
    width: 150,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blue),
      color: Colors.white,
      borderRadius: BorderRadius.circular(75),
    ),
  );
  int randomSon = Random().nextInt(2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                color: Colors.white,
                borderRadius: BorderRadius.circular(75),
              ),
              child: _quraTashlash,
            ),
            SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: widget.color,
                    ),
                    Text("${widget.username1}"),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: widget.color2,
                    ),
                    Text("${widget.username2}"),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              child: Text("Qura tashlash"),
              onPressed: () {
                setState(() {
                  _quraTashlash = CircularProgressIndicator();
                  randomSon = Random().nextInt(2);
                  startGame = true;
                });
                Future.delayed(
                  Duration(seconds: 2),
                  () {
                    setState(() {
                      if (randomSon == 0) {
                        _quraTashlash = Container(
                          alignment: Alignment.center,
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: widget.color,
                            borderRadius: BorderRadius.circular(75),
                          ),
                          child: Text(
                            "${widget.username1}\nbirinchi\nboshlaydi",
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else {
                        _quraTashlash = Container(
                          alignment: Alignment.center,
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            color: widget.color2,
                            borderRadius: BorderRadius.circular(75),
                          ),
                          child: Text(
                            "${widget.username2}\nbirinchi\nboshlaydi",
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text("Start Game"),
              onPressed: () {
                if (!startGame) {
                  return null;
                }
                startGameNextPage();
              },
            )
          ],
        ),
      ),
    );
  }

  startGameNextPage() {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizApp(
          color: widget.color,
          color2: widget.color2,
          username1: widget.username1,
          username2: widget.username1,
          randomson:randomSon,
        ),
      ),
    );
  }
}
