import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gim/style.dart';
import 'package:video_player/video_player.dart';

class Video_Info extends StatefulWidget {
  const Video_Info({Key? key}) : super(key: key);

  @override
  State<Video_Info> createState() => _Video_InfoState();
}

class _Video_InfoState extends State<Video_Info> {
  List video_Info = [];
  bool _playArea = false;
  late VideoPlayerController _controller;

  _initData() async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/json/video_info.json");
    if (data != null) {
      setState(() {
        video_Info = json.decode(data);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: _playArea == false
            ? BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.black,
            ],
            begin: Alignment.topLeft,
          ),
        )
            : BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.blue,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0, left: 18, right: 18),
              child: _playArea == false
                  ? Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.arrow_back_ios, color: Colors.white,),
                      Expanded(child: Container()),
                      Icon(Icons.info, color: Colors.white,),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          children: [
                            Text("Legs Toning\n and Glutes Workout", style: appStyle(20, FontWeight.bold, Colors.white),),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: [
                        Container(
                          width: 85,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(.3),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.timer_outlined, color: Colors.white,),
                              Text("60 min", style: appStyle(15, FontWeight.bold, Colors.white),),
                            ],
                          ),
                        ),
                        Expanded(child: Container()),
                        Container(
                          width: 230,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(.3),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.handyman_outlined, color: Colors.white,),
                              Text("Resistent band, kettlebell", style: appStyle(15, FontWeight.bold, Colors.white),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  : Container(
                height: 120,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.arrow_back_ios, size: 20, color: Colors.white,),
                        Expanded(child: Container()),
                        Icon(Icons.info_outline, size: 20, color: Colors.white,)
                      ],
                    ),
                    _playView(context),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(80)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Circuit 1: Legs Toning", style: appStyle(20, FontWeight.bold, Colors.black),),
                          SizedBox(width: 70,),
                          Icon(Icons.loop_outlined),
                          Text("3 sets", style: appStyle(15, FontWeight.bold, Colors.grey),),
                        ],
                      ),
                      Expanded(
                        child: _ListView(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return Container(
        width: 300,
        height: 300,
        child: VideoPlayer(controller),
      );
    } else {
      return Text("Initializing, please wait");
    }
  }

  void _onTapVideo(int index) {
    final controller = VideoPlayerController.network(video_Info[index]["videoUrl"]);
    _controller = controller;
    setState(() {});

    controller.initialize().then((_) {
      _controller.play();
      setState(() {});
    });
  }

  Widget _ListView() {
    return ListView.builder(
      itemCount: video_Info.length,
      itemBuilder: (_, int index) {
        return GestureDetector(
          onTap: () {
            _onTapVideo(index);
            debugPrint(index.toString());
            setState(() {
              if (_playArea == false) {
                _playArea = true;
              }
            });
          },
          child: Container(
            width: 200,
            height: 135,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        image: DecorationImage(
                          image: AssetImage(video_Info[index]["thumbnail"]), fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            video_Info[index]["title"],
                            style: appStyle(14, FontWeight.bold, Colors.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(video_Info[index]["time"], style: appStyle(12, FontWeight.normal, Colors.grey),),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(child: Text("15s rest", style: appStyle(12, FontWeight.bold, Colors.black),)),
                    ),
                    SizedBox(width: 10,),
                    Row(
                      children: [
                        for (int i = 0; i < 80; i++)
                          i.isEven
                              ? Container(
                            width: 3,
                            height: 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                            ),
                          )
                              : Container(
                            width: 3,
                            height: 2,
                            color: Colors.white,
                          )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
