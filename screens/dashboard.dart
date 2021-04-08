import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool favoriteIcon = false;
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String currentTime = "00:00";
  String completeTime = "00:00";
  void loadFile() async {
    String filepath = await FilePicker.getFilePath();
    int status = await _audioPlayer.play(filepath, isLocal: true);
    if (status == 1) {
      setState(() {
        isPlaying = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      setState(() {
        currentTime = duration.toString().split(".")[0];
      });
    });

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        completeTime = duration.toString().split(".")[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFFce1212),
            Color(0xFFe84545),
            Color(0xFFff005c),
          ])),
        ),
        title: Text("Music App"),
        centerTitle: true,
        actions: [
          IconButton(
            color: Colors.white,
            icon: Icon(favoriteIcon ? Icons.star : Icons.star_border),
            onPressed: () {
              setState(() {
                if (favoriteIcon) {
                  favoriteIcon = false;
                } else {
                  favoriteIcon = true;
                }
              });
            },
          ),
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFFce1212),
          Color(0xFFe84545),
          Color(0xFFff005c),
        ])),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 32.0,
                    ),
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(200),
                          bottomRight: Radius.circular(200)),
                      child: Image.asset(
                        "images/picture5.jpg",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    child: Container(
                      width: 300,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[100],
                              blurRadius: 10.0,
                              spreadRadius: 0.1,
                            )
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              icon: Icon(Icons.fast_rewind), onPressed: () {}),
                          IconButton(
                            icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow),
                            onPressed: () {
                              if (isPlaying) {
                                _audioPlayer.pause();
                                setState(() {
                                  isPlaying = false;
                                });
                              } else {
                                _audioPlayer.resume();
                                setState(() {
                                  isPlaying = true;
                                });
                              }
                            },
                            iconSize: 40.0,
                          ),
                          IconButton(
                              icon: Icon(Icons.fast_forward), onPressed: () {})
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "MUSIC TRACK",
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 300,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[100],
                      blurRadius: 10.0,
                      spreadRadius: 0.1,
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {},
                    color: Colors.red,
                  ),
                  IconButton(
                    icon: Icon(Icons.stop),
                    onPressed: () {
                      _audioPlayer.stop();
                      setState(() {
                        isPlaying = false;
                      });
                    },
                    iconSize: 30.0,
                  ),
                  Text(
                    currentTime,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "/",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    completeTime,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60.0,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        buttonBackgroundColor: Color(0xFFdddddd),
        //color: Color(0xFFce1212),
        backgroundColor: Color(0xFFfa1e0e),
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.black,
          ),
          Icon(Icons.camera_alt, size: 30, color: Colors.black),
          Icon(
            Icons.music_note,
            size: 30,
            color: Colors.black,
          ),
        ],
        onTap: (index) async {
          //Handle button tap
          if (index == 2) {
            loadFile();
          }
        },
      ),
    );
  }
}
