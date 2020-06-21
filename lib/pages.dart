import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'elements.dart';
import 'main.dart';

class NewComponentPage extends StatefulWidget {
  @override
  NewComponentPageState createState() => new NewComponentPageState();
}

class NewComponentPageState extends State<NewComponentPage> {
  //List<TextEditingController> componentTextControllerList = new List<TextEditingController>(eleKeyList.length);//无效
  List<TextEditingController> componentTextControllerList = new List();

  _saveComponent() {
    ///保存成分配比到History
    List<String> pl = [];
    List<String> ekl = [];
    List<double> evl = [];

    for (var i = 0; i < componentTextControllerList.length; i++) {
//      print(double.parse(componentTextControllerList[i].text.toString()));
      if (componentTextControllerList[i].text.toString() != "") {
        pl.add(componentTextControllerList[i].text.toString());
        ekl.add(eleKeyList[i]);
        evl.add(eleValueList[i]);
      }

      print(pl);
      print(componentTextControllerList.length);
    }

//    print(componentTextControllerList[4].text.toString());

//    print(componentTextControllerList.length);
    if (pl != []) {
      calHistoryList.add(new CalHistory(pl, ekl, evl));
    }

    //print(calHistoryList.length);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("New Component"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
            itemCount: eleKeyList.length,
            itemBuilder: (context, index) {
              componentTextControllerList.add(
                  new TextEditingController()); //！ 事先建好controllerlist无效，需单个add
//            print(componentTextControllerList.length);
              return Card(margin: EdgeInsets.fromLTRB(15.0,00.0,15.0,0.0),elevation: 3.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(flex: 1,child: Container(child: Icon(Icons.pie_chart,color: Colors.cyan,)),),
                      Expanded(
                          flex: 2,
                          child: TextField(
                            controller: componentTextControllerList[index],
                            inputFormatters: [
                              WhitelistingTextInputFormatter(RegExp("[0-9.]"))
                            ], //只允许输入数字和小数点
                          )),
                      Expanded(
                          flex: 1,
                          child: ListTile(
                            title: Text(eleKeyList[index],style: TextStyle(color: Colors.cyan,fontWeight: FontWeight.bold,),),
                          )),
                    ],
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.assignment_turned_in),
        onPressed: () {
          _saveComponent();
          componentTextControllerList = new List();
          homePageController
              .add(calHistoryList = calHistoryList); //StreamController
          //return showDialog(context: context, builder: (context){return AlertDialog(content: Text("--总和是否100"),);});
          Navigator.of(context).pop();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class CalHistoryPage extends StatefulWidget {
  @override
  CalHistoryPageState createState() => new CalHistoryPageState();
}

class CalHistoryPageState extends State<CalHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: calHistoryList.length,
      itemBuilder: (BuildContext context, i) {
        return CalHistoryTile(calHistoryList[i].eleKeyList,
            calHistoryList[i].eleValueList, calHistoryList[i].percentList);
      },
    );
  }
}

class CalHistoryTile extends StatefulWidget {
  List<String> eleKeyList;
  List<double> eleValueList;
  List<String> percentList;
  CalHistoryTile(this.eleKeyList, this.eleValueList, this.percentList);

  @override
  _CalHistoryTileState createState() => _CalHistoryTileState();
}

class _CalHistoryTileState extends State<CalHistoryTile> {
  List<TextEditingController> eleCalRowsTextControllerList = new List();

  List<Row> _createEleCalRows() {
    double percentSum = 0;
    for (int i = 0; i < widget.percentList.length; i++) {
      percentSum = percentSum + double.parse(widget.percentList[i]);
    }
    List<Row> rl = [];
    for (int i = 0; i < widget.eleKeyList.length; i++) {
      eleCalRowsTextControllerList.add(new TextEditingController());
      rl.add(Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: InputChip(
              label: Text(
                widget.eleKeyList[i]
                    .toString(), /////////////////////////////////widget.变量名：使用入参
                style: TextStyle(
                  color: Colors.cyan,
                    fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {},
              elevation: 2,
//                    avatar: Text(
//                      "",
//                      style: TextStyle(color: Colors.cyan),
//                    ),
            ),
          ),
          Expanded(
            flex: 2,
            child: InputChip(
              label: Text(
                widget.percentList[i].toString()+" /"+percentSum.toString(),
                style: TextStyle(color: Colors.cyan,fontWeight: FontWeight.bold),
              ),
              onPressed: () {},
              elevation: 2,
            ),
          ),
          Expanded(
              flex: 2,
              child: TextField(
                controller: eleCalRowsTextControllerList[i],
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp("[0-9.]"))
                ], //只允许输入数字和小数点
                onChanged: (text) {
                  _calculate(text, i);
                }, /////////////////////////////////////////////格，(text){}
              ))
        ],
      ));
    }
    return rl;
  }

  _calculate(String text, int index) {
    print("_calculate");
    setState(() {
      for (int i = 0; i < eleCalRowsTextControllerList.length; i++) {
        double numTemp = double.parse(eleCalRowsTextControllerList[index].text) /
                widget.eleValueList[index] /
                double.parse(widget.percentList[index]) *
                double.parse(widget.percentList[i]) *
                widget.eleValueList[i];
        if(i!=index){
          eleCalRowsTextControllerList[i].text = numTemp.toString();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Column(
              children: _createEleCalRows(),
            ),
            Container(height: 20,),
            FlatButton(padding: EdgeInsets.all(5),
              child: Icon(Icons.delete_sweep,color: Colors.black,),
//              Text(
//                "Clear",
//                style: TextStyle(color: Colors.white),
//              ),
              color: Colors.cyan,
              onPressed: () {
                //print(eleCalRowsTextControllerList[0].text.toString());
                //print(eleCalRowsTextControllerList[1].text.toString());
                for (int i = 0; i < eleCalRowsTextControllerList.length; i++) {
                  eleCalRowsTextControllerList[i].clear();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
