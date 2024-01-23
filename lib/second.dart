import 'package:flutter/material.dart';
import 'package:match_picture/data.dart';
import 'package:match_picture/first.dart';
import 'package:match_picture/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

class second extends StatefulWidget {
  @override
  State<second> createState() => _secondState();
  static SharedPreferences? prefs;
}

class _secondState extends State<second> {
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
    second.prefs = await SharedPreferences.getInstance();
    level_no = second.prefs!.getInt("levelno") ?? 0;
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
                                  return game(l_no1);
                                }else
                                {
                                  return game();
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
                                "Level-${l_no} ${second.prefs!.getInt("level_time${l_no1}") ?? 0}",
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


//   int level_no = 0;
//   List title = ["MATCH 2", "MATCH 3", "MATCH 4", "MATCH 5", "MATCH 6"];
//   bool t=false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     get_pref();
//   }
//
//   get_pref() async {
//     level_no = second.prefs!.getInt("levelno") ?? 0;
//     print("LevelNO:$level_no");
//     t=true;
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Picture Puzzle Game"),
//       ),
//       body: (t) ? ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: title.length,
//         itemBuilder: (context, index1) {
//           return Container(
//             width: 250,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//                 border: Border.all(color: Colors.green, width: 10)),
//             child: Column(
//               children: [
//                 Text("${title[index1]}", style: TextStyle(fontSize: 30)),
//                 Expanded(
//                     child: ListView.builder(
//                       itemCount: 10,
//                       itemBuilder: (context, index) {
//                         int l_no = (index1 * 10) + index + 1;
//                         int l_no1 = (index1 * 10) + index;
//                         return (l_no1 <= level_no)
//                             ? InkWell(
//                           onTap: () {
//                             Navigator.push(context, MaterialPageRoute(
//                               builder: (context) {
//                                 if(l_no1<level_no){
//                                   return match(l_no1);
//                                 }else
//                                 {
//                                   return match();
//                                 }
//                               },
//                             ));
//                           },
//                           child: Container(
//                             margin: EdgeInsets.all(20),
//                             color: Colors.green,
//                             alignment: Alignment.center,
//                             child: Wrap(children: [
//                               Text(
//                                 "Level-${l_no} ${second.prefs!.getInt("level_time${l_no1}") ?? 0}",
//                                 style: TextStyle(fontSize: 25),
//                               ),
//                               (l_no1<level_no) ? Text(
//                                 "s",
//                                 style: TextStyle(fontSize: 25),
//                               ) : Text("")
//                             ],),
//                           ),
//                         ) : Container(
//                           margin: EdgeInsets.all(20),
//                           color: Colors.blue,
//                           alignment: Alignment.center,
//                           child: Text(
//                             "Level ${l_no}  ",
//                             style: TextStyle(fontSize: 25),
//                           ),
//                         );
//                       },
//                     )),
//               ],
//             ),
//           );
//         },
//       ) : CircularProgressIndicator(),
//     );
//   }
// }
//

      // body: Column(
      //   children: [
      //     Expanded(flex: 5,
      //         child: Stack(
      //           children: [
      //             Container(
      //               height: double.infinity,
      //               width: double.infinity,
      //               color: Colors.teal.shade50,
      //             ),
      //             Container(
      //               height: double.infinity,
      //               width: double.infinity,
      //               color: Colors.teal.shade50,
      //               margin: EdgeInsets.fromLTRB(30, 60, 20,100),
      //               child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 10,mainAxisSpacing: 5),
      //                 itemCount: data.img.length,
      //                 itemBuilder: (context, index) {
      //                   return Transform(
      //                     transform: Matrix4.rotationZ(l[index]),
      //                     child: Container(
      //                       height: double.infinity,
      //                       width: double.infinity,
      //                       margin: EdgeInsets.all(10),
      //                       alignment: Alignment.center,
      //                       decoration: BoxDecoration(
      //                         color: Colors.white,
      //                         borderRadius: BorderRadius.all(Radius.circular(5)),
      //                         boxShadow: [
      //                           BoxShadow(
      //                             color: Colors.black,
      //                             blurRadius: 10.0,
      //                             spreadRadius: 3.0,
      //                             offset: Offset(0,2),
      //                           ),
      //                         ],
      //                         border: Border.all(width: 1,color: Colors.black),
      //                         image: DecorationImage(fit: BoxFit.fill,
      //                             image: AssetImage("${data.img[index]}")),
      //                       ),
      //                     ),
      //                   );
      //                 },),
      //             ),
      //            Row(
      //               children: [
      //                 Expanded(flex: 7,
      //                   child: ListView.builder(
      //                     scrollDirection: Axis.horizontal,
      //                     itemCount: 6,
      //                   itemBuilder: (context, myindex) {
      //                     return Container(
      //                       height: double.infinity,
      //                       width: 250,
      //                       margin: EdgeInsets.fromLTRB(50, 30, 80, 40),
      //                       decoration: BoxDecoration(
      //                         color: Colors.teal.shade50,
      //                         borderRadius: BorderRadius.all(Radius.circular(10)),
      //                         border: Border.all(style: BorderStyle.solid,color: Colors.teal,width: 4),
      //                       ),
      //                       child: Column(
      //                         children: [
      //                           Expanded(flex: 1,
      //                               child:Row(
      //                                 children: [
      //                                   Expanded(flex: 3
      //                                     ,child: Container(
      //                             alignment: Alignment.center,
      //                                       height: double.infinity,
      //                                       width: double.infinity,
      //                                       margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      //                                       child: Text("MATCH ${myindex+1}",style: TextStyle(fontSize: 20,color: Colors.teal),),
      //                                   ),
      //                                   ),
      //                                   Expanded(child: IconButton(onPressed: () {
      //
      //                                   },icon: Icon(Icons.question_mark_sharp)),
      //                                   ),
      //                                 ],
      //                               ),
      //                           ),
      //                         Divider(
      //                           thickness: 5,color: Colors.teal,
      //                         ),
      //                           Container(alignment: Alignment.center),
      //                           Expanded(flex: 7,
      //                               child: GestureDetector(onTapUp: (details) {
      //                                 // level_no++;
      //                                 Navigator.push(context, MaterialPageRoute(builder: (context) {
      //                                   return game(level_no);
      //                                 },));
      //                             print("hello");
      //                             temp=false;
      //                             setState(() {
      //
      //                             });
      //                           },onTapCancel: () {
      //                             print("hyy");
      //                             temp=false;
      //                             setState(() {
      //
      //                             });
      //                           }, onTapDown: (details) {
      //                                 print("good");
      //                                   if(myindex+1==true)
      //                                     {
      //                                       temp=true;
      //                                     }
      //                                   setState(() {});
      //                                 },
      //                                 child: InkWell(onTap: () {
      //                                   level_no++;
      //                                   Navigator.push(context, MaterialPageRoute(builder: (context) {
      //                                     return game(level_no);
      //                                   },));
      //                                 },
      //                                   child: Container(
      //                                     height: double.infinity,
      //                                     width: double.infinity,
      //                                     child: ListView.builder(
      //                                       itemCount: 10,
      //                                       itemBuilder: (context, index) {
      //                                       return Container(
      //                                         color: (temp==true)?Colors.teal:Colors.teal.shade200,
      //                                         height: 42,
      //                                         width: double.infinity,
      //                                         alignment: Alignment.center,
      //                                         margin: EdgeInsets.fromLTRB(10,5, 10, 5),
      //                                         child: Text("Level ${(myindex*10)+index+1}",style: TextStyle(fontSize: 20,color: Colors.white),),
      //                                       );
      //                                     },),
      //                                   ),
      //                                 ),
      //                               ),
      //                           ),
      //                         ],
      //                       ),
      //
      //
      //                     );
      //                   },),
      //                 ),
      //
      //               ],
      //             ),
      //           ],
      //         )
      //     ),
      //     Expanded(flex: 1,child: Container(
      //       height: double.infinity,
      //       width: double.infinity,
      //       color: Colors.teal,
      //     ),
      //     ),
      //
      //   ],
      // ),
//       );
//   }
// }
