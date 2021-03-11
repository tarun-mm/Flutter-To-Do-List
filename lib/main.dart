import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _tasksCounter = 0;
  List<String> _tasks = [];
  List<bool> _tasksCheck = [];
  List _decoration = [];
  int themeMode = 1;
  List _themes = [
    [
      Color(0xffFF5083), // 0  - Tasks Card
      Color(0xffffffff), // 1  - Wavy line Color
      Color(0xff000000), // 2  - CheckBox tick Color
      Color(0xff76FF03), // 3  - Dismissible background Color
      Color(0xff000000), // 4  - Dismissible icon Color
      Color(0xff000000), // 5  - Background Color Main
      Color(0xff6200EE), // 6  - To Do Color
      Color(0xffffffff), // 7  - Tasks remaining Color
      Color(0xff313335), // 8  - Tasks Container Color
      Color(0xffbb86fc), // 9  - Floating button background
      Color(0xff000000), // 10 - Floating button icon
    ],
    [
      Color(0xffcfd8dc), // 0  - Tasks Card
      Color(0xffffffff), // 1  - Wavy line Color
      Color(0xff26c6da), // 2  - CheckBox tick Color
      Color(0xff76FF03), // 3  - Dismissible background Color
      Color(0xff000000), // 4  - Dismissible icon Color
      Color(0xff26c6da), // 5  - Background Color Main
      Color(0xffffffff), // 6  - To Do Color
      Color(0xffffffff), // 7  - Tasks remaining Color
      Color(0xffffffff), // 8  - Tasks Container Color
      Color(0xff0091ea), // 9  - Floating button background
      Color(0xff000000), // 10 - Floating button icon
    ]
  ];

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
            elevation: 8,
            color: _themes[themeMode][0],
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Dismissible(
              child: ListTile(
                leading: Text(
                  _tasks[index],
                  style: TextStyle(
                    decoration: _decoration[index],
                    decorationThickness: 3,
                    decorationStyle: TextDecorationStyle.wavy,
                    decorationColor: _themes[themeMode][1],
                    fontFamily: "RocknRollOne-Regular.ttf",
                  ),
                ),
                trailing: Checkbox(
                  value: _tasksCheck[index],
                  activeColor: _themes[themeMode][2],
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
                color: _themes[themeMode][3],
                child: Icon(
                  Icons.fact_check,
                  color: _themes[themeMode][4],
                ),
              ),
              key: Key(_tasks[index]),
              onDismissed: (direction) {
                setState(() {
                  _tasks.removeAt(index);
                  _tasksCheck.removeAt(index);
                  _decoration.removeAt(index);
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
      backgroundColor: _themes[themeMode][5],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (themeMode == 1) {
                            themeMode = 0;
                          } else {
                            themeMode = 1;
                          }
                        });
                      },
                      child: Text(
                        "To-Do",
                        style: TextStyle(
                          color: _themes[themeMode][6],
                          fontSize: 40,
                          fontFamily: "MonotonRegular",
                        ),
                      ),
                    ),
                    Text(
                      "${_tasksCounter} Tasks left for the day",
                      style: TextStyle(
                        color: _themes[themeMode][7],
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
                color: _themes[themeMode][8],
                child: _getItems(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _themes[themeMode][9],
        onPressed: () {
          _showAddTask();
        },
        child: Icon(
          Icons.post_add_rounded,
          color: _themes[themeMode][10],
        ),
      ),
    );
  }
}
