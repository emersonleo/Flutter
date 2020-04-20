import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  var items = new List<Item>();

  HomePage() {
    items = [];
  }
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var taskController = TextEditingController();

  void add() {
    if (taskController.text.isEmpty) {
      return;
    }
    setState(() {
      widget.items.add(Item(
        title: taskController.text,
        done: false,
      ));
      taskController.clear();
      save();
    });
  }

  void remove(int index) {
    setState(() {
      widget.items.removeAt(index);
      save();
    });
  }

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((x) => Item.fromJson(x)).toList();
      setState(() {
        widget.items = result;
      });
    }
  }

  Future save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.items));
  }

  __HomePage() {
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextFormField(
        controller: taskController,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Montserrat",
        ),
        decoration: InputDecoration(
          labelText: "Nova Tarefa",
          labelStyle: TextStyle(color: Colors.white),
        ),
      )),
      body: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (BuildContext context, int index) {
            final item = widget.items[index];
            return Dismissible(
              background: Container(color: Colors.red),
              child: CheckboxListTile(
                title: Text(item.title),
                value: item.done,
                onChanged: (bool value) {
                  setState(() {
                    item.done = value;
                    save();
                  });
                },
              ),
              key: Key(item.title),
              onDismissed: (direction) {
                remove(index);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
}
