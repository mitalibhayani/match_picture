import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:match_picture/first.dart';
import 'package:match_picture/second.dart';
import 'package:timer_count_down/timer_count_down.dart';


class game extends StatefulWidget {
  int? lno;
  game([this.lno]);

  @override
  State<game> createState() => _gameState();
}

class _gameState extends State<game> {
  List all_img = [];
  bool t = false;
  List final_img = [];
  List<bool> status = [];
  int click = 1;
  int pos1 = 0;
  int pos2 = 0;
  int sec = 0;
  bool x = false;
  bool x1 = false;
  int cnt = 0;
  int level_no = 0;

  Future get_images() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines
    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('myassets/'))
        .where((String key) => key.contains('.png'))
        .toList();

    setState(() {
      all_img = imagePaths; //someimage is a list
      all_img.shuffle();
      for (int i = 0; i < 6; i++) {
        final_img.add(all_img[i]);
        final_img.add(all_img[i]);
      }
      final_img.shuffle();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("LNO:${widget.lno}");

    if(widget.lno==null){
      level_no = second.prefs!.getInt("levelno") ?? 0;
    }else
    {
      level_no=widget.lno!;
    }
    get_images();
    status = List.filled(12, true);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("you have 5 seconds to memorize all images"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    t = true;
                    x1 = true;
                    setState(() {});
                  },
                  child: Text("OK"))
            ],
          );
        },
      );
    });
  }

  Stream get_time() async* {
    while (sec <= 1000) {
      await Future.delayed(Duration(seconds: 1));
      sec++;
      yield sec;
    }
  }
  // List pic=[];
  // List pic1=[];
  // List match=[];
  // int a=5;
  // int a1=1;
  // int stop1=1;
  // int x=1;
  // int j=0;
  // bool t=false;
  // List<bool> status = [];
  // int pos1=0,pos2=0;
  // int level_no=0;
  // Future _initImages() async {
  //   // >> To get paths you need these 2 lines
  //   final manifestContent = await rootBundle.loadString('AssetManifest.json');
  //
  //   final Map<String, dynamic> manifestMap = json.decode(manifestContent);
  //   // >> To get paths you need these 2 lines
  //
  //   final imagePaths = manifestMap.keys
  //       .where((String key) => key.contains('myassets/image'))
  //       .where((String key) => key.contains('.png'))
  //       .toList();
  //
  //   setState(() {
  //       pic =imagePaths;
  //       pic.shuffle();
  //       for(int i=0;i<6;i++){
  //         pic1.add(pic[i]);
  //         pic1.add(pic[i]);
  //       }
  //       pic1.shuffle();
  //       print(pic);
  //   });
  // }
  // @override
  // void initState() {
  //   // level_no = match.prefs!.getInt("levelno") ?? 0;
  //   print("LNO:${widget.lno}");
  //
  //   if(widget.lno==null){
  //     level_no =!.getInt("levelno") ?? 0;
  //   }else
  //   {
  //     level_no=widget.lno!;
  //   }
  //   WidgetsBinding.instance?.addPostFrameCallback((_) {
  //    showDialog(barrierDismissible: false,
  //      context: context, builder:(context) {
  //      return AlertDialog(title: Container(width: double.infinity,height: 50,color: Colors.teal,alignment: Alignment.center,
  //        child: Text("TIME: NO TIME LIMIT",style: TextStyle(color: Colors.white,fontSize: 25),),),
  //        content: Text("YOU HAVE 5 SECONDS TO MEMORIZE ALL \n IMAGES"),
  //        actions: [
  //          ElevatedButton(onPressed: () {
  //            Navigator.pop(context);
  //            temp =List.filled(12, true);
  //            _initImages();
  //            t=true;
  //            get();
  //            setState(() {
  //
  //            });
  //          }, child: Text("GO")),
  //        ],
  //      );
  //    }, );
  //  });
  //
  // }
  // get()
  // async {
  //   for(int i=5;i>=0;i--)
  //     {
  //         await Future.delayed(Duration(seconds: 1));
  //         a=i;
  //         if(i==0){
  //           temp=List.filled(12, false);
  //         }
  //         setState(() {});
  //     }
  //   for(int i=0;i<100;i++)
  //     {
  //      await Future.delayed(Duration(seconds: 1));
  //      a1=i;
  //      stop1=a1;
  //      if(temp[0] && temp[1] && temp[2] && temp[3] && temp[4] && temp[5]  && temp[6]  && temp[7]  && temp[8]  && temp[9]  && temp[10]  && temp[11])
  //        {
  //          showDialog(context: context, builder: (context) {
  //            return AlertDialog(
  //              alignment: Alignment.center,
  //              title: Text("New Record!"),
  //              content: Text("${a1-1} second \n NO TIME LIMIT \n LEVEL ${widget.lno},\n WLL DONE!"),
  //              actions: [
  //                ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.teal)),
  //                    onPressed: () {
  //                  Navigator.push(context, MaterialPageRoute(builder: (context) {
  //                    return second();
  //                  },));
  //                }, child: Text("OK",style: TextStyle(color: Colors.white),)),
  //              ],
  //            );
  //
  //          },);
  //          break;
  //        }
  //      setState(() {
  //
  //      });
  //     }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (x1)
            ? Countdown(
          seconds: 5,
          build: (BuildContext context, double time) {
            return Text("Time : ${time.toInt()}");
          },
          interval: Duration(seconds: 1),
          onFinished: () {
            print('Timer is done!');
            status = List.filled(12, false);
            x1 = false;
            setState(() {});
          },
        )
            : (x)
            ? StreamBuilder(
          stream: get_time(),
          initialData: 0,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              return Text("Time :${snapshot.data}");
            } else {
              return Text("Time :");
            }
          },
        )
            : Text(""),
      ),
      body: Column(
        children: [
          // Text("Level NO ${level_no}",style: TextStyle(fontSize: 35),),
          (t)
              ? Countdown(
            seconds: 5,
            build: (BuildContext context, double time) {
              return SliderTheme(
                child: Slider(
                  value: time,
                  max: 5,
                  min: 0,
                  activeColor: Colors.black,
                  inactiveColor: Colors.grey,
                  onChanged: (double value) {},
                ),
                data: SliderTheme.of(context).copyWith(
                    trackHeight: 15,
                    thumbColor: Colors.transparent,
                    thumbShape:
                    RoundSliderThumbShape(enabledThumbRadius: 0.0)),
              );
            },
            interval: Duration(seconds: 1),
            onFinished: () {
              print('Timer is done!');
              status = List.filled(12, false);
              x = true;
              setState(() {});
            },
          )
              : Text(""),
          SizedBox(
            height: 100,
          ),
          (t)
              ? Expanded(
              child: GridView.builder(
                itemCount: 12,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      status[index] = true;
                      print("Click:$click");
                      if (click == 1) {
                        print("Pos1:$pos1");
                        click = 3;
                        pos1 = index;
                        Future.delayed(Duration(milliseconds: 200))
                            .then((value) {
                          click = 2;
                          setState(() {});
                        });
                      }
                      if (click == 2) {
                        pos2 = index;
                        click = 3;
                        print("pos2 :$pos2");
                        if (final_img[pos1] == final_img[pos2]) {
                          click = 1;
                          cnt++;
                          if (cnt == 6) {
                            int temp_sec=second.prefs!.getInt("level_time${level_no}") ?? 0;
                            if(sec<temp_sec)
                            {
                              second.prefs!.setInt("level_time${level_no}", sec);
                            }
                            if(widget.lno==null){
                              second.prefs!.setInt("levelno", level_no);
                              level_no++;
                              second.prefs!.setInt("level_time${level_no}", sec);
                            }
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("New Record!."),
                                  content: Column(
                                    children: [
                                      Text(" Seconds : $sec "),
                                      Text(" Level  Completed "),
                                    ],
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return match();
                                                },
                                              ));
                                        },
                                        child: Text("OK"))
                                  ],
                                );
                              },
                            );
                          }
                        } else {
                          Future.delayed(Duration(milliseconds: 200))
                              .then((value) {
                            click = 1;
                            status[pos1] = false;
                            status[pos2] = false;
                            setState(() {});
                          });
                        }
                      }
                      setState(() {});
                    },
                    child: Visibility(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 3),
                            image: DecorationImage(
                                image: AssetImage("${final_img[index]}"))),
                      ),
                      visible: status[index],
                      replacement: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 3), color: Colors.grey),
                      ),
                    ),
                  );
                },
              ))
              : Text("")
        ],
      ),
      //   title: (a==0)?Text("${a1}"):Text("${a}"),
      //
      //   // Countdown(
      //   //   seconds: 5,
      //   //   build: (BuildContext context, double time) => Text(time.toString()) ,
      //   //   interval: Duration(seconds: 1),
      //   //   onFinished: (){
      //   //     print('Timer is Done!');
      //   //     for(int i=0;i<temp.length;i++)
      //   //       {
      //   //         temp[i]=false;
      //   //       }
      //   //     setState(() {});
      //   //   } ,
      //   // ),
      //   backgroundColor: Colors.teal,
      //   actions: [
      //     Center(
      //       child: Text("NO TIME LIMIT"),
      //     ),
      //     IconButton(onPressed: () {
      //
      //     }, icon: Icon(Icons.volume_up)),
      //     IconButton(onPressed: () {
      //
      //     }, icon: Icon(Icons.more_vert)),
      //   ],
      // ),
      // body: Column(
      //   children: [
      //     Expanded(flex: 1,child:Container(
      //       height: double.infinity,
      //       width: double.infinity,
      //       // color: Colors.pink,
      //       child: (t)?
      //       Countdown(seconds: 5, build:(BuildContext context,double time)
      //       {
      //         return SliderTheme(
      //           child: Slider(
      //             value: time,
      //             max: 5,
      //             min: 0,
      //             activeColor: Colors.teal,
      //             inactiveColor: Colors.grey,
      //             onChanged: (double value) {},
      //           ),
      //           data: SliderTheme.of(context).copyWith(
      //               trackHeight: 15,
      //               thumbColor: Colors.transparent,
      //               thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0)
      //           ),
      //         );
      //       },
      //       interval: Duration(seconds: 1),
      //       onFinished: (){
      //         temp =List.filled(12, false);
      //         setState(() {});
      //       } ,
      //       ):Text(""),
      //     ),
      //     ),
      //     Expanded(flex: 8,
      //       child: Container(
      //         child: Column(
      //           children: [
      //             Expanded(flex: 9,
      //               child: GridView.builder(
      //                 itemCount: pic1.length,
      //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 5,mainAxisSpacing: 5),
      //                   itemBuilder: (context, index) {
      //                   return InkWell(
      //                     onTap: () {
      //                       status[index] = true;
      //                       print("Click:$click");
      //                       if (click == 1) {
      //                         print("Pos1:$pos1");
      //                         click = 3;
      //                         pos1 = index;
      //                         Future.delayed(Duration(milliseconds: 200))
      //                             .then((value) {
      //                           click = 2;
      //                           setState(() {});
      //                         });
      //                       }
      //                       if (click == 2) {
      //                         pos2 = index;
      //                         click = 3;
      //                         print("pos2 :$pos2");
      //                         if (final_img[pos1] == final_img[pos2]) {
      //                           click = 1;
      //                           cnt++;
      //                           if (cnt == 6) {
      //                             int temp_sec=match.!.getInt("level_time${level_no}") ?? 0;
      //                             if(sec<temp_sec)
      //                             {
      //                               match.prefs!.setInt("level_time${level_no}", sec);
      //                             }
      //                             if(widget.lno==null){
      //                               level_no++;
      //                               match.prefs!.setInt("levelno", level_no);
      //                               match.prefs!.setInt("level_time${level_no}", sec);
      //                             }
      //                             showDialog(
      //                               context: context,
      //                               builder: (context) {
      //                                 return AlertDialog(
      //                                   title: Text("New Record!."),
      //                                   content: Column(
      //                                     children: [
      //                                       Text(" Seconds : $sec "),
      //                                       Text(" Level  Completed "),
      //                                     ],
      //                                   ),
      //                                   actions: [
      //                                     ElevatedButton(
      //                                         onPressed: () {
      //                                           Navigator.push(context,
      //                                               MaterialPageRoute(
      //                                                 builder: (context) {
      //                                                   return match();
      //                                                 },
      //                                               ));
      //                                         },
      //                                         child: Text("OK"))
      //                                   ],
      //                                 );
      //                               },
      //                             );
      //                           }
      //                         } else {
      //                           Future.delayed(Duration(milliseconds: 200))
      //                               .then((value) {
      //                             click = 1;
      //                             status[pos1] = false;
      //                             status[pos2] = false;
      //                             setState(() {});
      //                           });
      //                         }
      //                       }
      //                       setState(() {});
      //                     },
      //                     child: Visibility(
      //                       child: Container(
      //                         decoration: BoxDecoration(
      //                             border: Border.all(width: 3),
      //                             image: DecorationImage(
      //                                 image: AssetImage("${final_img[index]}"))),
      //                       ),
      //                       visible: status[index],
      //                       replacement: Container(
      //                         decoration: BoxDecoration(
      //                             border: Border.all(width: 3), color: Colors.grey),
      //                       ),
      //                     ),
      //                   );
      //                   },
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),

    );
  }
}
