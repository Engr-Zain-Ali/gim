import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gim/style.dart';
import 'package:gim/video_info.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List info = [];

  _initData() async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/json/info.json");
    setState(() {
      info = json.decode(data);
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18),
            child: Row(
              children: [
                Text("Training",style: appStyle(20, FontWeight.bold, Colors.black),),
                Expanded(child: Container()),
                Icon(Icons.arrow_back_ios),
                Icon(Icons.shopping_basket_outlined),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18),
            child: Row(
              children: [
                Text("Your Program",style: appStyle(16, FontWeight.bold,Colors.black),),
                Expanded(child: Container()),
                Text("Details",style: appStyle(16, FontWeight.bold,Color(0xfffc5ceff)),),
                GestureDetector(
                    onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Video_Info())),
                    child: Icon(Icons.arrow_forward)),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width*0.87,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black,
                    Colors.blue.withOpacity(.8),
                  ]
              ),
              borderRadius: BorderRadius.only(topRight: Radius.circular(80)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Text("Next workout",style: appStyle(16, FontWeight.normal, Colors.white),),
                  Text("Legs Toning\nand Glutes Workout",style: appStyle(20, FontWeight.normal, Colors.white),),
                  SizedBox(height: 40,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Icons.timer_outlined,color: Colors.white,size: 16,),
                      SizedBox(width: 5,),
                      Text("60 min",style: appStyle(12, FontWeight.normal, Colors.white),),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Container(
                          decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue,
                                  blurRadius: 10,
                                  spreadRadius: 10,
                                )
                              ]
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.play_arrow,color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Stack( // Wrap the contents in a Stack widget
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 100,
                              offset: Offset(0, 0),
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage('assets/images/image003.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18.0, top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "You are doing great",
                                  style: appStyle(16, FontWeight.bold, Colors.black),
                                ),
                                Text(
                                  "Keep it up\nstick to your plan",
                                  style: appStyle(16, FontWeight.bold, Colors.black.withOpacity(.5)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 10),
                child: Container(
                  child: Text(
                    'Area of Field',
                    style: appStyle(20, FontWeight.bold, Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: info.length,
               itemBuilder: (_, i) {
              //   int a=2*i;
              //   int b=2*i+1;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 58),
                  child: Row(
                    children: [
                      Container(

                        width: 120,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.2),
                          borderRadius: BorderRadius.circular(30),

                          image: DecorationImage(
                            image: AssetImage(info[i]['img']),
                          ),
                        ),
                        child: Center(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(info[i]['title'],style: appStyle(20, FontWeight.bold, Colors.black),),
                          ),
                        ),
                      ),
                      Expanded(child: Container()),

                      //SizedBox(height: 5,),

                      Container(
                        width: 120,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.2),
                          borderRadius: BorderRadius.circular(30),

                          image: DecorationImage(
                            image: AssetImage(info[i]['img']),
                          ),
                        ),
                        child: Center(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(info[i]['title'],style: appStyle(20, FontWeight.bold, Colors.black),),
                          ),
                        ),

                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
