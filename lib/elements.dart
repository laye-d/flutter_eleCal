import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//原子质量库
var eleKeyList = <String>["Ti", "Ni", "Hf", "Cr", "Cu", "Zr", "Al", "V", "Fe", "Co", "Nb", "Mo"];
var eleValueList = <double>[47.867, 58.6934, 178.49, 51.9961, 63.546, 91.2242, 26.9815, 50.9415, 55.8452, 58.9332, 92.9064, 95.962];

//历史成分库calHistoryList
class CalHistory {
  List<String> percentList;
  List<String> eleKeyList;
  List<double> eleValueList;
  CalHistory(this.percentList, this.eleKeyList, this.eleValueList);
}

List<CalHistory> calHistoryList = [];

class ElementsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ElementsPageState();
}

class ElementsPageState extends State {
  var _textFieldController1 = new TextEditingController();
  var _textFieldController2 = new TextEditingController();

  /// SharedPreferences存储数据
//  Future saveString() async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    for (var i = 1; i <= eleKeyList.length; i++) {
//      sharedPreferences.setDouble(eleKeyList[i - 1], eleValueList[i - 1]);
//    }
//    print(sharedPreferences.getKeys());
//  }

  /// 获取SharedPreferences中数据
//  Future getString() async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    setState(() {
//      _storageString = sharedPreferences.get(STORAGE_KEY);
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//        floatingActionButton: FloatingActionButton(
//          child: Icon(Icons.add),
//          onPressed: ,
//        ),
//        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Container(
      padding: EdgeInsets.fromLTRB(
        5.0,
        15.0,
        5.0,
        15.0,
      ),
      child: ListView.builder(
          itemCount: eleKeyList.length,
          itemBuilder: (BuildContext context, i) {
            return Card(
              child: ListTile(

                title: Row(children: [
                  Expanded(flex: 1, child: Center(child: Icon(
                    Icons.hdr_strong,
                    color: Colors.cyan,
                  ),)),
                  Expanded(
                      flex: 1,

                        child: Text(
                          eleKeyList[i],
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.cyan),

                      )),
                  Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          eleValueList[i].toString(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      )),
                  Expanded(
                      flex: 1,

                        child: Center(
                          child: Text(
                            "g/mol",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.cyan),
                          ),
                        ),
                      )
                ]),
              ),
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0.0))),
              elevation: 2.0,
            );
          }),
    ));
  }
}
