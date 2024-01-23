import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:img_demo1/game_play.dart';
import 'package:match_picture/img_demo1/game_play.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  static SharedPreferences? prefs;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int level_no = 0;
  List title = ["MATCH 2", "MATCH 3", "MATCH 4", "MATCH 5", "MATCH 6"];
  bool t=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_pref();
  }

  get_pref() async {
    Home.prefs = await SharedPreferences.getInstance();
    level_no = Home.prefs!.getInt("levelno") ?? 0;
    print("LevelNO:$level_no");
    t=true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Picture Puzzle Game"),
      ),
      body: (t) ? ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: title.length,
        itemBuilder: (context, index1) {
          return Container(
            width: 250,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 10)),
            child: Column(
              children: [
                Text("${title[index1]}", style: TextStyle(fontSize: 30)),
                Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        int l_no = (index1 * 10) + index + 1;
                        int l_no1 = (index1 * 10) + index;
                        return (l_no1 <= level_no)
                            ? InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                if(l_no1<level_no){
                                  return Game_Play(l_no1);
                                }else
                                {
                                  return Game_Play();
                                }
                              },
                            ));
                          },
                          child: Container(
                            margin: EdgeInsets.all(20),
                            color: Colors.green,
                            alignment: Alignment.center,
                            child: Wrap(children: [
                              Text(
                                "Level-${l_no} ${Home.prefs!.getInt("level_time${l_no1}") ?? 0}",
                                style: TextStyle(fontSize: 25),
                              ),
                              (l_no1<level_no) ? Text(
                                "s",
                                style: TextStyle(fontSize: 25),
                              ) : Text("")
                            ],),
                          ),
                        ) : Container(
                          margin: EdgeInsets.all(20),
                          color: Colors.blue,
                          alignment: Alignment.center,
                          child: Text(
                            "Level ${l_no}  ",
                            style: TextStyle(fontSize: 25),
                          ),
                        );
                      },
                    )),
              ],
            ),
          );
        },
      ) : CircularProgressIndicator(),
    );
  }
}
