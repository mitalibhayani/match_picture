import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_picture/data.dart';
import 'package:match_picture/second.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: match()
  )
  );
}class match extends StatefulWidget {




  @override
  State<match> createState() => _matchState();
}
class _matchState extends State<match> {

  List <dynamic> l=[
    -0.1,0.1,0.2,0.2,-0.1,-0.1,-0.2,0.1,-0.1,-0.1,0.1,0.2];
//match picture
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Select mode"),
        actions: [
          IconButton(onPressed: () {
          }, icon:Icon(Icons.volume_up)),
          IconButton(onPressed: () {
            print("Edit");
          }, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          Expanded(flex: 5,
              child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.teal.shade50,
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.teal.shade50,
                margin: EdgeInsets.fromLTRB(20, 30, 20,100),
                child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 10,mainAxisSpacing: 5),
                  itemCount: data.img.length,
                  itemBuilder: (context, index) {
                  return Transform(
                    transform: Matrix4.rotationZ(l[index]),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 10.0,
                              spreadRadius: 3.0,
                              offset: Offset(0,2),
                            ),
                          ],
                        border: Border.all(width: 1,color: Colors.black),
                        image: DecorationImage(fit: BoxFit.fill,
                            image: AssetImage("${data.img[index]}")),
                      ),
                    ),
                  );
                },),
              ),
              Column(
                children: [
                  Expanded(flex: 3,
                    child: Container(
                      // height: double.infinity,
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(80, 90, 80, 20),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(style: BorderStyle.solid,color: Colors.teal,width: 4),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: InkWell(onTap:(){
                             Navigator.push(context,MaterialPageRoute(builder: (context) {
                               return second();
                             },));
                           },
                            child: Container(
                                // height: double.infinity,
                                width: double.infinity,
                                margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                                color: Colors.teal,
                                alignment: Alignment.center,
                                child: Text("NO TIME LIMITS",style: TextStyle(color: Colors.white,fontSize: 20)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              // height: double.infinity,
                              width: double.infinity,
                              margin: EdgeInsets.fromLTRB(10, 5, 10,5),
                              color: Colors.teal,
                              alignment: Alignment.center,
                              child: Text("NORMAL",style: TextStyle(color: Colors.white,fontSize: 20)),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              // height: double.infinity,
                              width: double.infinity,
                              margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                              color: Colors.teal,
                              alignment: Alignment.center,
                              child: Text("HARD",style: TextStyle(color: Colors.white,fontSize: 20)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(flex: 1,
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(120, 20, 100, 30),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(style: BorderStyle.solid,color: Colors.teal,width: 4),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              color: Colors.teal,
                              alignment: Alignment.center,
                              child: Text("REMOVE ADS",style: TextStyle(color: Colors.white,fontSize: 10)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(flex: 1,
                    child: Container(
                      // height: double.infinity,
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(50, 20, 50, 30),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(style: BorderStyle.solid,color: Colors.teal,width: 4),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: double.infinity,
                              // width: double.infinity,
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              color: Colors.teal,
                              alignment: Alignment.center,
                              child: Text("SHARE",style: TextStyle(color: Colors.white,fontSize: 15)),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: double.infinity,
                              // width: double.infinity,
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              color: Colors.teal,
                              alignment: Alignment.center,
                              child: Text("MORE GAMES",style: TextStyle(color: Colors.white,fontSize: 15)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
          ),
          Expanded(flex: 1,child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.teal,
          ),
          ),
        ],
      ),
    );
  }
}
