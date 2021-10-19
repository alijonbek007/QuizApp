import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:imtihon/screens/random_user/random_user.dart';

class QuizApp extends StatefulWidget {
  Color? color, color2;
  String? username1, username2;
  int? randomson;
  QuizApp({this.color, this.color2, this.username1, this.username2,this.randomson});
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int savolRaqami = 0;
  int natija = 0;

  void answerQuestion(bool togrimi) {
    print(togrimi);
    setState(() {
      savolRaqami++;
      if (togrimi) {
        natija++;
      }
    });
  }

  void restart() {
    setState(() {

      _start=60;
      savolRaqami = 0;
      natija = 0;
    });
  }

  Timer? _timer;
  int _start = 60;
  int ketganVaqt =0;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if(savolRaqami<5){
          if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
        }
      },
    );
  }

  void onTap() {}
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Teztop o'yin"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                
                widget.randomson==1 ?Text(
                  "${widget.username1}",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ):Text(
                 "${widget.username2}",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Time: $_start",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              height: 500,
              child: FutureBuilder(
                future: malumotniOlibKel(),
                builder: (context, AsyncSnapshot snap) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: savolRaqami < 5
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "${snap.data[savolRaqami]["savol"]}",
                                style: TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              ElevatedButton(
                                onPressed: () => answerQuestion(
                                  snap.data[savolRaqami]["javoblar"][0]
                                      ["togrimi"],
                                ),
                                child: Text(
                                  snap.data[savolRaqami]["javoblar"][0]["matn"],
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => answerQuestion(
                                  snap.data[savolRaqami]["javoblar"][1]
                                      ["togrimi"],
                                ),
                                child: Text(
                                  snap.data[savolRaqami]["javoblar"][1]["matn"],
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => answerQuestion(
                                  snap.data[savolRaqami]["javoblar"][2]
                                      ["togrimi"],
                                ),
                                child: Text(
                                  snap.data[savolRaqami]["javoblar"][2]["matn"],
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => answerQuestion(
                                  snap.data[savolRaqami]["javoblar"][3]
                                      ["togrimi"],
                                ),
                                child: Text(
                                  snap.data[savolRaqami]["javoblar"][3]["matn"],
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Natija: $natija/${5}",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Ketgan vaqt: ${60-_start}",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                ElevatedButton.icon(
                                  onPressed: restart,
                                  icon: Icon(Icons.restart_alt),
                                  label: Text("Ketingi O'yinchi"),
                                )
                              ],
                            ),
                          ),
                  );
                },
              ),
            ),
            Container(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  
                  startTimer();
                },
                child: Text("START"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List> malumotniOlibKel() async {
    // 1-step jsonni string korinishida olib kel
    var kelganJson =
        await DefaultAssetBundle.of(context).loadString("assets/data.json");
    // 2-step  json stringni json.decode orqali mapga ogir
    List savollarListi = jsonDecode(kelganJson.toString());
    // 3- step jsonni olibn ishlat
    // debugPrint(mashinaList[0]["car_name"]);
    return savollarListi;
  }
}

// body: Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(20.0),
      //     child: savolRaqami < questionAndAnwer.length
      //         ? Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.stretch,
      //             children: [
      //               Text(
      //                 questionAndAnwer[savolRaqami]["savol"],
      //                 style: TextStyle(
      //                   fontSize: 30,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //               ElevatedButton(
      //                 onPressed: () => answerQuestion(
      //                     questionAndAnwer[savolRaqami]["javoblar"][0]
      //                         ["togrimi"]),
      //                 child: Text(
      //                   questionAndAnwer[savolRaqami]["javoblar"][0]["matn"],
      //                   style: TextStyle(
      //                     fontSize: 20,
      //                   ),
      //                 ),
      //               ),
      //               ElevatedButton(
      //                 onPressed: () => answerQuestion(
      //                     questionAndAnwer[savolRaqami]["javoblar"][1]
      //                         ["togrimi"]),
      //                 child: Text(
      //                   questionAndAnwer[savolRaqami]["javoblar"][1]["matn"],
      //                   style: TextStyle(
      //                     fontSize: 20,
      //                   ),
      //                 ),
      //               ),
      //               ElevatedButton(
      //                 onPressed: () => answerQuestion(
      //                     questionAndAnwer[savolRaqami]["javoblar"][2]
      //                         ["togrimi"]),
      //                 child: Text(
      //                   questionAndAnwer[savolRaqami]["javoblar"][2]["matn"],
      //                   style: TextStyle(
      //                     fontSize: 20,
      //                   ),
      //                 ),
      //               ),
      //               ElevatedButton(
      //                 onPressed: () => answerQuestion(
      //                     questionAndAnwer[savolRaqami]["javoblar"][3]
      //                         ["togrimi"]),
      //                 child: Text(
      //                   questionAndAnwer[savolRaqami]["javoblar"][3]["matn"],
      //                   style: TextStyle(
      //                     fontSize: 20,
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           )
      //         : Center(
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Text(
      //                   "Natija: $natija/${questionAndAnwer.length}",
      //                   style: TextStyle(
      //                       fontSize: 30, fontWeight: FontWeight.bold),
      //                 ),
      //                 ElevatedButton.icon(
      //                   onPressed: restart,
      //                   icon: Icon(Icons.restart_alt),
      //                   label: Text("RESTART"),
      //                 )
      //               ],
      //             ),
      //           ),
      //   ),
      // ),