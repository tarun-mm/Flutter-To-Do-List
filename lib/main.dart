import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _tasksCounter = 0;
  List<String> _tasks = [];
  List<bool> _tasksCheck = [];
  List _decoration = [];

  void _showAddTask() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add New Task"),
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Enter New Task",
              ),
              onSubmitted: (text) {
                setState(() {
                  _tasks.add(text);
                  _tasksCheck.add(false);
                  _decoration.add(TextDecoration.none);
                });
                Navigator.of(context).pop();
              },
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
            ],
          );
        });
  }

  Widget _getItems() {
    return ListView.builder(itemBuilder: (context, index) {
      if (index < _tasks.length) {
        return Container(
          margin: EdgeInsets.only(top: 10),
          child: Card(
            color: Color(0xffFF5083),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Dismissible(
              child: ListTile(
                leading: Text(
                  _tasks[index],
                  style: TextStyle(
                    decoration: _decoration[index],
                    decorationThickness: 3,
                    decorationStyle: TextDecorationStyle.wavy,
                    decorationColor: Color(0xffffffff),
                    fontFamily: "RocknRollOne-Regular.ttf",
                  ),
                ),
                trailing: Checkbox(
                  value: _tasksCheck[index],
                  activeColor: Color(0xff000000),
                  onChanged: (bool value) {
                    setState(() {
                      _tasksCheck[index] = value;
                      if (_tasksCheck[index] == true) {
                        _decoration[index] = TextDecoration.lineThrough;
                      } else {
                        _decoration[index] = TextDecoration.none;
                      }
                    });
                  },
                ),
              ),
              background: Card(
                color: Color(0xff76FF03),
                child: Icon(
                  Icons.fact_check,
                  color: Color(0xff000000),
                ),
              ),
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {
                  _tasks.removeAt(index);
                  _tasksCheck.removeAt(index);
                });
              },
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _tasksCounter = 0;
    for (bool tasksData in _tasksCheck) {
      if (tasksData == false) {
        _tasksCounter += 1;
      }
    }

    return Scaffold(
      backgroundColor: Color(0xff000000),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "To-Do",
                        style: TextStyle(
                          color: Color(0xff6200EE),
                          fontSize: 40,
                          fontFamily: "MonotonRegular",
                        ),
                      ),
                      Text(
                        "${_tasksCounter} Tasks left for the day",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Card(
                  margin: EdgeInsets.all(15),
                  color: Color(0xff313335),
                  child: _getItems(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffbb86fc),
        onPressed: () {
          _showAddTask();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add, color: Color(0xff000000),),
      ),
    );
  }
}
