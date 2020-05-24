import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';//StreamController

import 'elements.dart';
import 'pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: "Element Weight Calculator",stream: homePageController.stream,),//StreamController.stream
    );
  }
}

StreamController homePageController = StreamController();//StreamController

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.stream}) : super(key: key);
  final String title;
  final Stream stream;//Stream
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _tabIndex = 0;
  var _pageList = [
    CalHistoryPage(),
//    FlatButton(child: Text(calHistoryList.length.toString()),onPressed: (){},),

    ElementsPage() //()needed
  ];

  @override
  void initState() {
    super.initState();
    widget.stream.listen((i) {
      calHistoryList = i;
    });//widget.stream.listen
  }

  @override
  void didUpdateWidget( oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _pageList[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.dehaze), title: Text("History")),
          BottomNavigationBarItem(
              icon: Icon(Icons.hdr_strong), title: Text("Elements"))
        ],
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
        currentIndex: _tabIndex,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NewComponentPage();
          }));
        }, //()needed
        tooltip: 'New Component',
        child: Icon(Icons.playlist_add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}


